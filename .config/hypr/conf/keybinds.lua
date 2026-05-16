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

hl.bind("SUPER + T", hl.dsp.exec_cmd("uwsm app -- "terminal))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd("uwsm app -- $HOME/dotfiles/scripts/quick-settings.sh"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("uwsm app -- "browser))
hl.bind("SUPER + E", hl.dsp.exec_cmd("uwsm app -- "fileManager))
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("uwsm app -- kitty -e yazi"))
hl.bind("SUPER + Y", hl.dsp.exec_cmd("uwsm app -- "codeEditor))
hl.bind("SUPER + K", hl.dsp.exec_cmd("uwsm app -- "textEditor))
hl.bind("SUPER + U", hl.dsp.exec_cmd("uwsm app -- "notes))
hl.bind("SUPER + ESC", hl.dsp.exec_cmd("uwsm app -- "taskManager))
hl.bind("SUPER + CTRL + E", hl.dsp.exec_cmd("uwsm app -- smile"))

--------------------------
--- WINDOW MANAGEMENT ----
--------------------------
--- CLOSE AND Kill
hl.bind("SUPER + Q", hl.dsp.window.close(window))
hl.bind("SUPER + ALT_R + Q", hl.dsp.window.kill(active))
hl.bind("SUPER + ALT_L + Q", hl.dsp.exec_cmd("hyprctl kill"))

--- FULLSCREEN + FLOATING
hl.bind("SUPER + F", hl.dsp.window.fullscreen_state({action = "toggle"}))
hl.bind("SUPER + G", hl.dsp.window.float({action = "toggle"}))

--- FOCUS
hl.bind("SUPER + left", hl.dsp.focus({ left}))
hl.bind("SUPER + right", hl.dsp.focus({ right}))
hl.bind("SUPER + up", hl.dsp.focus({ up}))
hl.bind("SUPER + down", hl.dsp.focus({ down}))

--- MOVE WINDOWS
hl.bind("SUPER + ALT + left", hl.dsp.window.move({ left }))
hl.bind("SUPER + ALT + right", hl.dsp.window.move({ right }))
hl.bind("SUPER + ALT + up", hl.dsp.window.move({ up }))
hl.bind("SUPER + ALT + down", hl.dsp.window.move({ down }))


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

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace =  r-1}))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace =  r+1}))
hl.bind("SUPER + CTRL + mouse_down", hl.dsp.focus({ workspace =  empty}))
--hl.bind("SUPER + CTRL + mouse_up", hl.dsp.focus({ workspace =  r+1}))
