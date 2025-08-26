return {
    --[[
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
        "magnusriga/markdown-tools.nvim",
    },
    config = function()
        local presets = require("markview.presets");
        require("markview").setup({
            markdown = {
                -- headings = presets.headings.glow,
                horizontal_rules = presets.horizontal_rules.thick,
            }
        })
        require("markview").setup({
            preview = {
                enable = true,
                enable_hybrid_mode = true,
                filetypes = { "markdown", "md", "rmd", "quarto" },
                ignore_buftypes = {"nofile"},
                modes = { "n", "i", "no", "c" },
                hybrid_modes = { "n", "i" },
                linewise_hybrid_mode = true,
                icon_provider = "nvim-web-devicons",

            },
            markdown = {
                headings = {
                    -- heading_1 = { hl = "Title", icon = "ᐷ", icon_hl = "Title" }, -- Bold title icon
                    -- heading_2 = { hl = "Function", icon = "ᐷ", icon_hl = "Function" }, -- Function symbol
                    -- heading_3 = { hl = "Type", icon = "ᐷ", icon_hl = "Type" }, -- Type/struct symbol
                    -- heading_4 = { hl = "Keyword", icon = "ᐷ", icon_hl = "Keyword" }, -- Smaller tag
                    -- heading_5 = { hl = "Comment", icon = "ᐷ", icon_hl = "Comment" }, -- Subtle icon for least important
                },

                list_items = {
                    marker_minus = { text = "-", add_padding = false },
                    marker_star = { text = "•", add_padding = false },
                },

                code_blocks = {
                    default = {
                        block_hl = "ColorColumn",
                        pad_hl = "ColorColumn",
                    },
                    border_hl = "ColorColumn",
                    info_hl = "ColorColumn",
                    pad_amount = 0,
                },
                horizontal_rules = {
                    parts = {
                        {
                            type = "repeating",
                            repeat_amount = function(_) return 80 end,
                            text = "-",
                            hl = "markviewBlockQuoteDefault",
                        }
                    },
                }

            },
            markdown_inline = {
                inline_quotes = {
                    hl = "MarkviewInlineQuote",
                },
                inline_codes = {
                    enable = true,
                    padding_left = "",
                    padding_right = "",
                }
            },
            latex = {
                enable = true,
                inlines = {
                    padding_left = "",
                    padding_right = "",
                    hl = "MarkviewInlinemath"
                }
            },
            html = {
            }
        })

        -- STRING HIGHLIGHTING FOR QUOTES -------------------------------------
        vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
            pattern = "*.md",
            callback = function()
                local bufnr = vim.api.nvim_get_current_buf()
                vim.api.nvim_buf_clear_namespace(bufnr, -1, 0, -1)

                local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                local inside_code_block = false

                for lnum, line in ipairs(lines) do
                    local quote_ranges = {}
                    local protected_ranges = {}

                    -- Detect start/end of code block (``` style)
                    if line:match("^%s*```") then
                        inside_code_block = not inside_code_block
                    end

                    -- Collect heading lines and code block lines
                    if inside_code_block or line:match("^%s*#+%s") then
                        table.insert(protected_ranges, { start = 0, finish = #line })
                    end

                    -- Highlight quoted strings + mark as protected
                    for start_idx, _, end_idx in line:gmatch('()"([^"]-)"()') do
                        vim.api.nvim_buf_add_highlight(bufnr, -1, "String", lnum - 1, start_idx - 1, end_idx - 1)
                        table.insert(protected_ranges, { start = start_idx - 1, finish = end_idx - 1 })
                    end

                    -- Highlight numbers if NOT in any protected range
                    for start_idx, num in line:gmatch("()([$%-]?%d+%.?%d*%%?)") do
                        local end_idx = start_idx + #num - 1
                        local skip = false
                        for _, range in ipairs(protected_ranges) do
                            if start_idx - 1 >= range.start and end_idx <= range.finish then
                                skip = true
                                break
                            end
                        end
                        if not skip then
                            vim.api.nvim_buf_add_highlight(bufnr, -1, "Number", lnum - 1, start_idx - 1, end_idx)
                        end
                    end
                end
            end,
        })
        vim.api.nvim_set_hl(0, "MarkviewInlineMath", { link = "name" })


        -----------------------------------------------------------------------
    end,
    ]]
};
