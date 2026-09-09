
--# | | | |_   _ _ __  _ __| | __ _ _ __   __| |
--# | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
--# |  _  | |_| | |_) | |  | | (_| | | | | (_| |
--# |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--#        |___/|_|
--#
--# -----------------------------------------------------
--# Load configuration files
 -----------------------------------------------------

local colors = require("colors")

-- ---------------------------------------------------
-- Autostart
-- - --------------------------------------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm app -s b -- wayle panel start")
    hl.exec_cmd("wl-paste --watch cliphist store ") -- #clipboard
    hl.exec_cmd("hypridle")
    hl.exec_cmd("sleep 4 && hyprctl reload")
    hl.exec_cmd("hyprpm reload")
end)


------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
     output = "DP-2",
      mode = "1920x1080@143",
     position = "0x0",
      scale = 1,
    })
hl.monitor({
    output = "DP-1",
    mode = "2560x1440@60",
    position = "-2560x0",
    scale = 1,
})



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

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "vicinae"
local browser     = "zen-browser"
local codeEditor  = "zeditor"
local textEditor  = "kate"
local volumemixer = "pavucontrol"
local taskManager = "missioncenter"
local notes       = "obsidian"
local emoji       = "smile"

hl.bind("SUPER + T", hl.dsp.exec_cmd("uwsm app -- " .. terminal))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(menu .. " toggle"))
hl.bind("SUPER + CTRL + SPACE", hl.dsp.exec_cmd("uwsm app -- $HOME/dotfiles/scripts/quick-settings.sh"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("uwsm app -- " .. browser .. " --blank-window"))  --zen for some reason syncs tabs across windows
hl.bind("SUPER + E", hl.dsp.exec_cmd("uwsm app -- " .. fileManager))
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("uwsm app -- " .. terminal .. " -e yazi"))
hl.bind("SUPER + Y", hl.dsp.exec_cmd("uwsm app -- " .. codeEditor))
hl.bind("SUPER + K", hl.dsp.exec_cmd("uwsm app -- " .. textEditor))
hl.bind("SUPER + U", hl.dsp.exec_cmd("uwsm app -- " .. notes))
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd("uwsm app -- " .. taskManager))
hl.bind("SUPER + CTRL + E", hl.dsp.exec_cmd("uwsm app -- " .. emoji))

--------------------------
--- WINDOW MANAGEMENT ----
--------------------------
--- CLOSE AND Kill
hl.bind("SUPER + Q", hl.dsp.window.close(active))
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("hyprctl kill"))  --click to kill

--- FULLSCREEN + FLOATING
hl.bind("SUPER + F", hl.dsp.window.fullscreen({action = "toggle"}))
hl.bind("SUPER + G", hl.dsp.window.float({action = "toggle"}))

--- FOCUS
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

--- MOVE WINDOWS
hl.bind("SUPER + ALT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + ALT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + ALT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + ALT + down", hl.dsp.window.move({ direction = "down" }))

--- WORKSPACE NAVIGATION & MOVEMENT
-- Switch to workspaces 1-9 and move active window to workspaces 1-9
for i = 1, 9 do
    hl.bind("SUPER + SHIFT + " .. tostring(i), hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind("SUPER +  " .. tostring(i), hl.dsp.window.move({ workspace = tostring(i) }))
end


------------------
--- Utilities ----
------------------

hl.bind("SUPER + O", hl.dsp.exec_cmd("hyprshot -m region --raw - | magick - -resize 300% -colorspace gray -auto-level -compress none png:- | tesseract stdin stdout | wl-copy")) --take screenshot of region and copies all text in the screenshot to clipboard
hl.bind("SUPER + A", hl.dsp.exec_cmd("hyprshot -z -m region")) --normal region screenshot
hl.bind("SUPER + ALT + P", hl.dsp.exec_cmd("hyprshot -m output -m DP-1")) --screenshot of primary monitor
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("hyprshot -m output -m DP-2")) --screenshot of secondary monitor

