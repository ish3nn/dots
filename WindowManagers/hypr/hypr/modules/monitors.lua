------------------
---- MONITORS ----
------------------

-- transform
--[[
    0 -> normal (no transforms)
    1 -> 90 degrees
    2 -> 180 degrees
    3 -> 270 degrees
    4 -> flipped
    5 -> flipped + 90 degrees
    6 -> flipped + 180 degrees
    7 -> flipped + 270 degrees
]]

local monitor_1 = "DP-2"
local monitor_2 = "HDMI-A-1"

hl.monitor({
    output   = monitor_1,
    mode     = "2560x1440@165.00",
    position = "0x0",
    scale    = 1
})

hl.monitor({
    output    = monitor_2,
    mode      = "1600x900@60.00",
    position  = "2560x0",
    scale     = 1,
    transform = 1
})

--------------------
---- WORKSPACES ----
--------------------

-- workspaces 1-5 -> monitor 1
for i = 1, 5 do
    hl.workspace_rule({
        workspace  = tostring(i),
        monitor    = monitor_1,
        persistent = true
    })
end

-- workspaces 6-10 -> monitor 2
for i = 6, 10 do
    hl.workspace_rule({
        workspace  = tostring(i),
        monitor    = monitor_2,
        persistent = true
    })
end
