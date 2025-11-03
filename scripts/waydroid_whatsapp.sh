
#!/bin/bash
# Launch WhatsApp in Waydroid with custom width and send it to workspace 10

# === CONFIG ===
WIDTH=960          # Half of HD (1920 / 2)
HEIGHT=1080        # Full HD height
WORKSPACE=10
PACKAGE="com.whatsapp"

# === START WAYDROID SESSION ===
echo "[+] Starting Waydroid..."
sudo systemctl start waydroid-container
sleep 2

# === SET DISPLAY SIZE ===
echo "[+] Setting Waydroid display size to ${WIDTH}x${HEIGHT}..."
sudo waydroid prop set persist.waydroid.width $WIDTH
sudo waydroid prop set persist.waydroid.height $HEIGHT
sudo waydroid prop set persist.waydroid.multi_windows true

# Restart Waydroid session to apply settings
echo "[+] Restarting Waydroid session..."
waydroid session stop
sleep 2
waydroid session start &
sleep 5

# === LAUNCH WHATSAPP ===
echo "[+] Launching WhatsApp..."
waydroid app launch $PACKAGE &
sleep 5

# === MOVE WINDOW TO WORKSPACE 10 ===
echo "[+] Moving window to workspace $WORKSPACE..."
# Find the window title (adjust if needed)
WINDOW=$(hyprctl clients -j | jq -r '.[] | select(.title | test("WhatsApp"; "i")) | .address')

if [ -n "$WINDOW" ]; then
    hyprctl dispatch movetoworkspacesilent "$WORKSPACE,address:$WINDOW"
    echo "[+] WhatsApp window moved to workspace $WORKSPACE."
else
    echo "[!] Could not find WhatsApp window. Try adjusting the title match."
fi
