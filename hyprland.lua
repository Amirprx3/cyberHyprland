-- Hyprland configuration for Hyprland 0.55+
-- Target: current Lua configuration format (tested for Lua syntax; see notes below)
--
-- Main config path:
--   ~/.config/hypr/hyprland.lua
--
-- Required/expected applications:
--   hyprland, hyprpaper, waybar, wofi, dunst, kitty, nautilus,
--   grim, slurp, wl-clipboard, cliphist, hyprpicker, brightnessctl,
--   pamixer, playerctl, swaylock
--
-- Optional:
--   blueman, nm-applet, nwg-look, polkit-gnome
--
-- IMPORTANT:
-- Hyprland 0.55+ uses Lua for the primary configuration format.
-- The old hyprland.conf/hyprlang syntax is the legacy format.

local mod = "SUPER"
local terminal = "kitty"
local file_manager = "nautilus"
local browser = "firefox"
local launcher = "wofi --show drun"

--------------------------------------------------------------------------------
-- ENVIRONMENT
--------------------------------------------------------------------------------

-- Wayland/toolkit environment.
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")
hl.env("JAVA_TOOL_OPTIONS", "-Dawt.useSystemAAFontSettings=on")
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Cursor size. Leave the actual theme to the desktop/session so a missing
-- cursor package cannot break the session.
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

--------------------------------------------------------------------------------
-- MONITORS
--------------------------------------------------------------------------------

-- Fallback rule: use each monitor's preferred resolution/refresh rate and
-- arrange unspecified outputs automatically.
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

--------------------------------------------------------------------------------
-- CORE CONFIGURATION
--------------------------------------------------------------------------------

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = {
                colors = { "rgba(cba6f7ff)", "rgba(89b4faff)" },
                angle = 45,
            },
            inactive_border = "rgba(313244aa)",
        },
        layout = "dwindle",
        resize_on_border = true,
        allow_tearing = false,
        no_focus_fallback = false,
        hover_icon_on_border = true,
    },

    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "caps:escape",
        kb_rules = "",
        follow_mouse = 1,
        mouse_refocus = false,
        sensitivity = 0,
        accel_profile = "flat",
        force_no_accel = false,
        numlock_by_default = true,
        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            tap_to_click = true,
            drag_lock = 0,
            scroll_factor = 1.0,
        },
        repeat_rate = 50,
        repeat_delay = 240,
    },

    decoration = {
        rounding = 12,
        active_opacity = 1.0,
        inactive_opacity = 0.92,
        fullscreen_opacity = 1.0,
        dim_inactive = true,
        dim_strength = 0.08,
        dim_special = 0.30,

        shadow = {
            enabled = true,
            range = 20,
            render_power = 3,
            offset = { 0, 5 },
            color = "rgba(1a1a2eee)",
            color_inactive = "rgba(1a1a2e88)",
            scale = 1.0,
        },

        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            noise = 0.02,
            contrast = 1.10,
            brightness = 0.90,
            xray = false,
            vibrancy = 0.20,
            vibrancy_darkness = 0.0,
            new_optimizations = true,
            popups = true,
        },
    },

    dwindle = {
        force_split = 0,
        preserve_split = true,
        smart_split = false,
        smart_resizing = true,
        permanent_direction_override = false,
        special_scale_factor = 0.80,
        split_width_multiplier = 1.0,
        use_active_for_splits = true,
        default_split_ratio = 1.0,
        split_bias = 0,
        precise_mouse_move = false,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
        always_follow_on_dnd = true,
        layers_hog_keyboard_focus = true,
        animate_manual_resizes = true,
        animate_mouse_windowdragging = true,
        enable_swallow = true,
        swallow_regex = "^(kitty|alacritty|foot)$",
        focus_on_activate = false,
        close_special_on_empty = true,
        vrr = 0,
    },

    render = {
        direct_scanout = 0,
        cm_auto_hdr = 1,
    },

    opengl = {
        nvidia_anti_flicker = true,
    },

    cursor = {
        sync_gsettings_theme = true,
        no_hardware_cursors = 2,
        enable_hyprcursor = true,
        inactive_timeout = 3,
        warp_on_change_workspace = 0,
    },

    binds = {
        workspace_back_and_forth = false,
        window_direction_monitor_fallback = true,
        workspace_center_on = 1,
    },
})

