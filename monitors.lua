local username = os.getenv("USER") or os.getenv("USERNAME")

if username == "giovani" then
	hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "2560x0", scale = 1 })
	hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@60", position = "0x0", scale = 1 })
elseif username == "clinica" then
	hl.monitor({ output = "VGA-1", mode = "1360x768@60", position = "0x0", scale = 1 })
	hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@60", position = "1360x0", scale = 1 })
end
