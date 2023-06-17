require("nvim-tree").setup()

vim.api.nvim_create_autocmd({"QuitPre"}, {
    callback = function() vim.cmd("NvimTreeClose") end,
})

local map = vim.api.nvim_set_keymap
map('n', '<C-b>', ':NvimTreeToggle<CR>', { silent = true })


-- Don't jump to opened files
local function open_tab_silent(node)
  local nt_api = require("nvim-tree.api")
	nt_api.node.open.edit(node)
	nt_api.tree.focus()
end


local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', '<CR>', function()
    local node = api.tree.get_node_under_cursor()
		open_tab_silent()
  end, opts('open_tab_silent'))
end

require("nvim-tree").setup({
  on_attach = on_attach,
})
