local status_ok, db = pcall(require, "dashboard")
if not status_ok then
    vim.notify("dashboard not found!")
    return
end


db.custom_header = {
    "                                                       ",
    "                                                       ",
    "                                                       ",
    " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
    " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
    " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
    " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
    " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
    " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
    "                                                       ",
    "                                                       ",
}
db.custom_center = {
    {icon = '  ',
    desc = 'Recently projects                       ',
    action = 'Telescope project display_type=full',
    shortcut = 'SPC f p'},
    {icon = '  ',
    desc = 'Recently opened files                   ',
    action = 'Telescope oldfiles',
    shortcut = 'SPC f r'},
    {icon = '  ',
    desc = 'Find  File                              ',
    action = 'Telescope find_files find_command=rg,--files',
    shortcut = 'SPC f f'},
    {icon = '  ',
    desc = 'File Tree                               ',
    action = 'Telescope file_browser',
    shortcut = 'SPC f e'},
    {icon = '  ',
    desc = 'Find  Word                              ',
    action = 'Telescope live_grep',
    shortcut = 'SPC f w'},
    {icon = '  ',
    desc = 'Change Colorscheme                      ',
    action = 'Telescope colorscheme',
    shortcut = 'SPC f c'},
}

vim.api.nvim_create_autocmd(
{"VimEnter"},
{command = ":hi Nontext guifg=bg"}
)
