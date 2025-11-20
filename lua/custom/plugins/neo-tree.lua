-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  init = function()
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
  end,
  config = function()
    local delete_to_trash = function(filename)
      local cmd = 'trash' -- the deafult *nix way of doing things.
      if vim.fn.has 'win32' == 1 and vim.fn.executable 'recycle-bin' == 1 then
        cmd = 'recycle-bin'
      end
      vim.fn.system { cmd, filename }
    end
    require('neo-tree').setup {
      filesystem = {
        filtered_items = {
          show_hidden_count = true,
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_pattern = {
            '*.meta',
          },
        },
        window = {
          mappings = {
            ['<leader>e'] = 'close_window',
          },
        },
        commands = {
          -- over write default 'delete' command to 'trash'.
          delete = function(state)
            local inputs = require 'neo-tree.ui.inputs'
            local path = state.tree:get_node().path
            local msg = 'Are you sure you want to trash ' .. path
            inputs.confirm(msg, function(confirmed)
              if not confirmed then
                return
              end
              delete_to_trash(vim.fn.fnameescape(path))
              require('neo-tree.sources.manager').refresh(state.name)
            end)
          end,

          -- over write default 'delete_visual' command to 'trash' x n.
          delete_visual = function(state, selected_nodes)
            local inputs = require 'neo-tree.ui.inputs'
            -- get table items count
            function GetTableLen(tbl)
              local len = 0
              for _ in pairs(tbl) do
                len = len + 1
              end
              return len
            end
            local count = GetTableLen(selected_nodes)
            local msg = 'Are you sure you want to trash ' .. count .. ' files ?'
            inputs.confirm(msg, function(confirmed)
              if not confirmed then
                return
              end
              for _, node in ipairs(selected_nodes) do
                delete_to_trash(vim.fn.fnameescape(node.path))
              end
              require('neo-tree.sources.manager').refresh(state.name)
            end)
          end,
        },
      },
      close_if_last_window = true,
      follow_current_file = { enabled = true },
    }
  end,
}
