require("lualine").setup {
  options = {
    theme = "pywal-nvim",
    component_separators = "",
    section_separators = { left = "", right = "" },
		ignore_focus = { 'NvimTree' },
		globalstatus = true, 
  },
  sections = {
    lualine_a = {
      { "mode", separator = { left = "  ", right = "" }, right_padding = 2},
    },
    lualine_b = { 
		{
			"filename",
			symbols = {
				modified = '●',
				readonly = 'R',
			}
		},
		"branch"
	},
    lualine_c = { "fileformat" },
    lualine_x = {},
    lualine_y = { "filetype" },
    lualine_z = {
      { "location", separator = { left = "", right = "  " } },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
