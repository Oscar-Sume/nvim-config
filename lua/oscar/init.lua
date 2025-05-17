vim.g.mapleader = " "


require("oscar.lazy_init")
require("oscar.remap")
require("oscar.set")



--------------------------------------------------------------------------------
vim.cmd.colorscheme "carbonfox"

-- Carbonfox, nightfox, nordfox
-- kanso-zen, kanso-kage, kanso pearl
-- cyberdream
-- gruvbox
-- vscode

--------------------------------------------------------------------------------

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25


--------------------------------------------------------------------------------
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/oscar/snippets/" })

require("luasnip").config.set_config({
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
})


--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.number = true
        vim.opt_local.textwidth = 0
        vim.opt_local.wrapmargin = 0
        vim.opt_local.columns = 80
        vim.opt_local.breakindent = true
        vim.opt_local.breakindentopt = "shift:2"
    end,
})


vim.keymap.set("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true })

vim.keymap.set("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true })

--------------------------------------------------------------------------------


local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]


local function new_notebook(filename)
    local path = filename .. ".ipynb"
    local file = io.open(path, "w")
    if file then
        file:write(default_notebook)
        file:close()
        vim.cmd("edit " .. path)
    else
        print("Error: Could not open new notebook file for writing.")
    end
end

vim.api.nvim_create_user_command('NewNotebook', function(opts)
    new_notebook(opts.args)
end, {
    nargs = 1,
    complete = 'file'
})


--------------------------------------------------------------------------------
