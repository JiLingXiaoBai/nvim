local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
    vim.notify("cmp not found!")
    return
end

local status_luasnip_ok, luasnip = pcall(require, "luasnip")
if not status_luasnip_ok then
    vim.notify("luasnip not found!")
    return
end

require("luasnip.loaders.from_vscode").lazy_load() --load friendly-snippets


cmp_config = {
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    completion = {
        ---@usage The minimum length of a word to complete on.
        keyword_length = 1,
    },
    experimental = {
        ghost_text = false,
        native_menu = false,
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        max_width = 0,
        kind_icons = {
            Class = " ",
            Color = " ",
            Constant = "ﲀ ",
            Constructor = " ",
            Enum = "練",
            EnumMember = " ",
            Event = " ",
            Field = " ",
            File = "",
            Folder = " ",
            Function = " ",
            Interface = "ﰮ ",
            Keyword = " ",
            Method = " ",
            Module = " ",
            Operator = "",
            Property = " ",
            Reference = " ",
            Snippet = " ",
            Struct = " ",
            Text = " ",
            TypeParameter = " ",
            Unit = "塞",
            Value = " ",
            Variable = " ",
        },
        source_names = {
            nvim_lsp = "(LSP)",
            treesitter = "(TS)",
            emoji = "(Emoji)",
            path = "(Path)",
            calc = "(Calc)",
            cmp_tabnine = "(Tabnine)",
            vsnip = "(Snippet)",
            luasnip = "(Snippet)",
            buffer = "(Buffer)",
            spell = "(Spell)",
        },
        duplicates = {
            buffer = 1,
            path = 1,
            nvim_lsp = 0,
            luasnip = 1,
        },
        duplicates_default = 0,
        format = function(entry, vim_item)
            local max_width = cmp_config.formatting.max_width
            if max_width ~= 0 and #vim_item.abbr > max_width then
                vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
            end
            vim_item.kind = cmp_config.formatting.kind_icons[vim_item.kind] -- .. vim_item.kind .."\t"
            vim_item.menu = cmp_config.formatting.source_names[entry.source.name]
            vim_item.dup = cmp_config.formatting.duplicates[entry.source.name] or cmp_config.formatting.duplicates_default
            return vim_item
        end,
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "luasnip" },
        { name = "cmp_tabnine" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "spell" },
        { name = "calc" },
        { name = "emoji" },
        { name = "treesitter" },
        { name = "crates" },
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-CR>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline('?', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'cmdline' }
  }, {
    { name = 'path' }
  })
})

cmp.setup(cmp_config)