--------------------------------------------------------------------------------
-- ANIMATIONS
--------------------------------------------------------------------------------

hl.curve("smooth_out", {
    type = "bezier",
    points = { { 0.36, 0.0 }, { 0.66, 1.0 } },
})

hl.curve("smooth_in", {
    type = "bezier",
    points = { { 0.25, 1.0 }, { 0.50, 1.0 } },
})

hl.curve("overshoot", {
    type = "bezier",
    points = { { 0.05, 0.90 }, { 0.10, 1.05 } },
})

hl.curve("ease_out", {
    type = "bezier",
    points = { { 0.16, 1.0 }, { 0.30, 1.0 } },
})

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 5,
    curve = "overshoot",
    style = "slide",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 4,
    curve = "smooth_out",
    style = "slide",
})

hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 4,
    curve = "ease_out",
})

hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 4,
    curve = "smooth_in",
})

hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 4,
    curve = "smooth_out",
})

hl.animation({
    leaf = "fadeDim",
    enabled = true,
    speed = 4,
    curve = "smooth_in",
})

hl.animation({
    leaf = "fadeSwitch",
    enabled = true,
    speed = 5,
    curve = "smooth_in",
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 5,
    curve = "overshoot",
    style = "slidevert",
})

hl.animation({
    leaf = "specialWorkspace",
    enabled = true,
    speed = 5,
    curve = "overshoot",
    style = "slidefadevert 15%",
})

--------------------------------------------------------------------------------
-- GESTURES
--------------------------------------------------------------------------------

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

--------------------------------------------------------------------------------
-- WINDOW RULES
--------------------------------------------------------------------------------

local function window_rule(match, effects)
    effects.match = match
    hl.window_rule(effects)
end

-- Floating utility windows.
window_rule({ class = "pavucontrol" }, { float = true, size = { 800, 600 }, center = true })
window_rule({ class = "blueman-manager" }, { float = true, size = { 900, 700 }, center = true })
window_rule({ class = "nm-connection-editor" }, { float = true })
window_rule({ class = "xdg-desktop-portal" }, { float = true })
window_rule({ class = "imv" }, { float = true })
window_rule({ class = "mpv" }, { float = true })
window_rule({ class = "nwg-look" }, { float = true })
window_rule({ class = "polkit-gnome-authentication-agent-1" }, { float = true })

-- Common dialogs.
window_rule({ title = "^Open File$" }, { float = true, center = true })
window_rule({ title = "^Save As$" }, { float = true })
window_rule({ title = "^Confirm$" }, { float = true })
window_rule({ title = "^Question$" }, { float = true })

-- Picture-in-Picture windows.
window_rule({ title = ".*Picture.in.Picture.*" }, {
    float = true,
    pin = true,
    keep_aspect_ratio = true,
    border_size = 0,
    size = { 480, 270 },
    move = { "monitor_w - 490", "monitor_h - 290" },
})

-- Application opacity.
window_rule({ class = "kitty" }, { opacity = "0.95 override 0.85 override" })
window_rule({ class = "Alacritty" }, { opacity = "0.95 override 0.85 override" })
window_rule({ class = "Code" }, { opacity = "0.98 override 0.90 override" })
window_rule({ class = "codium" }, { opacity = "0.98 override 0.90 override" })

-- Gaming.
window_rule({ class = "^steam_app_.*$" }, {
    immediate = true,
    fullscreen = true,
    content = "game",
})

window_rule({ class = "gamescope" }, {
    immediate = true,
    content = "game",
})

-- Workspace assignments.
window_rule({ class = "kitty" }, { workspace = "1 silent" })
window_rule({ class = "firefox" }, { workspace = "2 silent" })
window_rule({ class = "chromium" }, { workspace = "2 silent" })
window_rule({ class = "Code" }, { workspace = "3 silent" })
window_rule({ class = "discord" }, { workspace = "4 silent" })
window_rule({ class = "WebCord" }, { workspace = "4 silent" })
window_rule({ class = "Spotify" }, { workspace = "5 silent" })
window_rule({ class = "steam" }, { workspace = "9 silent" })

