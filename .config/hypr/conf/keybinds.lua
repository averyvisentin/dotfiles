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
    hl.bind("SUPER + ALT + " .. tostring(i), hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind("SUPER +  " .. tostring(i), hl.dsp.window.move({ workspace = tostring(i) }))
end

for i = 1, 2 do
    local keys = { "SUPER + mouse_up", "SUPER + mouse_down" }
    local prefixes = { "r-", "r+" }  --switched these so mouse down is + a workspace
    hl.bind(keys[i], hl.dsp.focus({ workspace = prefixes[i] .. "1" }))
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

bind = {
    { "SUPER", "XF86Fn", "sendshortcut", ", Scroll_Lock, activewindow" },
}
