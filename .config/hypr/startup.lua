-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
local programs = require("variables")

hl.on("hyprland.start", function()
    hl.exec_cmd(programs.terminal)
    hl.exec_cmd("nm-applet")
    hl.exec_cmd(programs.statusBar)
    --   hl.exec_cmd("waybar & hyprpaper & firefox")
end)
