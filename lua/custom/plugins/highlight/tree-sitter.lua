-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    local nvim_treesitter = require 'nvim-treesitter'
    nvim_treesitter.setup()
    local ensure_installed = { 'bash', 'c', 'cpp', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'rust', 'vim', 'vimdoc' }
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
      group = vim.api.nvim_create_augroup('custom-treesitter-filetype', { clear = true }),
      pattern = pattern,
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
