local M = {}

M.setup = function()
  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('custom-highlight-yank', { clear = true }),
    callback = function()
      vim.hl.on_yank()
    end,
  })

  vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = vim.api.nvim_create_augroup('custom-autoformat-filetype', { clear = true }),
    pattern = { 'c', 'cpp', 'cs', 'md', 'txt', 'c.snippets', 'cpp.snippets', 'cs.snippets' },
    callback = function()
      vim.b.autoformat = true
    end,
  })

  vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('custom-cursorset', { clear = true }),
    callback = function()
      if vim.fn.line '\'"' > 0 and vim.fn.line '\'"' <= vim.fn.line '$' then
        vim.fn.setpos('.', vim.fn.getpos '\'"')
        vim.cmd 'silent! foldopen'
      end
    end,
  })

  vim.api.nvim_create_autocmd('TermOpen', {
    pattern = 'term://*',
    group = vim.api.nvim_create_augroup('custom-terminalkeymap', { clear = true }),
    callback = require('custom.keymaps').set_terminal_keymaps,
  })
end

local lsp_highlight = function(buffer)
  local highlight_augroup = vim.api.nvim_create_augroup('custom-lsp-highlight', { clear = false })
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    buffer = buffer,
    group = highlight_augroup,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    buffer = buffer,
    group = highlight_augroup,
    callback = vim.lsp.buf.clear_references,
  })

  vim.api.nvim_create_autocmd('LspDetach', {
    group = vim.api.nvim_create_augroup('custom-lsp-detach', { clear = true }),
    callback = function(event)
      vim.lsp.buf.clear_references()
      vim.api.nvim_clear_autocmds { group = 'custom-lsp-highlight', buffer = event.buf }
    end,
  })
end

--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
M.setup_lsp_attach = function()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('custom-lsp-attach', { clear = true }),
    callback = function(event)
      -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
      ---@param client vim.lsp.Client
      ---@param method vim.lsp.protocol.Method
      ---@param bufnr? integer some lsp support methods only in specific files
      ---@return boolean
      local function client_supports_method(client, method, bufnr)
        if vim.fn.has 'nvim-0.11' == 1 then
          return client:supports_method(method, bufnr)
        else
          ---@diagnostic disable-next-line: param-type-mismatch
          return client.supports_method(method, { bufnr = bufnr })
        end
      end
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      local support_inlay_hint = client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
      local support_highlight = client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)

      -- Setup keymaps
      require('custom.keymaps').set_lsp_keymaps(event.buf, support_inlay_hint)
      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      if support_highlight then
        lsp_highlight(event.buf)
      end
    end,
  })
end

M.setup_neotree_init = function()
  vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
    desc = 'Start Neo-tree with directory',
    once = true,
    callback = function()
      if package.loaded['neo-tree'] then
        return
      else
        ---@diagnostic disable-next-line: param-type-mismatch
        local stats = vim.uv.fs_stat(vim.fn.argv(0))
        if stats and stats.type == 'directory' then
          require 'neo-tree'
        end
      end
    end,
  })
end

M.setup_lint = function(lint)
  local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    group = lint_augroup,
    callback = function()
      -- Only run the linter in buffers that you can modify in order to
      -- avoid superfluous noise, notably within the handy LSP pop-ups that
      -- describe the hovered symbol using Markdown.
      if vim.bo.modifiable then
        lint.try_lint()
      end
    end,
  })
end

return M