hl.bind("SUPER + V", hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history")) --open vicinae clipboard history
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock")) --lock screen
hl.bind("SUPER + CTRL + R", hl.dsp.exec_cmd("wayle wallpaper next")) --change wallpaper

---Mouse Actions

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true }) --drag window
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true }) --resize window


---Media

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

-- Requires playerctl
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),       { locked = true })


-------------------
--- Workspaces ---
-------------------

local keys = { "SUPER + mouse_up", "SUPER + mouse_down" }
local prefixes = { "r+", "r-" }

for i = 1, 2 do
    hl.bind(keys[i], hl.dsp.focus({ workspace = prefixes[i] .. "1" }))
end

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
 ----------------------
 --- Window Rules ---
 ----------------------

 --hl.window_rule({match = {float = true}, move = {cursor_x, cursor_y}})


hl.window_rule({
    match = { class = "org.gnome.Calculator" },
     float = true})

 hl.window_rule({match = {title = "File Upload"}, float = true, size = {956, 602}})

 hl.window_rule({match = {class = "gay.pancake.lsfg-vk-ui"}, float = true})
 hl.window_rule({match = {class = "net.davidotek.pupgui2"}, float = true})
 hl.window_rule({match = {class = "org.squidowl.halloy"}, float = true})
 hl.window_rule({match = {class = "com.system76.CosmicStore"}, float = true})

 hl.window_rule({match = {class = "chromium"}, tile = true})

 -- System Tools & Settings (Floating)
 hl.window_rule({match = {class = "pavucontrol"}, float = true})
 hl.window_rule({match = {class = "blueman-manager"}, float = true})
 hl.window_rule({match = {class = "nm-connection-editor"}, float = true})
 hl.window_rule({match = {class = "qalculate-gtk"}, float = true})
 hl.window_rule({match = {class = "dconf-editor"}, float = true})
 hl.window_rule({match = {class = "input-remapper-gtk"}, float = true})
 hl.window_rule({match = {class = "cpupower-gui"}, float = true})
 hl.window_rule({match = {class = "DZGUI"}, float = true})

 -- Ollama
 hl.window_rule({match = {class = "ollama"}, float = true, size = {1000, 720}})

 -- Zim Wiki
 hl.window_rule({match = {class = "zim"}, float = true})
 hl.window_rule({match = {title = "Home - zim-wiki"}, size = {1646, 1000}})

 -- Proton VPN
 hl.window_rule({match = {class = "protonvpn-app"}, size = {600, 400}})

 -- Wine / Proton / Games
 hl.window_rule({match = {class = "Wineboot.exe"}, float = true})
 hl.window_rule({match = {class = "Proton Pass"}, float = true})
 hl.window_rule({match = {title = "Friends List"}, float = true})
 hl.window_rule({match = {class = "jamesdsp"}, float = true})
 hl.window_rule({match = {title = "jamesdsp"}, float = true})
 hl.window_rule({match = {title = "Jamesdsp"}, float = true})
 hl.window_rule({match = {class = "zenity"}, float = true})
 hl.window_rule({match = {title = "LACT"}, float = true})
 hl.window_rule({match = {title = "Octopi"}, float = true})
 hl.window_rule({match = {title = "(vkcube)"}, float = true})

 -- Obsidian
 --hl.window_rule({match = {class = "obsidian"}, float = true})

 -- KDE Apps
 hl.window_rule({match = {class = "org.kde.gwenview"}, float = true})
 hl.window_rule({match = {class = "org.kde.okular"}, float = true})

 -- Browser Picture in Picture
 -- Converted 69.5% and 4% to monitor width/height math
 hl.window_rule({match = {title = "^(Picture-in-Picture)$"}, float = true, pin = true, size = {"monitor_w*0.695", "monitor_h*0.04"}})

 -- Pavucontrol Detailed
 hl.window_rule({match = {class = ".*org.pulseaudio.pavucontrol.*"}, float = true, pin = true, size = {700, 600}})

 -- Terminal Tetris
 hl.window_rule({match = {title = "terminal-tetris"}, float = true, size = {480, 680}})

 -- Mission Center
 hl.window_rule({match = {class = "io.missioncenter.MissionCenter"}, float = true, pin = true, size = {1261, 809}})

 -- Mission Center Preferences
 -- Matches both class AND title
 hl.window_rule({match = {class = "missioncenter", title = "^(Preferences)$"}, float = true, pin = true})

 -- Explorer / Windows Apps
 -- "nofocus" became "no_focus"
 hl.window_rule({match = {class = "^(explorer.exe)$"}, opacity = 0, no_focus = true})

 -- Emoji Picker Smile
 --
 hl.window_rule({
     match = {class = "it.mijorus.smile"},
     float = true,
     pin = true,
     --move = {cursor_x, cursor_y},
 })

 -- Rofi / Launchers / Settings
 --hl.window_rule({match = {class = "vicinae"}, move = {cursor_x, cursor_y}})
 --hl.window_rule({match = {class = "rofi"}, move = {cursor_x, cursor_y}})
 --hl.window_rule({match = {title = "hyprpanel-settings"}, move = {5, 40}})

 -- Specific Placements (Calculated)
 -- old: move 100%-w-5 40 -> new: (monitor_w - window_w - 5) 40
 --hl.window_rule({match = {class = "blueman-manager"}, move = {(monitor_w - window_w - 5), 40}})
 --hl.window_rule({match = {class = "org.pulseaudio.pavucontrol"}, move = {(monitor_w - window_w - 5), 40}})

 -- Waypaper
 hl.window_rule({match = {class = "waypaper"}, float = true, size = {1080, 640}})

 -- Sysd Manager
 hl.window_rule({match = {class = "sysd-manager"}, float = true})



