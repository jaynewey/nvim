local pywal_core = require('pywal.core')
local colors = pywal_core.get_colors()

vim.api.nvim_set_hl(0, "IndentBlanklineChar", {fg=colors.color8})

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
}
