local awful = require('awful')
local gears = require('gears')
require('awful.autofocus')
local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey

local clientKeys =
  awful.util.table.join(
  -- awful.key(
  --   {modkey},
  --   'f',
  --   function(c)
  --     -- Toggle fullscreen
  --     c.fullscreen = not c.fullscreen
  --     c:raise()
  --   end,
  --   {description = 'toggle fullscreen', group = 'client'}
  -- ),
  awful.key(
    {modkey},
    'q',
    function(c)
      -- Close client
      c:kill()
    end,
    {description = 'close', group = 'client'}
  ),
  awful.key(
    { modkey, "Shift" }, 
    "c", 
    awful.placement.centered,
    {description = 'align a client to the center of the parent area.', group = "client"}
  ),
  awful.key(
    {modkey},
    'c',
    function(c)
      -- The client just stretch when switching to floating while in maximized/fullscreen mode
      -- So tell to client to stop being a dick err I mean fullscreen/maximized to switch to floating without the said stretching
      c.fullscreen = false
      c.maximized = false
      -- Toggle floating
      c.floating = not c.floating
      c:raise()
    end,
    {description = 'toggle floating', group = 'client'}
  ),
      awful.key({ modkey }, "f",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),

    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})



)

return clientKeys
