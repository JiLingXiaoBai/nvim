local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    vim.notify("toggleterm module not found!")
    return
end

toggleterm.setup ({
    direction = 'float',
    auto_scroll = true,
    start_in_insert = false,
    insert_mappings = true,
    terminal_mappings = true,
    shell = vim.o.shell,
})