-------------------
-----PLUGINS-------
-------------------
--[[
hl.config({
    plugin = {
        hyprbars = {
            bar_blur = true,
            bar_buttons_alignment = right,
            bar_text_align = left,
            bar_part_of_window = true,
            bar_color = colors.background,
            bar_precedence_over_border = true,
            bar_height = 17,
            bar_padding = 20,
            bar_title_enabled = true,
            bar_text_size = 10,
            --on_double_click = "hyprctl dispatch togglefloating",
            --hyprbars-button = $error, 10, , "hyprctl dispatch closewindow activewindow #we want to close gracefully",
            --hyprbars-button = $tertiary, 10, , "hyprctl dispatch movetoworkspacesilent empty",
            --hyprbars-button = $outline, 10, , "hyprctl dispatch fullscreenstate 1",
        },
    },
})

-- 1. Button for Closing (Kills window)
hl.plugin.hyprbars.add_button({
    bg_color = colors.error_container,
    fg_color = colors.on_error_container,
    size = 12,
    icon = "X",
    action = "hyprctl dispatch 'hl.dsp.window.close()'",
})

-- 3. Fullscreen Button (Example from previous context)
hl.plugin.hyprbars.add_button({
    bg_color = colors.on_tertiary_container,
    fg_color = colors.on_tertiary,
    size = 12,
    icon = "□",
    action = ([hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })']),
})

-- 2. Button for Minimizing (Moves window silently)
hl.plugin.hyprbars.add_button({
    bg_color = colors.on_secondary_container, -- Suggested color for visibility
    fg_color = colors.on_secondary,
    size = 12,
    icon = "_",
    action = ([hyprctl dispatch 'hl.dispatch(hl.dsp.window.move({ workspace = "empty", follow = false }))']),
})


hl.config { plugin = { dynamic_cursors = {

    -- enables the plugin
    enabled = true,

    -- sets the cursor behaviour, supports these values:
    -- tilt    - tilt the cursor based on x-velocity
    -- rotate  - rotate the cursor based on movement direction
    -- stretch - stretch the cursor shape based on direction and velocity
    -- none    - do not change the cursor's behaviour
    mode = "rotate",

    -- minimum angle difference in degrees after which the shape is changed
    -- smaller values are smoother, but more expensive for hw cursors
    threshold = 1,

    -- for mode = "rotate"
    rotate = {

        -- length in px of the simulated stick used to rotate the cursor
        -- most realistic if this is your actual cursor size
        length = 4,

        -- clockwise offset applied to the angle in degrees
        -- this will apply to ALL shapes
        offset = 0.0,
    },

    -- for mode = "tilt"
    tilt = {

        -- controls how powerful the tilt is, the lower, the more power
        -- this value controls at which speed (px/s) the full tilt is reached
        limit = 5000,

        -- relationship between speed and tilt, supports these values:
        -- linear             - a linear function is used
        -- quadratic          - a quadratic function is used (most realistic to actual air drag)
        -- negative_quadratic - negative version of the quadratic one, feels more aggressive
        -- see `activation` in `src/mode/utils.cpp` for how exactly the calculation is done
        activation = "negative_quadratic",

        -- time window (ms) over which the speed is calculated
        -- higher values will make slow motions smoother but more delayed
        window = 100,

        -- full tilt for each side (°)
        full = 60,
    },

    -- for mode = "stretch"
    stretch = {

        -- controls how much the cursor is stretched
        -- this value controls at which speed (px/s) the full stretch is reached
        -- the full stretch being twice the original length
        limit = 3000,

        -- relationship between speed and stretch amount, supports these values:
        -- linear             - a linear function is used
        -- quadratic          - a quadratic function is used
        -- negative_quadratic - negative version of the quadratic one, feels more aggressive
        -- see `activation` in `src/mode/utils.cpp` for how exactly the calculation is done
        activation = "quadratic",

        -- time window (ms) over which the speed is calculated
        -- higher values will make slow motions smoother but more delayed
        window = 100,
    },

    -- configure shake to find
    -- magnifies the cursor if its is being shaken
    shake = {

        -- enables shake to find
        enabled = true,

        -- controls how soon a shake is detected
        -- lower values mean sooner
        threshold = 6.0,

        -- magnification level immediately after shake start
        base = 1.5,
        -- magnification increase per second when continuing to shake
        speed = 2,
        -- how much the speed is influenced by the current shake intensity
        influence = 1,

        -- maximal magnification the cursor can reach
        -- values below 1 disable the limit (e.g. 0)
        limit = 0.0,

        -- time in milliseconds the cursor will stay magnified after a shake has ended
        timeout = 5000,

        -- show cursor behaviour `tilt`, `rotate`, etc. while shaking
        effects = true,

        -- enable ipc events for shake
        -- see the `ipc` section below
        ipc = true,
    },

    -- use hyprcursor to get a higher resolution texture when the cursor is magnified
    -- see the `hyprcursor` section below
    hyprcursor = {

        -- use nearest-neighbour (pixelated) scaling when magnifying beyond texture size
        -- this will also have effect without hyprcursor support being enabled
        -- 0 - never use pixelated scaling
        -- 1 - use pixelated when no highres image
        -- 2 - always use pixelated scaling
        nearest = 1,

        -- enable dedicated hyprcursor support
        enabled = true,

        -- resolution in pixels to load the magnified shapes at
        -- be warned that loading a very high-resolution image will take a long time and might impact memory consumption
        -- -1 means we use [normal cursor size] * [shake:base option]
        resolution =1,

        -- shape to use when clientside cursors are being magnified
        -- see the shape-name property of shape rules for possible names
        -- specifying clientside will use the actual shape, but will be pixelated
        fallback = "clientside",
    },
}}}

---
---HYPREXPO https://github.com/sandwichfarm/hyprexpo
---
hl.config({
    plugin = {
        hyprexpo = {
            columns = 3,
            rows = 0, -- Follow columns; positive values set fixed-grid rows.
            gaps_in = 5,
            gaps_out = 0,
            bg_col = "rgb(111111)",
            workspace_method = "center current",
            gesture_distance = 200,
            cancel_key = "escape",
            show_cursor = 1,
            drag_drop_enable = 0, -- Disable moving windows by dragging workspace previews.
        },
    },
})

hl.bind("ALT + TAB", function()
    hl.plugin.hyprexpo.expo("toggle")
end)

--]]
