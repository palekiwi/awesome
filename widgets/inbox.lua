local wibox = require("wibox")
local gears = require("gears")

local inbox = {}


local function count_files(dir)
  local count = 0
  local cmd = "find '" .. dir .. "' -maxdepth 1 -type f | wc -l"
  local handle = io.popen(cmd)

  if handle then
    count = tonumber(handle:read("*a")) or 0
    handle:close()
  end

  return count
end

function inbox.create(opts)
  opts = opts or {}

  local HOME = os.getenv("HOME")
  local directory = opts.dir or os.getenv("HOME") .. "/Maildir/ygt/Inbox/new"
  local fg_color_active = "#1d1d1f"
  local fg_color_inactive = "#1d1d1f"
  local bg_color_active = "#ffbd7a"
  local bg_color_inactive = "#666"
  local radius = 2

  local text = "0"
  local icon_path = HOME .. "/.nix-profile/share/icons/Arc/status/symbolic/mail-unread-symbolic.svg"

  local text_widget = wibox.widget {
    markup = '<span weight="bold" foreground="' .. fg_color_active .. '">' .. text .. '</span>',
    widget = wibox.widget.textbox
  }

  local icon_widget = wibox.widget {
    image = gears.color.recolor_image(icon_path, fg_color_active),
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
    bg = bg_color_active,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, radius)
    end,
    widget = wibox.container.background
  }

  local function update_count()
    local count = count_files(directory)
    local fg_color = fg_color_inactive
    local bg_color = bg_color_inactive

    if count > 0 then
      fg_color = fg_color_active
      bg_color = bg_color_active
    end

    local icon = gears.color.recolor_image(icon_path, fg_color)

    text_widget.markup = '<span weight="bold" foreground="' .. fg_color .. '">' .. count .. '</span>'
    inbox_widget.bg = bg_color
    icon_widget.image = icon
  end


  update_count()

  gears.timer {
    timeout = 30,
    autostart = true,
    callback = update_count
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
