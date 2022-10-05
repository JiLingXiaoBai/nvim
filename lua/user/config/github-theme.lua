local status_ok, githubTheme = pcall(require, "github-theme")
if not status_ok then
    vim.notify("github-theme module not found!")
    return
end

githubTheme.setup({
    theme_style = "dark",
    function_style = "NONE",
    variable_style = "NONE",
    keyword_style = "italic",
    comment_style = "italic",
})
