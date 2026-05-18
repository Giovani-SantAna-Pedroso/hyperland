hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("mpc toggle"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("mpc stop"))
hl.bind("SHIFT + XF86AudioStop", hl.dsp.exec_cmd("mpc repeat"))

hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("mpc prev && mpc play"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("mpc next && mpc play"))

hl.bind("  XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"))
hl.bind(" XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+"))

hl.bind(" SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +10%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))
