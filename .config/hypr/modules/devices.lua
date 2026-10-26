-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@60",
    position = "0x0",
    scale = "1.33"
})

hl.config({
    input = {
        kb_layout = "us",

        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.5,
            disable_while_typing = true,
            tap_to_click = true,
            tap_and_drag = true
        }
    }
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
    scale = 1.0
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({name = "epic-mouse-v1", sensitivity = -0.5})

