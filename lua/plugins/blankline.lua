return {
		"lukas-reineke/indent-blankline.nvim",
    main = "ibl",
		opts = function ()
				local pywal_core = require('pywal.core')
				local colors = pywal_core.get_colors()

				vim.api.nvim_set_hl(0, "IblIndent", { fg = colors.color8 })

				return {}
		end
}
