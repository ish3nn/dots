-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function () 
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
end)
 
----------------
----  MISC  ----
----------------
hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
}) 


require("modules.monitors")
require("modules.decoration")
require("modules.workspaces")

require("modules.languages")
require("modules.binds")
require("modules.env")

