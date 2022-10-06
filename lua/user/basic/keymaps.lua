
local s_nr = {silent = true, noremap = true}
local s_r = {silent = true, noremap = false}
local ns_nr = {silent = false, noremap = true}
local ns_r = {silent = false, noremap = false}
local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ' '

keymap('n', '<leader>/', ':nohl<cr>', s_nr)
keymap('v', '.', [[:normal! .<cr>]], s_nr)
-- enter 'z=' to correct the spell error
keymap('n', '<leader>sc', ':set spell!<cr>', s_nr)
-- replace the word under cursor in current buffer
keymap('n', '<leader>rb', [[:%s/\<<c-r><c-w>\>//g<left><left>]], ns_nr)
-- place holder
keymap('', '<leader><leader><leader>', [[<esc>/<++><cr>:nohl<cr>c4l]], s_nr)
-- terminal toggle
keymap('n', '<c-t>', [[<Cmd>exe v:count1 . "ToggleTerm"<cr>i]], s_nr)
keymap('t', '<c-t>', [[<Cmd>exe v:count1 . "ToggleTerm"<cr>]], s_nr)

-------------------
-- split windows --
-------------------
-- cursor move to another window
keymap('n', '<c-h>', '<c-w>h', s_nr)
keymap('n', '<c-j>', '<c-w>j', s_nr)
keymap('n', '<c-k>', '<c-w>k', s_nr)
keymap('n', '<c-l>', '<c-w>l', s_nr)
-- split a new window
keymap('n', '<a-h>', ':set nosplitright<cr>:vsplit<cr>', s_nr)
keymap('n', '<a-l>', ':set splitright<cr>:vsplit<cr>', s_nr)
keymap('n', '<a-k>', ':set nosplitbelow<cr>:split<cr>', s_nr)
keymap('n', '<a-j>', ':set splitbelow<cr>:split<cr>', s_nr)
-- resize current window
keymap('n', '<leader><up>', ':res -5<cr>', s_nr)
keymap('n', '<leader><down>', ':res +5<cr>', s_nr)
keymap('n', '<leader><left>', ':vertical resize +5<cr>', s_nr)
keymap('n', '<leader><right>', ':vertical resize -5<cr>', s_nr)
-- buffer select and close
keymap('n', '<a-q>', [[:lua require('user.basic.utils').close_buffer()<cr>]], s_nr)
keymap('n', '<a-1>', ':BufferLineGoToBuffer1<cr>', s_nr)
keymap('n', '<a-2>', ':BufferLineGoToBuffer2<cr>', s_nr)
keymap('n', '<a-3>', ':BufferLineGoToBuffer3<cr>', s_nr)
keymap('n', '<a-4>', ':BufferLineGoToBuffer4<cr>', s_nr)
keymap('n', '<a-5>', ':BufferLineGoToBuffer5<cr>', s_nr)
keymap('n', '<a-6>', ':BufferLineGoToBuffer6<cr>', s_nr)
keymap('n', '<a-7>', ':BufferLineGoToBuffer7<cr>', s_nr)
keymap('n', '<a-8>', ':BufferLineGoToBuffer8<cr>', s_nr)
keymap('n', '<a-9>', ':BufferLineGoToBuffer9<cr>', s_nr)
keymap('n', '<a-->', ':BufferLineCyclePrev<cr>', s_nr)
keymap('n', '<a-=>', ':BufferLineCycleNext<cr>', s_nr)
keymap('n', '1q', '<a-1><a-q>', s_r)
keymap('n', '2q', '<a-2><a-q>', s_r)
keymap('n', '3q', '<a-3><a-q>', s_r)
keymap('n', '4q', '<a-4><a-q>', s_r)
keymap('n', '5q', '<a-5><a-q>', s_r)
keymap('n', '6q', '<a-6><a-q>', s_r)
keymap('n', '7q', '<a-7><a-q>', s_r)
keymap('n', '8q', '<a-8><a-q>', s_r)
keymap('n', '9q', '<a-9><a-q>', s_r)


-----------------
--- telescope ---
-----------------
keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', s_nr)
keymap('n', '<leader>fw', '<cmd>Telescope grep_string<cr>', s_nr)
keymap('n', '<leader>fs', '<cmd>Telescope live_grep<cr>', s_nr)
keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', s_nr)
keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', s_nr)
keymap('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', s_nr)
keymap('n', '<leader>fc', '<cmd>Telescope colorscheme<cr>', s_nr)
keymap('n', '<leader>fp', '<cmd>Telescope project display_type=full<cr>', s_nr)
keymap('n', '<leader>fe', '<cmd>Telescope file_browser<cr>', s_nr)
-- <c-u>/<c-d> to scroll up/down the preview in telescope

-- nvim-tree
keymap('n', '<leader>e', '<cmd>NvimTreeFindFileToggle<cr>', s_nr)
