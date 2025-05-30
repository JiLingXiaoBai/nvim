-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    cmd = { 'ToggleTerm' },
    keys = {
      {
        '<C-\\>',
        function()
          require('toggleterm.terminal').Terminal.new {
            shell = vim.o.shell,
            direction = 'vertical',
            size = function(term)
              if term.direction == 'horizontal' then
                return 15
              elseif term.direction == 'vertical' then
                return vim.o.columns * 0.4
              end
            end,
          }
        end,
        mode = '',
        desc = 'Toggle Terminal',
      },
    },
    opts = {
      open_mapping = [[<c-\>]],
      start_in_insert = true,
      direction = 'vertical',
      hide_numbers = true,
      shell = vim.o.shell,
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
    },
  },
}
