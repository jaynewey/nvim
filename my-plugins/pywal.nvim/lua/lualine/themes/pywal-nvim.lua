local core = require('pywal.core')
local colors = core.get_colors()

local pywal = {}

pywal.normal = {
  a = { bg = colors.color4, fg = none },
  b = { bg = none, fg = colors.color7 },
  c = { bg = none, fg = colors.foreground },
}

pywal.insert = {
  a = { bg = colors.color2, fg = none },
  b = { bg = none, fg = colors.color4 },
}

pywal.command = {
  a = { bg = colors.color5, fg = none },
  b = { bg = none, fg = colors.color5 },
}

pywal.visual = {
  a = { bg = colors.color6, fg = none },
  b = { bg = none, fg = colors.color6 },
}

pywal.replace = {
  a = { bg = colors.color11, fg = none },
  b = { bg = none, fg = colors.color11 },
}

pywal.inactive = {
  a = { bg = none, fg = colors.color7 },
  b = { bg = none, fg = colors.foreground, gui = "bold" },
  c = { bg = none, fg = colors.foreground },
}

return pywal
