local pywal_core = require('pywal.core')
local colors = pywal_core.get_colors()

vim.api.nvim_set_hl(0, "IblIndent", {fg=colors.color8})

require("ibl").setup {}
