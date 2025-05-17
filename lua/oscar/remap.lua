-- REMAP.LUA
--
--
-- TEMP: <leader>wo writes and sources ----------------------------------------
vim.keymap.set("n", "<leader>wo", [[:w | :so <CR>]], { desc = "Save & Source" })

-- <leader>pv opens netrw explorer---------------------------------------------
vim.keymap.set("n", "<leader>pv", vim.cmd.Explore, { desc = "Open Explorer" })

-- <leader>p paste replaces without yanking replaced text ---------------------
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste no-Yank" })

-- <leader>d deletes without yanking ------------------------------------------
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete no-Yank" })

-- J,K move lines vertically in visual mode -----------------------------------
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")


-- <leader>y copies to clipboard, <leader>Y copies line to clipboard ----------
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank Clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank Line Clipboard" })

-- <leader>f Finds all occurences and lets you edit ---------------------------
-- vim.keymap.set("n", "<leader>s",
--     ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
--     { desc = "Find all & Replace" }
-- )
--
-- <leader>x Shell command to make current file executable ---------------------
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>",
    { desc = "CHMOD +x", silent = true }
)

--------------------------------------------------------------------------------
-- Navigate Quickfix list (global) (lsp errors, grep, build)
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next Item" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev Item" })

-- navigate Location List (local) Linting, buffer-local results
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next LOC" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev LOC" })


-- J concats lines WITHOUT moving curser --------------------------------------
vim.keymap.set("n", "J", "mzJ`z", { desc = "Concat Still-Cursor" })
-- C-d, C-u center screen each time -------------------------------------------
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Q disabled -----------------------------------------------------------------
vim.keymap.set("n", "Q", [[<nop>]])


-- Molten Maps -----------------------------------------------------------------
-- vim.keymap.set("n", "<leader>e", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
-- vim.keymap.set("v", "<leader>ev", ":<C-u>MoltenEvaluateVisual<CR>gv",
--     { desc = "execute visual selection", silent = true })
-- vim.keymap.set("n", "<leader>er", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
--
-- vim.keymap.set("n", "<leader>mo", ":noautocmd MoltenEnterOutput<CR>", { desc = "open output window", silent = true })
-- vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
-- vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })
-- vim.keymap.set("n", "<leader>mx", ":MoltenOpenInBrowser<CR>", { desc = "open output in browser", silent = true })



-- Quarto Maps -----------------------------------------------------------------
local runner = require("quarto.runner")
vim.keymap.set("n", "<leader>rc", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", "<leader>mra", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<leader>mrA", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", "<leader>rl", runner.run_line, { desc = "run line", silent = true })
vim.keymap.set("v", "<leader>mrr", runner.run_range, { desc = "run visual range", silent = true })

vim.keymap.set("n", "<leader>RA", function()
    runner.run_all(true)
end, { desc = "run all cells of all languages", silent = true })

-- LSP Buffer Maps -------------------------------------------------------------
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
        end
        map("n", "K", vim.lsp.buf.hover, "Hover Docs")
        map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
        map("n", "go", vim.lsp.buf.type_definition, "Go to Type Def")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "gs", vim.lsp.buf.signature_help, "Signature Help")
        map("n", "<F2>", vim.lsp.buf.rename, "Rename Symbol")
        map("n", "<F4>", vim.lsp.buf.code_action, "Code Action")

        -- new auto format
        map({ "n", "v" }, "<leader>f", function()
            vim.lsp.buf.format({ async = true })
        end, "Format (LSP)")
    end,
})
