return {
		"lewis6991/gitsigns.nvim",
		opts = {
				signs = {
						add          = { text = '┃' },
						change       = { text = '┃' },
						delete       = { text = '_' },
						topdelete    = { text = '‾' },
						changedelete = { text = '~' },
						untracked    = { text = '┋' },
				},
				on_attach = function(bufnr)
						local gs = package.loaded.gitsigns

						local function map(mode, l, r, opts)
								opts = opts or {}
								opts.buffer = bufnr
								vim.keymap.set(mode, l, r, opts)
						end

						-- Navigation
						map('n', ']c', function()
								if vim.wo.diff then return ']c' end
								vim.schedule(function() gs.next_hunk() end)
								return '<Ignore>'
						end, {expr=true})

						map('n', '[c', function()
								if vim.wo.diff then return '[c' end
								vim.schedule(function() gs.prev_hunk() end)
								return '<Ignore>'
						end, {expr=true})

						map('n', '<leader>hp', gs.preview_hunk)
						map('n', '<leader>tb', gs.toggle_current_line_blame)
				end
		},
		event = "VeryLazy",
}
