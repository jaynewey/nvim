return {
		"nvim-telescope/telescope.nvim", tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		init = function()
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<A-p>", builtin.find_files, {})
				vim.keymap.set("n", "<C-p>", builtin.git_files, {})
				vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, {})

				-- patch colours for terminal colorscheme
				vim.api.nvim_set_hl(0, "TelescopeNormal", {ctermfg=7})
				vim.api.nvim_set_hl(0, "TelescopeSelection", {ctermfg=15, cterm={bold=true}})
				vim.api.nvim_set_hl(0, "TelescopeBorder", {ctermfg=5})
		end
}
