local awful = require('awful')
local gears = require('gears')
local icons = require('theme.icons')
local apps = require('configuration.apps')

local tags = {
  {
    icon = icons.chrome,
    type = 'chrome',
    defaultApp = apps.default.browser,
    screen = 1
  },
  {
    icon = icons.emacs,
    type = 'code',
    defaultApp = apps.default.editor,
    screen = 1
  },
  {
    icon = icons.terminal,
    type = 'terminal',
    defaultApp = apps.default.terminal,
    screen = 1
  },
 --[[ {
    icon = icons.social,
    type = 'social',
    defaultApp = 'station',
    screen = 1
  },]]--
  {
    icon = icons.folder,
    type = 'files',
    defaultApp = apps.default.fileManager,
    screen = 1
  },
  {
    icon = icons.any,
    type = 'any',
    -- defaultApp = apps.default.fileManager,
    screen = 1
  },
  {
    icon = icons.labplot,
    type = 'monitor',
    defaultApp = apps.default.monitor,
    screen = 1
  }
  -- {
  --   icon = icons.music,
  --   type = 'music',
  --   defaultApp = 'kitty -e ncmpcpp',
  --   screen = 1
  -- },
  -- {
  --   icon = icons.game,
  --   type = 'game',
  --   defaultApp = 'supertuxkart',
  --   screen = 1
  -- },
  -- {
  --   icon = icons.art,
  --   type = 'art',
  --   defaultApp = 'gimp',
  --   screen = 1
  -- },
  -- {
  --   icon = icons.vbox,
  --   type = 'virtualbox',
  --   defaultApp = 'virtualbox',
  --   screen = 1
  -- },
  -- {
  --   icon = icons.lab,
  --   type = 'any',
  --   defaultApp = '',
  --   screen = 1
  -- }
}

awful.layout.layouts = {
  -- awful.layout.suit.spiral.dwindle,
  awful.layout.suit.tile,
  awful.layout.suit.max,
  awful.layout.suit.floating,
}


screen.connect_signal("request::desktop_decoration", function(s)
  for i, tag in pairs(tags) do
    -- if (i == 3) then
    -- awful.tag.add(
    --   i,
    --   {
    --     icon = tag.icon,
    --     icon_only = true,
    --     layout = awful.layout.suit.floating,
    --     gap_single_client = false,
    --     gap = 4,
    --     screen = s,
    --     defaultApp = tag.defaultApp,
    --     selected = i == 1
    --   }
    -- )
    -- else
    awful.tag.add(
      i,
      {
        icon = tag.icon,
        icon_only = true,
        layout = awful.layout.suit.tile,
        gap_single_client = false,
        gap = 4,
        screen = s,
        defaultApp = tag.defaultApp,
        selected = i == 1
      }
    )
    -- end
  end
end)


_G.tag.connect_signal(
  'property::layout',
  function(t)
    local currentLayout = awful.tag.getproperty(t, 'layout')
    if (currentLayout == awful.layout.suit.max) then
      t.gap = 0
    else
      t.gap = 4
    end
  end
)
