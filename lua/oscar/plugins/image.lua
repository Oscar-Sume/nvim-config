return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1001,
        opts = {
            rocks = {"magick"},
        },
    },
    {
        "3rd/image.nvim",
        dependencies = { "vhyrro/luarocks.nvim" },
        config = function()
            require("image").setup({
                backend = "kitty",
                processor = "magick_cli",
                integrations = {
                    markdown = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = false,
                        only_render_image_at_cursor_mode = "popup",
                        floating_windows = false,
                        filetypes = {"markdown", "vimwiki" },
                    },
                },
                max_width = 100,
                max_height = 12,
                max_width_window_percentage = math.huge,
                max_height_window_percentage = math.huge,
                window_overlap_clear_enabled = true,
                window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "scrollview", "scrollview_sign" },
                editor_only_render_when_focused = false,
                tmux_show_only_in_active_window = false,
                hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }
            })
        end,
    },
}
