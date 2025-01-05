return {
		"petertriho/nvim-scrollbar",
		opts = function()
				local pywal_core = require('pywal.core')
				local colors = pywal_core.get_colors()

				return {
						handle = {
								color = colors.color8,
						},
						marks = {
								Cursor = {
										text = "―",
								}
						},
						excluded_buftypes = {
								"terminal",
								"NvimTree",
						},
				}
		end
}
