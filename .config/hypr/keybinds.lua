-- /home/realsk/.config/hypr/keybinds.lua
-- KEYBINDINGS --
local apps = require("variables") -- Applications

-- mainMod key defined
local mainMod = "SUPER"

-- Example https://wiki.hypr.land/Configuring/Basics/Binds/
-- Application Keybinds
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(apps.terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(apps.fileManager))
-- hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(apps.menu))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(apps.browser))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd(apps.editor))
-- hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(apps.swaylock))

-- Window Management Keybinds
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(
            "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
-- hl.bind(mainMod .. "+ SHIFT  + J", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + C", hl.dsp.window.close())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H", hl.dsp.focus({direction = "left"}))
hl.bind(mainMod .. " + L", hl.dsp.focus({direction = "right"}))
hl.bind(mainMod .. " + K", hl.dsp.focus({direction = "up"}))
hl.bind(mainMod .. " + J", hl.dsp.focus({direction = "down"}))

-- Switch and Move workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0      
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({workspace = i}))
end

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({workspace = "e+1"}))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({workspace = "e-1"}))

-- Laptop multimedia keys for volume and LCD brightness

-- Requires playerctl
hl.bind("F7", hl.dsp.exec_cmd("playerctl play-pause"), {locked = true})
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("quickshell -c hyprquickpaper"))

