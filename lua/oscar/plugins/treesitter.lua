return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter-textobjects",
            --"OXY2DEV/markview.nvim"
        },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "vimdoc",
                    "c",
                    "cpp",
                    "lua",
                    "python",
                    "superhtml",
                    "markdown",
                    "markdown_inline",
                    "toml",
                    "latex",
                    "html"
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
                indent = {
                    enable = true,
                    disable = {
                        --"markdown",
                    }
                },
                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = false, -- you can change this if you want.
                        goto_next_start = {
                            --- ... other keymaps
                            ["]b"] = { query = "@code_cell.inner", desc = "next code block" },
                        },
                        goto_previous_start = {
                            --- ... other keymaps
                            ["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
                        },
                    },
                    select = {
                        enable = true,
                        lookahead = true, -- you can change this if you want
                        keymaps = {
                            --- ... other keymaps
                            ["ib"] = { query = "@code_cell.inner", desc = "in block" },
                            ["ab"] = { query = "@code_cell.outer", desc = "around block" },
                        },
                    },
                    swap = { -- Swap only works with code blocks that are under the same
                        -- markdown header
                        enable = true,
                        swap_next = {
                            --- ... other keymap
                            ["<leader>sbl"] = "@code_cell.outer",
                        },
                        swap_previous = {
                            --- ... other keymap
                            ["<leader>sbh"] = "@code_cell.outer",
                        },
                    },
                },

            })
        end
    },
    {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
        config = function()
            require("nvim-treesitter.configs").setup({
                playground = {
                    enable = true,
                    updatetime = 25,
                },
            })
        end
    },
    -------- COLORIZER --------------------------------------------------------
    {
        "catgoose/nvim-colorizer.lua",
        opts = {
            filetypes = { "*", "!lazy" },
            user_default_options = {
                RGB = true,
                RRGGBB = true,
                names = false,
                RRGGBBAA = true,
                AARRGGBB = false,
                rgb_fn = true,
                hsl_fn = true,
                css = false,
                css_fn = false,
                mode = "background",
                virtualtext = "■",
                tailwind = true,
            }
        }
    }
}

