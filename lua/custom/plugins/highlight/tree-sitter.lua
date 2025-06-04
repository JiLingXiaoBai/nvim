-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  config = function()
    local nvim_treesitter = require 'nvim-treesitter'
    nvim_treesitter.setup()

    local ensure_installed = { 'bash', 'c', 'cpp', 'c_sharp', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
    local pattern = {}
    for _, parser in ipairs(ensure_installed) do
      local has_parser, _ = pcall(vim.treesitter.language.inspect, parser)

      if not has_parser then
        nvim_treesitter.install(parser)
      else
        pattern = vim.tbl_extend('keep', pattern, vim.treesitter.language.get_filetypes(parser))
      end
    end
    vim.api.nvim_create_autocmd('FileType', {
      pattern = pattern,
      callback = function()
        vim.treesitter.start()
      end,
    })
    vim.api.nvim_exec_autocmds('FileType', {})
  end,
}
