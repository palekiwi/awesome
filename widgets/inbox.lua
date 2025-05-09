local wibox = require("wibox")
local gears = require("gears")

local inbox = {}


function inbox.create()
  local HOME = os.getenv("HOME")

  local fg_color = "#1d1d1f"
  local bg_color = "#ffbd7a"
  local radius = 2

  local text = "3"
  local icon_path = HOME .. "/.nix-profile/share/icons/Arc/status/symbolic/mail-unread-symbolic.svg"

  local text_widget = wibox.widget {
    markup = '<span weight="bold" foreground="' .. fg_color .. '">' .. text .. '</span>',
    widget = wibox.widget.textbox
  }

  local icon_widget = wibox.widget {
    image = gears.color.recolor_image(icon_path, fg_color),
    resize = true,
    widget = wibox.widget.imagebox
  }

  local content = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = 4,
    icon_widget,
    text_widget
  }

  local padded_widget = wibox.widget {
    content,
    left = 6,
    right = 6,
    top = 1,
    bottom = 1,
    widget = wibox.container.margin
  }

  local inbox_widget = wibox.widget {
    padded_widget,
    bg = bg_color,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, radius)
    end,
    widget = wibox.container.background
  }

  return wibox.widget {
    inbox_widget,
    left = 3,
    right = 3,
    top = 3,
    bottom = 3,
    widget = wibox.container.margin
  }
end


return inbox
