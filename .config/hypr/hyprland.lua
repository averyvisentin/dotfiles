
--# | | | |_   _ _ __  _ __| | __ _ _ __   __| |
--# | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
--# |  _  | |_| | |_) | |  | | (_| | | | | (_| |
--# |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--#        |___/|_|
--#
--# -----------------------------------------------------
--# Load configuration files
 -----------------------------------------------------


--source = ~/.config/hypr/colors.conf
--source = ~/.config/hypr/conf/workspace.conf
--source = ~/.config/hypr/conf/keybinding.conf
--require("conf.keybinds")
--require("conf.windowrule")
--require("conf.animations")

--source = ~/.config/hypr/conf/windowrule.conf
--source = ~/.config/hypr/conf/animations/animations-dynamic.conf
--source = ~/.config/hypr/conf/plugins.conf




-- ---------------------------------------------------
-- Autostart
-- - --------------------------------------------------

hl.on("hyprland.start", function ()
  hl.exec_cmd("uwsm app -s b -- wayle panel start")
--   hl.exec_cmd("uwsm app -s b -- hyprpm reload")
  hl.exec_cmd("wl-paste --watch cliphist store ") -- #clipboard
  hl.exec_cmd("hypridle")
  hl.exec_cmd("sleep 5 && hyprctl reload")
end)


------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
     output = "DP-1",
      mode = "1920x1080@144",
     position = "0x0",
      scale = 1
    })
hl.monitor({
    output = "DP-2",
    mode = "2560x1440@74",
    position = "-2560x0",
    scale = 1
})



--# -----------------------------------------------------
--# General window decoration
--# ------------------------------------------------------

hl.config ({
    general = {
        gaps_in = 2,
        gaps_out = 2,
        border_size = 2,
        resize_on_border = true,
        extend_border_grab_area = 5,
        hover_icon_on_border = true,
        layout = "dwindle",
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
        scroll_factor = 3,
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
    },
    opengl = {
        nvidia_anti_flicker = true,
    },
    cursor = {
        no_hardware_cursors = 1,
        hotspot_padding = 2,

    },

})

---------------------
--- LAYOUTS----------
---------------------

hl.config({
  dwindle = {
      force_split                  = 0,
      preserve_split               = true,
      smart_split                  = true,
      smart_resizing               = true,
      permanent_direction_override = false,
      special_scale_factor         = 1,
      split_width_multiplier       = 1.0,
      use_active_for_splits        = true,
      default_split_ratio          = 1.0,
      split_bias                   = 0,
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

hl.bind("SUPER + T", hl.dsp.exec_cmd("uwsm app -- kitty"))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind("SUPER + CTRL + SPACE", hl.dsp.exec_cmd("uwsm app -- $HOME/dotfiles/scripts/quick-settings.sh"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("uwsm app -- zen-browser"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("uwsm app -- dolphin"))
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("uwsm app -- kitty -e yazi"))
hl.bind("SUPER + Y", hl.dsp.exec_cmd("uwsm app -- zeditor"))
hl.bind("SUPER + K", hl.dsp.exec_cmd("uwsm app -- kate"))
hl.bind("SUPER + U", hl.dsp.exec_cmd("uwsm app -- obsidian"))
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd("uwsm app -- missioncenter"))
hl.bind("SUPER + CTRL + E", hl.dsp.exec_cmd("uwsm app -- smile"))

--------------------------
--- WINDOW MANAGEMENT ----
--------------------------
--- CLOSE AND Kill
hl.bind("SUPER + Q", hl.dsp.window.close(active))
hl.bind("SUPER + ALT_R + Q", hl.dsp.window.kill(active))
hl.bind("SUPER + ALT_L + Q", hl.dsp.exec_cmd("hyprctl kill"))

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


------------------
--- Utilities ----
------------------

hl.bind("SUPER + O", hl.dsp.exec_cmd("hyprshot -m region --raw - | magick - -resize 300% -colorspace gray -auto-level -compress none png:- | tesseract stdin stdout | wl-copy"))
hl.bind("SUPER + A", hl.dsp.exec_cmd("hyprshot -z -m region"))
hl.bind("SUPER + ALT + P", hl.dsp.exec_cmd("hyprshot -m output -m DP-1"))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("hyprshot -m output -m DP-2"))

hl.bind("SUPER + V", hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))

---Mouse Actions

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })


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

for i = 1, 4 do
    local key = { "SUPER + mouse_up", "SUPER + mouse_down" }
    local keycombos = { key[1], key[2], "CTRL + " .. key[1], "CTRL + " .. key[2] }
    local prefix = { "+", "-", "r+", "r-" }
    hl.bind(keycombos[i], hl.dsp.focus({ workspace = prefix[i] .. "1" }))
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


 ----------------------
 --- Window Rules ---
 ----------------------

 --hl.window_rule({match = {float = true}, move = {cursor_x, cursor_y}})

 hl.window_rule({match = {class = "org.gnome.Calculator"}, float = true})

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
 --hl.window_rule({match = {title = "^(Picture-in-Picture)$"}, float = true, pin = true, size = {"monitor_w*0.695", "monitor_h*0.04"}})

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