--------------------------------------------------------------------------------
-- LAYER RULES
--------------------------------------------------------------------------------

hl.layer_rule({
    match = { namespace = "waybar" },
    blur = true,
})

hl.layer_rule({
    match = { namespace = "wofi" },
    blur = true,
})

hl.layer_rule({
    match = { namespace = "rofi" },
    blur = true,
})

--------------------------------------------------------------------------------
-- STARTUP
--------------------------------------------------------------------------------

hl.on("hyprland.start", function()
    -- Keep the D-Bus/systemd environment synchronized with the Wayland session.
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP >/dev/null 2>&1 || true")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP >/dev/null 2>&1 || true")

    -- Wallpaper, bar and notifications.
    hl.exec_cmd("command -v hyprpaper >/dev/null 2>&1 && hyprpaper")
    hl.exec_cmd("command -v waybar >/dev/null 2>&1 && waybar")
    hl.exec_cmd("command -v dunst >/dev/null 2>&1 && dunst")

    -- PolicyKit authentication agent, if installed in the standard Arch path.
    hl.exec_cmd("if [ -x /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 ]; then /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1; fi")

    -- Clipboard history, only when both required programs exist.
    hl.exec_cmd("if command -v wl-paste >/dev/null 2>&1 && command -v cliphist >/dev/null 2>&1; then wl-paste --type text --watch cliphist store; fi")
    hl.exec_cmd("if command -v wl-paste >/dev/null 2>&1 && command -v cliphist >/dev/null 2>&1; then wl-paste --type image --watch cliphist store; fi")
end)

--------------------------------------------------------------------------------
-- CORE KEYBINDINGS
--------------------------------------------------------------------------------

local function bind(key, dispatcher, description)
    local flags = {}
    if description then
        flags.description = description
    end
    hl.bind(key, dispatcher, flags)
end

-- Applications and compositor controls.
bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal), "Open terminal")
bind(mod .. " + Q", hl.dsp.window.kill(), "Kill active window")
bind(mod .. " + M", hl.dsp.exit(), "Exit Hyprland")
bind(mod .. " + E", hl.dsp.exec_cmd(file_manager), "Open file manager")
bind(mod .. " + B", hl.dsp.exec_cmd(browser), "Open browser")
bind(mod .. " + SPACE", hl.dsp.exec_cmd(launcher), "Open application launcher")
bind(mod .. " + SHIFT + SPACE", hl.dsp.window.float(), "Toggle floating")
bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), "Toggle fullscreen")
bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized" }), "Toggle maximize")
bind(mod .. " + P", hl.dsp.window.pseudo(), "Toggle pseudotile")
bind(mod .. " + J", hl.dsp.layout("togglesplit"), "Toggle split orientation")
bind(mod .. " + C", hl.dsp.window.center(), "Center floating window")

--------------------------------------------------------------------------------
-- SCREENSHOTS
--------------------------------------------------------------------------------

local screenshot_dir = "$HOME/Pictures/Screenshots"

bind("Print", hl.dsp.exec_cmd("mkdir -p " .. screenshot_dir .. " && grim " .. screenshot_dir .. "/$(date +%Y%m%d_%H%M%S).png"), "Save full-screen screenshot")
bind("SHIFT + Print", hl.dsp.exec_cmd("mkdir -p " .. screenshot_dir .. " && grim -g \"$(slurp)\" " .. screenshot_dir .. "/$(date +%Y%m%d_%H%M%S).png"), "Save region screenshot")
bind("CTRL + Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"), "Copy region screenshot")

--------------------------------------------------------------------------------
-- COLOR PICKER / CLIPBOARD / LOCK
--------------------------------------------------------------------------------

bind(mod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"), "Pick color and copy")
bind(mod .. " + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"), "Open clipboard history")
bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("swaylock"), "Lock screen")

--------------------------------------------------------------------------------
-- FOCUS
--------------------------------------------------------------------------------

