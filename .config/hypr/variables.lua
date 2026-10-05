-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
-- Cursor size
hl.env("XCURSOR_SIZE", "18")
hl.env("HYPRCURSOR_SIZE", "18")
-- hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")

-- Display Protocols
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
-- hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
-- hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

return {
    terminal = "kitty",
    fileManager = "hyprfm",
    menu = "rofi -show run",
    browser = "thorium-browser",
    editor = "code",
    statusBar = "waybar"
}
