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

hl.monitor({
    output   = "",
    mode     = "highres",
    position = "auto",
    scale    = 1
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
