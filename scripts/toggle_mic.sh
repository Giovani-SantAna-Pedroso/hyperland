command="$(amixer set Capture toggle |  tail -n 1)"

# Get list of active screens

substring=${command:34}
# echo $substring

notify-send "Mic is now $substring"


