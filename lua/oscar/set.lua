


-- Setting rel line numbers -----------------------------------------------------------------
vim.opt.nu = true
vim.opt.relativenumber = true
---------------------------------------------------------------------------------------------


-- Tabs >> 4 spaces -------------------------------------------------------------------------
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
---------------------------------------------------------------------------------------------

-- Undofile instead of Swapfile -------------------------------------------------------------
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME" .. "/.vim/undodir")
vim.opt.undofile = true
--CONSIDER: vim.opt.backup==false
---------------------------------------------------------------------------------------------

-- Search Settings-------------------------------------------------------------------------
vim.opt.incsearch = true
vim.keymap.set("n", "<esc>", vim.cmd.nohl, {desc = "Hide Highlights"})
vim.opt.ignorecase = true
vim.opt.smartcase = true
---------------------------------------------------------------------------------------------

vim.opt.clipboard = "unnamedplus"

-- other changes --------------------------------------------------------------------
vim.opt.wrap = false
vim.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
---------------------------------------------------------------------------------------------
---
---
---
---
vim.opt.colorcolumn = "81"





