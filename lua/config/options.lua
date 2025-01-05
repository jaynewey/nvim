-- use system clipboard as default yank register
vim.opt.clipboard = {'unnamed', 'unnamedplus'}

vim.wo.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.tabstop = 2
vim.opt.shiftwidth=4
vim.opt.smartindent = true

vim.opt.swapfile = false

--vim.opt.hlsearch = false
vim.opt.incsearch = true

-- hide default status line
vim.opt.showmode = false

-- case insensitive search unless uppercase
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- hide EOF "~"
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
		callback = function() vim.wo.fillchars = 'eob: ' end,
})

-- hide line numbers in terminal
vim.api.nvim_create_autocmd({"TermOpen"}, {
		callback = function()
				vim.wo.number = false
				vim.opt.relativenumber = false
				vim.cmd("startinsert")
		end,
})

-- automatically focus when switching to terminal
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
		callback = function()
				if vim.bo.buftype == 'terminal' then
						vim.cmd("startinsert")
				end
		end,
})

-- hide command line when not using
vim.opt.cmdheight = 0
