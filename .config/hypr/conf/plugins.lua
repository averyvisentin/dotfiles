local colors = require("conf/colors")

-------------------
-----PLUGINS-------
-------------------
if hl.plugin.hyprbars then
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
end


if hl.plugin.hyprbars then
    -- 1. Button for Closing (Kills window)
    hl.plugin.hyprbars.add_button({
        bg_color = colors.error_container,
        fg_color = colors.on_error_container,
        size = 12,
        icon = "X",
        action = "hyprctl dispatch 'hl.dsp.window.close()'",
    })
end

if hl.plugin.hyprbars then
    -- 3. Fullscreen Button (Example from previous context)
    hl.plugin.hyprbars.add_button({
        bg_color = colors.on_tertiary_container,
        fg_color = colors.on_tertiary,
        size = 12,
        icon = "□",
        action = "hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = \"maximized\", action = \"toggle\" })'",
    })
end
if hl.plugin.hyprbars then
    -- 2. Button for Minimizing (Moves window silently)
    hl.plugin.hyprbars.add_button({
        bg_color = colors.on_secondary_container, -- Suggested color for visibility
        fg_color = colors.on_secondary,
        size = 12,
        icon = "_",
        action = "hyprctl dispatch 'hl.dispatch(hl.dsp.window.move({ workspace = \"empty\", follow = false }))'",
    })
end


if hl.plugin.dynamic_cursors then
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
end
---
---HYPREXPO https://github.com/sandwichfarm/hyprexpo
---
if hl.plugin.hyprexpo then
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
end
