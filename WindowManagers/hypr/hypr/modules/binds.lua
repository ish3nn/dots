local mainMod = "SUPER"

local terminal = "kitty"
local fileManager = "nautilus"
local menu = './.config/rofi/type-2/launcher.sh'

--[[
    BINDS
]]

-- Launcher
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))


hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("/home/ish3nn/.config/waybar/scripts/launch.sh"))

-- Screenshots
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("hyprshot -m output"))


-- Audio
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%+"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true }
)

hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true }
)

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
    { locked = true, repeating = true }
)

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

----------------
-- BINDS: WINDOW CONTROL
----------------

hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(
    mainMod .. " + F",
    hl.dsp.window.fullscreen({ action = "toggle" })
)

hl.bind(
    mainMod .. " + V",
    hl.dsp.window.float({ action = "toggle" })
)


hl.bind(
    mainMod .. " + P",
    hl.dsp.window.pseudo({ action = "toggle" })
)

----------------
-- ALT TAB
----------------

-- previous workspace (i3 back_and_forth)
hl.bind(
    "ALT + TAB",
    hl.dsp.focus({ workspace = "previous" })
)

-- previous window
hl.bind(
    mainMod .. " + TAB",
    hl.dsp.focus({ last = true })
)

----------------
-- MOVE FOCUS
----------------

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

----------------
-- MOVE WINDOWS
----------------

hl.bind(
    mainMod .. " + SHIFT + left",
    hl.dsp.window.move({ direction = "left" })
)

hl.bind(
    mainMod .. " + SHIFT + right",
    hl.dsp.window.move({ direction = "right" })
)

hl.bind(
    mainMod .. " + SHIFT + up",
    hl.dsp.window.move({ direction = "up" })
)

hl.bind(
    mainMod .. " + SHIFT + down",
    hl.dsp.window.move({ direction = "down" })
)

----------------
-- RESIZE WINDOWS
----------------

hl.bind(
    mainMod .. " + ALT + LEFT",
    hl.dsp.window.resize({ x = -25, y = 0, relative = true })
)

hl.bind(
    mainMod .. " + ALT + RIGHT",
    hl.dsp.window.resize({ x = 25, y = 0, relative = true })
)

hl.bind(
    mainMod .. " + ALT + UP",
    hl.dsp.window.resize({ x = 0, y = -25, relative = true })
)

hl.bind(
    mainMod .. " + ALT + DOWN",
    hl.dsp.window.resize({ x = 0, y = 25, relative = true })
)

----------------
-- WORKSPACES
----------------

for i = 1, 10 do
    local key = (i == 10) and "0" or tostring(i)

    hl.bind(
        mainMod .. " + " .. key,
        hl.dsp.focus({ workspace = i })
    )

    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i })
    )
end

----------------
-- MOUSE
----------------

hl.bind(
    mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true }
)

hl.bind(
    mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true }
)

----------------
-- GROUPS / TABBED
----------------

hl.bind(mainMod .. " + W", hl.dsp.group.toggle())
hl.bind(mainMod .. " + G", hl.dsp.group.next())
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.group.prev())

----------------
-- SYSTEM
----------------

hl.bind(
    mainMod .. " + SHIFT + C",
    hl.dsp.exec_cmd("hyprctl reload")
)

hl.bind(
    mainMod .. " + SHIFT + E",
    hl.dsp.exit()
)