local focus_keys = {
    { "H", "l" },
    { "L", "r" },
    { "K", "u" },
    { "J", "d" },
    { "LEFT", "l" },
    { "RIGHT", "r" },
    { "UP", "u" },
    { "DOWN", "d" },
}

for _, item in ipairs(focus_keys) do
    bind(mod .. " + " .. item[1], hl.dsp.focus({ direction = item[2] }), "Focus window " .. item[2])
end

--------------------------------------------------------------------------------
-- MOVE WINDOWS
--------------------------------------------------------------------------------

local move_keys = {
    { "H", "l" },
    { "L", "r" },
    { "K", "u" },
    { "J", "d" },
    { "LEFT", "l" },
    { "RIGHT", "r" },
    { "UP", "u" },
    { "DOWN", "d" },
}

for _, item in ipairs(move_keys) do
    bind(mod .. " + SHIFT + " .. item[1], hl.dsp.window.move({ direction = item[2] }), "Move window " .. item[2])
end

--------------------------------------------------------------------------------
-- RESIZE SUBMAP
--------------------------------------------------------------------------------

hl.bind(mod .. " + R", hl.dsp.submap("resize"), { description = "Enter resize mode" })

hl.define_submap("resize", function()
    local resize_keys = {
        { "H", -30, 0 },
        { "L", 30, 0 },
        { "K", 0, -30 },
        { "J", 0, 30 },
        { "LEFT", -30, 0 },
        { "RIGHT", 30, 0 },
        { "UP", 0, -30 },
        { "DOWN", 0, 30 },
    }

    for _, item in ipairs(resize_keys) do
        hl.bind(
            item[1],
            hl.dsp.window.resize({ x = item[2], y = item[3], relative = true }),
            { repeating = true }
        )
    end

    hl.bind("RETURN", hl.dsp.submap("reset"))
    hl.bind("ESCAPE", hl.dsp.submap("reset"))
    hl.bind(mod .. " + R", hl.dsp.submap("reset"))
end)

--------------------------------------------------------------------------------
-- WORKSPACES
--------------------------------------------------------------------------------

for i = 1, 9 do
    bind(mod .. " + " .. tostring(i), hl.dsp.focus({ workspace = tostring(i) }), "Go to workspace " .. tostring(i))
    bind(mod .. " + SHIFT + " .. tostring(i), hl.dsp.window.move({ workspace = tostring(i), follow = true }), "Move window to workspace " .. tostring(i))
    bind(mod .. " + CTRL + " .. tostring(i), hl.dsp.window.move({ workspace = tostring(i), follow = false }), "Move window silently to workspace " .. tostring(i))
end

bind(mod .. " + 0", hl.dsp.focus({ workspace = "10" }), "Go to workspace 10")
bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10", follow = true }), "Move window to workspace 10")
bind(mod .. " + CTRL + 0", hl.dsp.window.move({ workspace = "10", follow = false }), "Move window silently to workspace 10")

bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), "Next workspace")
bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), "Previous workspace")
bind(mod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }), "Next workspace")
bind(mod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }), "Previous workspace")
bind(mod .. " + GRAVE", hl.dsp.focus({ workspace = "previous" }), "Previous workspace")

--------------------------------------------------------------------------------
-- SPECIAL WORKSPACE / SCRATCHPAD
--------------------------------------------------------------------------------

bind(mod .. " + S", hl.dsp.workspace.toggle_special("scratch"), "Toggle scratchpad")
bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratch", follow = false }), "Move window to scratchpad")

--------------------------------------------------------------------------------
-- MOUSE WINDOW CONTROLS
--------------------------------------------------------------------------------

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag window" })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

--------------------------------------------------------------------------------
-- MEDIA KEYS
--------------------------------------------------------------------------------

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer --default-source -t"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true, locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })

--------------------------------------------------------------------------------
-- RELOAD
--------------------------------------------------------------------------------

bind(mod .. " + SHIFT + R", hl.dsp.reload_config(), "Reload Hyprland configuration")

--------------------------------------------------------------------------------
-- END
--------------------------------------------------------------------------------
