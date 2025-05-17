return {
--  "rachartier/tiny-glimmer.nvim",
--  event = "VeryLazy",
--  priority = 10,
--  config = function()
--      require('tiny-glimmer').setup({
--          overwrite = {
--              yank = {
--                  enabled = true,
--                  default_animation = "bounce"
--              },

--              paste = {
--                  enabled = true,
--                  default_animation = "pulse",
--                  paste_mapping = "p",
--                  Paste_mapping = "P",
--              },
--              search = {
--                  enabled = true,
--                  default_animation = "fade",
--                  next_mapping = "n",
--                  prev_mapping = "N",
--              },
--              undo = {
--                  enabled = true,

--                  default_animation = {
--                      name = "fade",

--                      settings = {
--                          from_color = "#ee5396",
--                          max_duration = 150,
--                          min_duration = 80,
--                      },
--                  },
--                  undo_mapping = "u",
--              },
--              redo = {
--                  enabled = true,

--                  default_animation = {
--                      name = "fade",

--                      settings = {
--                          from_color = "#25be6a",
--                          max_duration = 150,
--                          min_duration = 80,
--                      },
--                  },

--                  redo_mapping = "<c-r>",
--              },
--          },
--          animations = {
--              bounce = {
--                  max_duration = 100,
--                  min_duration = 100,
--                  oscillations = 2,
--                  from_color = "#f2f4f8",
--                  to_color = "Visual"
--              },
--              pulse = {
--                  max_duration = 80,
--                  min_duration = 80,
--                  pulse_count = 3,
--                  from_color = "#f2f4f8",
--                  to_color = "Visual"
--              }
--          }
--      })
--  end,
}
