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
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, float = true, pin = true })
hl.window_rule({match = {title = "^(Picture-in-Picture)$"}, opacity = "100"})


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
