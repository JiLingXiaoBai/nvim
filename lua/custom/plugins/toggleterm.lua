return {
  'akinsho/toggleterm.nvim',
  version = '*',
  cmd = { 'ToggleTerm' },
  keys = {
    { '<C-\\>', ':ToggleTerm<CR>', mode = '', desc = 'Toggle Terminal' },
  },
  opts = {
    open_mapping = [[<c-\>]],
    start_in_insert = true,
    direction = 'float',
    hide_numbers = true,
    shell = vim.o.shell,
    auto_scroll = true,
  },
}
