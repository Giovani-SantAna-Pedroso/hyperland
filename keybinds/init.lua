-- Variables

local terminal = "kitty"
local fileManager = "nemo"
local menu = "wofi --show drun"
local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))

-- Move between windows
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. "+ F", hl.dsp.window.fullscreen())

hl.bind(" + Print", hl.dsp.exec_cmd("wl-copy < $(grimshot --notify save area ~/Pictures/Screenshots/$(date +%s ).png)"))

-- Move focus to a workspace or send a program to a
--
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

require("keybinds.media")
-- bind = $mainMod , F5, exec, otd loadsettings ~/.config/OpenTabletDriver/Presets/note_primarny_monitor_hypr.json &&  notify-send "Tablet set to notebook screen"
-- bind = $mainMod , F6, exec, otd loadsettings ~/.config/OpenTabletDriver/Presets/room_ultrawide_left_hypr.json &&  notify-send "Tablet set to left side of the ultrawide"
-- bind = $mainMod , F7, exec,otd loadsettings ~/.config/OpenTabletDriver/Presets/room_ultrawide_right_hypr.json &&  notify-send "Tablet set to right side of the ultrawide"
