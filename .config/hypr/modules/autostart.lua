-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
local programs = require("modules/variables")

hl.on("hyprland.start", function()
    hl.exec_cmd(programs.terminal)
    hl.exec_cmd("nm-applet")
    hl.exec_cmd(programs.statusBar)
    hl.exec_cmd("~/.config/hypr/scripts/restore-wallpaper.sh") -- Load previous wallpaper set by hyprquickpaper using hyprland
    hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
end)
