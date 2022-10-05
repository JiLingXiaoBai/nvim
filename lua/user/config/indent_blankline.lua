local status_ok, indentline = pcall(require, "indent_blankline")
if not status_ok then
    vim.notify("indent_blankline not found!")
    return
end

vim.opt.list = true
vim.opt.listchars:append "space:⋅"

indentline.setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    filetype_exclude = {"dashboard"},
})
