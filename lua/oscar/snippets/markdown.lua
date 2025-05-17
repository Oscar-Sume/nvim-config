-- Markdown.lua
local ts_utils = require("nvim-treesitter.ts_utils")

local a = "autosnippet"

local function mathNotText()
    local node = ts_utils.get_node_at_cursor()
    local in_math = false

    while node do
        local t = node:type()
        if t == "math_environment" or t == "inline_formula" then
            in_math = true
        end

        -- Check for \text{...}
        local txt = vim.treesitter.get_node_text(node, 0)
        if txt:match("\\text%s*{") then
            return false
        end

        node = node:parent()
    end

    return in_math
end

return {
    -- MATH MODE --------------------------------------------------------------
    s({ trig = "mk", snippetType = a }, fmt("${}$", { i(1) })),
    s({ trig = "dm", snippetType = a }, fmt("$$\n{}\n$$", { i(1) })),
    ---------------------------------------------------------------------------


    -- GREEK LETTERS ----------------------------------------------------------
    s({ trig = "@a", snippetType = a }, t("\\alpha"), { condition = mathNotText }),
    s({ trig = "@A", snippetType = a }, t("\\alpha"), { condition = mathNotText }),
    s({ trig = "@b", snippetType = a }, t("\\beta"), { condition = mathNotText }),
    s({ trig = "@B", snippetType = a }, t("\\beta"), { condition = mathNotText }),
    s({ trig = "@c", snippetType = a }, t("\\chi"), { condition = mathNotText }),
    s({ trig = "@C", snippetType = a }, t("\\chi"), { condition = mathNotText }),

    s({ trig = "@g", snippetType = a }, t("\\gamma"), { condition = mathNotText }),
    s({ trig = "@G", snippetType = a }, t("\\Gamma"), { condition = mathNotText }),

    s({ trig = "@d", snippetType = a }, t("\\delta"), { condition = mathNotText }),
    s({ trig = "@D", snippetType = a }, t("\\Delta"), { condition = mathNotText }),

    s({ trig = "@e", snippetType = a }, t("\\epsilon"), { condition = mathNotText }),
    s({ trig = ":e", snippetType = a }, t("\\varepsilon"), { condition = mathNotText }),

    s({ trig = "@z", snippetType = a }, t("\\zeta"), { condition = mathNotText }),
    s({ trig = "@Z", snippetType = a }, t("\\zeta"), { condition = mathNotText }),

    s({ trig = "@t", snippetType = a }, t("\\theta"), { condition = mathNotText }),
    s({ trig = "@T", snippetType = a }, t("\\Theta"), { condition = mathNotText }),
    
    s({ trig = "@k", snippetType = a }, t("\\kappa"), { condition = mathNotText }),
    s({ trig = "@K", snippetType = a }, t("\\kappa"), { condition = mathNotText }),

    s({ trig = "@l", snippetType = a }, t("\\lambda"), { condition = mathNotText }),
    s({ trig = "@L", snippetType = a }, t("\\Lambda"), { condition = mathNotText }),

    s({ trig = "@m", snippetType = a }, t("\\mu"), { condition = mathNotText }),
    s({ trig = "@M", snippetType = a }, t("\\mu"), { condition = mathNotText }),

    s({ trig = "@r", snippetType = a }, t("\\rho"), { condition = mathNotText }),
    s({ trig = "@R", snippetType = a }, t("\\rho"), { condition = mathNotText }),

    s({ trig = "@s", snippetType = a }, t("\\sigma"), { condition = mathNotText }),
    s({ trig = "@S", snippetType = a }, t("\\Sigma"), { condition = mathNotText }),

    s({ trig = "ome", snippetType = a }, t("\\omega"), { condition = mathNotText }),
    s({ trig = "@o", snippetType = a }, t("\\omega"), { condition = mathNotText }),
    s({ trig = "@O", snippetType = a }, t("\\Omega"), { condition = mathNotText }),

    s({ trig = "@u", snippetType = a }, t("\\upsilon"), { condition = mathNotText }),
    s({ trig = "@U", snippetType = a }, t("\\Upsilon"), { condition = mathNotText }),    
    ---------------------------------------------------------------------------
    ---
    ---
    --- Things to other things
    ---
    s({ trig = "te", snippetType = a }, fmt("\\text{{{}}}", { i(1) }), { condition = mathNotText }),
s({ trig = "_", snippetType = a }, fmt("_{{{}}}", { i(1) }), { condition = mathNotText }),
s({ trig = "rd", snippetType = a }, fmt("^{{{}}}", { i(1) }), { condition = mathNotText }),
    ---LOGIC
    s({ trig = "in", snippetType = a }, t("\\in"), { condition = mathNotText }),
    s({ trig = "and", snippetType = a }, t("\\cap"), { condition = mathNotText }),
    s({ trig = "or", snippetType = a }, t("\\cup"), { condition = mathNotText }),
    s({ trig = "nin", snippetType = a }, t("\\not\\in"), { condition = mathNotText }),
    s({ trig = "not", snippetType = a }, t("\\neg"), { condition = mathNotText }),
    s({ trig = "exists", snippetType = a }, t("\\exists"), { condition = mathNotText }),
    s({ trig = "=>", snippetType = a }, t("\\implies"), { condition = mathNotText }),
    s({ trig = "=<", snippetType = a }, t("\\impliedby"), { condition = mathNotText }),
    s({ trig = "iff", snippetType = a }, t("\\iff"), { condition = mathNotText }),
    s({ trig = "===", snippetType = a }, t("\\equiv"), { condition = mathNotText }),
    s({ trig = "sub", snippetType = a }, t("\\subseteq"), { condition = mathNotText }),
    s({ trig = "stm", snippetType = a }, t("\\setminus"), { condition = mathNotText }),

    -- Relationships
    s({ trig = "tr", snippetType = a }, t("\\triangle"), { condition = mathNotText }),
    s({ trig = "tf", snippetType = a }, t("\\therefore"), { condition = mathNotText }),
    s({ trig = "bc", snippetType = a }, t("\\because"), { condition = mathNotText }),
    s({ trig = "lt", snippetType = a }, t("\\leadsto"), { condition = mathNotText }),
    s({ trig = "prop", snippetType = a }, t("\\propto"), { condition = mathNotText }),

    -- Comparators
    s({ trig = "!=", snippetType = a }, t("\\neq"), { condition = mathNotText }),
    s({ trig = ">=", snippetType = a }, t("\\geq"), { condition = mathNotText }),
    s({ trig = "<=", snippetType = a }, t("\\leq"), { condition = mathNotText }),
    s({ trig = ">>", snippetType = a }, t("\\gg"), { condition = mathNotText }),
    s({ trig = "<<", snippetType = a }, t("\\ll"), { condition = mathNotText }),
    s({ trig = "~", snippetType = a }, t("\\sim"), { condition = mathNotText }),
    s({ trig = "~~", snippetType = a }, t("\\approx"), { condition = mathNotText }),


    -- Symbols
    s({ trig = "dl", snippetType = a }, t("\\$"), { condition = mathNotText }),
    s({ trig = "pc", snippetType = a }, t("\\%"), { condition = mathNotText }),
    s({ trig = "oo", snippetType = a }, t("\\infty"), { condition = mathNotText }),
    -- ARROWS
    s({ trig = "na", snippetType = a }, t("\\uparrow"), { condition = mathNotText }),
    s({ trig = "sa", snippetType = a }, t("\\downarrow"), { condition = mathNotText }),
    s({ trig = "ea", snippetType = a }, t("\\rightarrow"), { condition = mathNotText }),
    s({ trig = "ea", snippetType = a }, t("\\leftarrow"), { condition = mathNotText }),
    s({ trig = "nea", snippetType = a }, t("\\nearrow"), { condition = mathNotText }),
    s({ trig = "sea", snippetType = a }, t("\\searrow"), { condition = mathNotText }),
    s({ trig = "swa", snippetType = a }, t("\\swarrow"), { condition = mathNotText }),
    s({ trig = "nwa", snippetType = a }, t("\\nwarrow"), { condition = mathNotText }),
    s({ trig = "ewa", snippetType = a }, t("\\leftrightarrow"), { condition = mathNotText }),
    s({ trig = "->", snippetType = a }, t("\\to"), { condition = mathNotText }),
    s({ trig = "!>", snippetType = a }, t("\\mapsto"), { condition = mathNotText }),

    --OTHER
    s({ trig = "para", snippetType = a }, t("\\parallel"), { condition = mathNotText }),
    s({ trig = "xx", snippetType = a }, t("\\times"), { condition = mathNotText }),
    s({ trig = "**", snippetType = a }, t("\\cdot"), { condition = mathNotText }),
    s({ trig = "sum", snippetType = a }, t("\\sum"), { condition = mathNotText }),
    s({ trig = "prod", snippetType = a }, t("\\prod"), { condition = mathNotText }),
    s({ trig = "+-", snippetType = a }, t("\\pm"), { condition = mathNotText }),
    s({ trig = "-+", snippetType = a }, t("\\mp"), { condition = mathNotText }),
    s({ trig = "...", snippetType = a }, t("\\dots"), { condition = mathNotText }),
    s({ trig = "invs", snippetType = a }, t("^{-1}"), { condition = mathNotText }),

    -- Set notation
    s({ trig = "set", snippetType = a }, fmt("\\{{ {} \\}}{}", { i(1), i(2) }), { condition = mathNotText }),



    s({ trig = "xnn", snippetType = a }, t("x_{n}"), { condition = mathNotText }),
    s({ trig = "xii", snippetType = a }, t("x_{i}"), { condition = mathNotText }),
    s({ trig = "xjj", snippetType = a }, t("x_{j}"), { condition = mathNotText }),
    s({ trig = "xp1", snippetType = a }, t("x_{n+1}"), { condition = mathNotText }),
    s({ trig = "ynn", snippetType = a }, t("y_{n}"), { condition = mathNotText }),
    s({ trig = "yii", snippetType = a }, t("y_{i}"), { condition = mathNotText }),
    s({ trig = "yjj", snippetType = a }, t("y_{j}"), { condition = mathNotText }),

    -- Math alphabets
    s({ trig = "mcal", snippetType = a }, fmt("\\mathcal{{{}}}{}", { i(1), i(2) }), { condition = mathNotText }),
    s({ trig = "mbb", snippetType = a }, fmt("\\mathbb{{{}}}{}", { i(1), i(2) }), { condition = in_mathzone }),

}
