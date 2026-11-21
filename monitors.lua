local username = os.getenv("USER") or os.getenv("USERNAME")

local monitor_state_path = os.getenv("HOME") .. "/.config/hypr/ctl/monitor_state.txt"

-- Mudei tmp para o meio e top do ultrawide
if username == "giovani" then
	local file = io.open(monitor_state_path, "r")
	local last_monitor_state = file and file:read("*a")

	if file then
		file:close()
	end

	-- Create file with default state if it doesn't exist
	if last_monitor_state == nil or last_monitor_state == "" then
		last_monitor_state = "ultrawide"

		local new_file = io.open(monitor_state_path, "w")
		if new_file then
			new_file:write(last_monitor_state)
			new_file:close()
		end
	end

	if last_monitor_state == "4k" then
		hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "3840x0", scale = 1 })
		hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@60", position = "0x0", scale = 1 })
	elseif last_monitor_state == "FULLHD" then
		hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "1920x0", scale = 1 })
		hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
	elseif last_monitor_state == "ultrawide" then
		-- hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "2560x0", scale = 1 })
		-- hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@60", position = "0x0", scale = 1 })

		hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "320x1080", scale = 1 })
		hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@60", position = "0x0", scale = 1 })
	elseif last_monitor_state == "ultrawide-apart" then
		hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "3000x0", scale = 1 })
		hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@60", position = "0x0", scale = 1 })
	else
		hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "320x1080", scale = 1 })
		hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@60", position = "0x0", scale = 1 })
		-- hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "2560x0", scale = 1 })
		-- hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@60", position = "0x0", scale = 1 })
	end
elseif username == "clinica" then
	hl.monitor({ output = "VGA-1", mode = "1360x768@60", position = "0x0", scale = 1 })
	hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@60", position = "1360x0", scale = 1 })
end
