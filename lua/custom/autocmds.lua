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
  callback = function()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

    -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
    -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
    -- is not what someone will guess without a bit more experience.
    --
    -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
    -- or just use <C-\><C-n> to exit terminal mode
    vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
  end,
})
