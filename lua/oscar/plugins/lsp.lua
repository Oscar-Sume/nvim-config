-- LSP.LUA
return {
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),

                    ['<Tab>'] = function(fallback)
                        local luasnip = require("luasnip")
                        local cmp = require("cmp")
                        local tabout = require("tabout")

                        if cmp.visible() then
                            local entry = cmp.get_selected_entry()
                            if not entry then
                                local ok = pcall(tabout.tabout)
                                if ok then return end
                            end
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            vim.fn.feedkeys(
                                vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, false), '')
                        else
                            local ok = pcall(tabout.tabout)
                            if not ok then fallback() end
                        end
                    end,
                    ['<S-Tab>'] = function(fallback)
                        local luasnip = require("luasnip")
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, false),
                                '')
                        else
                            fallback()
                        end
                    end,
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end
    },

    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/cmp-nvim-lsp',
        },

        init = function()
            vim.opt.signcolumn = 'yes'
        end,

        config = function()
            local lsp_defaults = require('lspconfig').util.default_config

            lsp_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "html",
                    "cssls",
                    "clangd",
                    "lua_ls",
                    "markdown_oxide",
                },
                automatic_installation = true,
            })

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local servers = {
                "html",
                "cssls",
                "ts_ls",
                "clangd",
                "lua_ls",
            }

            for _, server in ipairs(servers) do
                lspconfig[server].setup({
                    capabilities = capabilities,
                })
            end
        end,
    }
}
