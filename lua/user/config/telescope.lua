local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    vim.notify("telescope not found!")
    return
end

telescope.setup({
    pickers = {
        colorscheme = {
            theme = "dropdown"
        },
        lsp_implementations = {
            theme = "dropdown"
        },
        lsp_definitions = {
            theme = "dropdown"
        },
        lsp_type_definitions = {
            theme = "dropdown"
        },
        lsp_references = {
            theme = "dropdown"
        },
    },
    extensions = {
        project = {
            theme = "dropdown",
            order_by = "recent"
        },
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        file_browser = {
            -- theme = "dropdown",
            hijack_newtrw = true,
        }
    },
})

telescope.load_extension('fzf')
telescope.load_extension('file_browser')
telescope.load_extension('project')
