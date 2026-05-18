local username = os.getenv("USER") or os.getenv("USERNAME")

if username == "giovani" then
	hl.notification.create({ text = "configuring giovani monitors", duration = 2000 })
elseif username == "clinica" then
	hl.notification.create({ text = "configuring clinica monitors", duration = 2000 })
end
hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "2560x0", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@60", position = "0x0", scale = 1 })
