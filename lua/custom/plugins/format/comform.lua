-- Autoformat
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local filetypes = { lua = true, c = true, cpp = true, cs = true }
      if filetypes[vim.bo[bufnr].filetype] then
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      else
        return nil
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      cs = { 'clang_format' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    formatters = {
      clang_format = {
        prepend_args = {
          '--style={BasedOnStyle: LLVM, IndentWidth: 4, DerivePointerAlignment: false, PointerAlignment: Left}',
        },
      },
    },
  },
}
