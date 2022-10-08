local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    vim.notify("lspconfig not found!")
    return
end
require("user.lsp.mason_config")
require("user.lsp.lsp_handler").setup()
