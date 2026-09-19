------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
     output = "DP-1",
     mode = "1920x1080@144",
     position = "0x0",
     scale = "auto",
     vrr = 0,
    })
hl.monitor({
    output = "DP-2",
    mode = "2560x1440@60",
    position = "-2560x0",
    scale = "auto",
    vrr = 0,
})

 hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
