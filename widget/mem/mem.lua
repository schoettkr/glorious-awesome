-- local wibox = require('wibox')
-- local mat_list_item = require('widget.material.list-item')
-- local mat_slider = require('widget.material.slider')
-- local mat_icon = require('widget.material.icon')
-- local icons = require('theme.icons')
-- local watch = require('awful.widget.watch')
-- local dpi = require('beautiful').xresources.apply_dpi

-- local memUsed;

-- watch(
--   'bash -c "free | grep -z Mem.*Swap.*"',
--   1,
--   function(_, stdout)
--     local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
--       stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')
--     memUsed = (used / total * 100)
--     collectgarbage('collect')
--   end
-- )

-- local mem =
--   wibox.widget {
--     markup = memUsed,
--     icon = icons.memory,
--     size = dpi(12),
--     widget = wibox.widget.textbox
--   }

-- return mem
local awful = require("awful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

--- Main ram widget shown on wibar
local mem = wibox.widget {
    border_width = 0,
    colors = {
        '#74aeab', '#26403f'
    },
    display_labels = false,
    forced_width = 25,
    widget = wibox.widget.piechart
}

--- Widget which is shown when user clicks on the ram widget
local w = wibox {
    height = 200,
    width = 400,
    ontop = true,
    screen = mouse.screen,
    expand = true,
    bg = '#1e252c',
    max_widget_size = 500
}

w:setup {
    border_width = 0,
    colors = {
        '#5ea19d',
        '#55918e',
        '#4b817e',
    },
    display_labels = false,
    forced_width = 25,
    id = 'pie',
    widget = wibox.widget.piechart
}

local total, used, free, shared, buff_cache, available

local function getPercentage(value)
    return math.floor(value / total * 100 + 0.5) .. '%'
end

watch('bash -c "free | grep Mem"', 1,
    function(widget, stdout, stderr, exitreason, exitcode)
        total, used, free, shared, buff_cache, available = stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)')
        widget.data = { used, total-used }

        if w.visible then
            w.pie.data_list = {
                {'used ' .. getPercentage(used), used},
                {'free ' .. getPercentage(free), free},
                {'buff_cache ' .. getPercentage(buff_cache), buff_cache}
            }
        end
    end,
    mem
)

mem:buttons(
    awful.util.table.join(
        awful.button({}, 1, function()
            awful.placement.top_right(w, { margins = {top = 25, right = 10}})
            w.pie.data_list = {
                {'used ' .. getPercentage(used), used},
                {'free ' .. getPercentage(free), free},
                {'buff_cache ' .. getPercentage(buff_cache), buff_cache}
            }
            w.pie.display_labels = true
            w.visible = not w.visible
        end)
    )
)

return mem
