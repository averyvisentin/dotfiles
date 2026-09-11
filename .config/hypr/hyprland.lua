
--# | | | |_   _ _ __  _ __| | __ _ _ __   __| |
--# | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
--# |  _  | |_| | |_) | |  | | (_| | | | | (_| |
--# |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--#        |___/|_|
--#
--# -----------------------------------------------------
--# Load configuration files
 -----------------------------------------------------

local colors = require("conf/colors")
require("conf/keybinds")
require("conf/windowrules")
require("conf/plugins")
require("conf/monitors")

-- ---------------------------------------------------
-- Autostart
-- - --------------------------------------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm app -s b -- wayle panel start")
    hl.exec_cmd("wl-paste --watch cliphist store ") -- #clipboard
    hl.exec_cmd("systemctl --user enable --now hypridle.service")
    hl.exec_cmd("hyprctl reload")
    hl.exec_cmd("hyprpm reload")
end)

-- ==========================================
-- WORKSPACE 2 STARTUP RULES
-- ==========================================

hl.window_rule({
    match = { class = "^(cpupower-gtk)$" },
    workspace = "2 silent"
})

hl.window_rule({
    match = { class = "^(btop_terminal)$" },
    workspace = "2 silent"
})

hl.on("hyprland.start", function()
    hl.exec_cmd("cpupower-gtk")
    hl.exec_cmd("kitty --class btop_terminal -e btop")

end)


------------------------------------
--- General window decoration
------------------------------------
-- see https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config ({
    general = {
        gaps_in = 2,
        gaps_out = 2,
        border_size = 2,
        resize_on_border = true,
        extend_border_grab_area = 5,
        hover_icon_on_border = true,
        layout = "dwindle",
        ["col.active_border"] = colors.primary,
        ["col.inactive_border"] = colors.secondary,
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.95,
        fullscreen_opacity = 1.0,
        border_part_of_window = true,

        blur = {
            enabled = false,
            size = 2,
            passes = 2,
            new_optimizations = true,
            ignore_opacity = true,
            xray = false,
        },
        shadow = {
            enabled = false,
            range = 0,
            render_power = 0,
        },
    },
})
hl.config({
    input = {
        kb_layout = us,
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        numlock_by_default = true,
        mouse_refocus = true,
        accel_profile = flat,
        off_window_axis_events = false,
        follow_mouse = 1,
        scroll_factor = 1,
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        vrr = 0,
        initial_workspace_tracking = false,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
        animate_manual_resizes = true,
        animate_mouse_windowdragging = false,
        enable_swallow = false,
        enable_anr_dialog = false,
        middle_click_paste = false,
    },
    binds = {
        scroll_event_delay = 0,
    },
    xwayland = {
        enabled = true,
        force_zero_scaling = true,
        create_abstract_socket = true,
    },
    opengl = {
        nvidia_anti_flicker = true,
    },
    cursor = {
        no_hardware_cursors = 0,
        hotspot_padding = 2,

    },
    render = {
        direct_scanout = 1, --1 enabled, 2 auto for 'game'
        new_render_scheduling = false,
    },

})

---------------------
--- LAYOUTS----------
---------------------

hl.config({
  dwindle = {
      force_split                  = 0, --0 -> split follows mouse, 1 -> always split to the left (new = left or top) 2 -> always split to the right (new = right or bottom)
      preserve_split               = true,
      smart_split                  = true,
      smart_resizing               = true,
      permanent_direction_override = false,
      special_scale_factor         = 1,
      split_width_multiplier       = 0.5,
      use_active_for_splits        = true,
      default_split_ratio          = 0.8,
      split_bias                   = 1, --specifies which window will receive the split ratio. 0 -> directional (the top or left window), 1 -> the current window
      precise_mouse_move           = false,
  },
})


-------------------
--- Workspaces ---
-------------------

hl.curve( "overshoot", { type = "bezier", points = { {0.5, 0.9}, {0.1, 1.1} } } )
hl.curve( "rubber", { type = "spring", mass = 1, stiffness = 70, dampening = 10 } )

 hl.animation({
     leaf = "global",
     speed = 3,
     enabled = true,
     curve = "rubber",
     bezier = "overshoot",
 })

 hl.workspace_rule({ workspace = "1", monitor = "DP-2", default = true })
