local wibox = require("wibox")
local gears = require("gears")

local inbox = {}


function inbox.create()
  local fg_color = "#000000"
  local bg_color = "#ffbd7a"
  local radius = 4

  local text = "13"

  local text_widget = wibox.widget {
    markup = '<span weight="bold" foreground="' .. fg_color .. '">' .. text .. '</span>',
    widget = wibox.widget.textbox
  }

  local padded_text = wibox.widget {
    text_widget,
    left = 8,
    right = 8,
    widget = wibox.container.margin
  }

  local inbox_widget = wibox.widget {
    padded_text,
    bg = bg_color,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, radius)
    end,
    widget = wibox.container.background
  }

  return wibox.widget {
    inbox_widget,
    left = 4,
    right = 4,
    top = 3,
    bottom = 3,
    widget = wibox.container.margin
  }
end


return inbox
