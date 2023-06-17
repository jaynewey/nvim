local is_picking_focus = require('cokeline/mappings').is_picking_focus
local is_picking_close = require('cokeline/mappings').is_picking_close
local pywal_core = require('pywal.core')
local colors = pywal_core.get_colors()

require('cokeline').setup({
	default_hl = {
		bg = none,
  },
  sidebar = {
    filetype = 'NvimTree',
		components = {
      {
        text = '',
        fg = nil,
        bg = nil,
      },
    }
  },
  components = {
    {
      text = ' ',
      bg = none,
    },
    {
      text = '',
	  fg = function(buffer)
		  return buffer.is_focused and colors.color8 or colors.color0
	  end,
      bg = none,
    },
    {
	  text = function(buffer)
        return
          (is_picking_focus() or is_picking_close())
          and buffer.pick_letter .. ' '
           or buffer.devicon.icon
      end,
      fg = function(buffer)
        return buffer.is_focused and colors.color15 or buffer.devicon.color
      end,
	  bg = function(buffer)
		  return buffer.is_focused and colors.color8 or colors.color0
	  end,
    },
    {
      text = ' ',
	  bg = function(buffer)
		  return buffer.is_focused and colors.color8 or colors.color0
	  end,
    },
    {
      text = function(buffer) return buffer.filename end,
	  fg = function(buffer)
		  return buffer.is_focused and colors.color15 or colors.color7
	  end,
	  bg = function(buffer)
		  return buffer.is_focused and colors.color8 or colors.color0
	  end,
    },
	{
		text = function(buffer)
		  return
			(buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors)
			or (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings)
			or ''
		end,
		fg = function(buffer)
		  return
			(buffer.diagnostics.errors ~= 0 and colors.color14)
			or (buffer.diagnostics.warnings ~= 0 and colors.color1)
			or nil
		end,
		bg = function(buffer)
			return buffer.is_focused and colors.color8 or colors.color0
		end,
		truncation = { priority = 1 },
	},
	{
		text = function(buffer)
		  return buffer.is_modified and ' ●' or '  '
		end,
		fg = function(buffer)
		  return buffer.is_modified and colors.color9 or nil
		end,
		bg = function(buffer)
			return buffer.is_focused and colors.color8 or colors.color0
		end,
		truncation = { priority = 1 },
	},
    {
      text = '',
	  fg = function(buffer)
		  return buffer.is_focused and colors.color8 or colors.color0
	  end,
      bg = none,
    },
  },
})

local map = vim.api.nvim_set_keymap

map('n', '<C-left>', '<Plug>(cokeline-focus-prev)', { silent = true })
map('n', '<C-right>', '<Plug>(cokeline-focus-next)', { silent = true })

map('n', '<Leader>t', '<Plug>(cokeline-pick-focus)', { silent = true })
