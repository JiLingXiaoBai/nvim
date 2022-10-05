vim.cmd[[syntax on]]
vim.cmd[[filetype on]]
vim.cmd[[filetype indent on]]
vim.cmd[[filetype plugin on]]
vim.cmd[[filetype plugin indent on]]

vim.g.isWindows = false
local has = vim.fn.has
if(has("win95") or has("win64") or has("win32") or has("win16")) then
    vim.g.isWindows = true
end

local options = {
    cmdheight = 1,
    pumheight = 10,
    conceallevel = 0,
    autochdir = true,
    swapfile = false,
    undofile = false,
    winaltkeys = "no",
    fileencoding = "utf-8",
    scrolloff = 8,
    sidescrolloff = 8,
    splitbelow = true,
    splitright = true,
    cursorline = true,
    cursorcolumn = false,
    mouse = "a",
    clipboard = "unnamedplus",
    hlsearch = true,
    incsearch = true,
    ignorecase = true,
    smartcase = true,
    autoindent = true,
    softtabstop = 4,
    shiftwidth = 4,
    tabstop = 4,
    smartindent = true,
    smarttab = true,
    expandtab = true,
    foldenable = true,
    foldlevel = 35,
    foldmethod = "syntax",
    wrap = true,
    textwidth = 0,
    termguicolors = true,
    ambiwidth = "single",
    number = true,
    relativenumber = true,
    signcolumn = "yes",
    numberwidth = 4,
    laststatus = 2,
    ruler = true,
    completeopt = {"menuone","noselect"},
    backup = false,
    writebackup = false,
    updatetime = 300,
    spell = false,
    spelllang = {'en_us'},
    diffopt="vertical,filler,internal,context:4",
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.api.nvim_create_autocmd(
{"BufReadPost"},
{command = "lua require('user.basic.utils').last_position()"}
)

