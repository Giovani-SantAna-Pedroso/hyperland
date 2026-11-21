#!/usr/bin/env bash

HDMI_SINK="alsa_output.pci-0000_03_00.1.hdmi-stereo"
HEADPHONES_SINK="alsa_output.pci-0000_03_00.6.analog-stereo"

MONITOR_STATE_FILE="$HOME/.config/hypr/ctl/monitor_state.txt"

show_help() {
    cat << EOF
Monitor Profile Manager

Usage:
    monitor-profile <profile>

Profiles:
    4k
        Apply the 4K monitor layout and switch audio output to HDMI.

    FULLHD
        Apply the Full HD monitor layout and switch audio output to HDMI.

    ultrawide
        Apply the Ultrawide monitor layout and switch audio output to the headset.

    ultrawide-apart
        Apply the Ultrawide monitor layout with monitors separated in the
        virtual desktop space. This prevents the mouse cursor from freely
        moving between monitors. Switching monitors must be done using
        Hyprland keybindings.

Options:
    -h, --help
        Show this help message.

Examples:
    monitor-profile 4k
    monitor-profile FULLHD
    monitor-profile ultrawide
    monitor-profile ultrawide-apart
EOF
}

save_monitor_state() {
    local profile="$1"

    mkdir -p "$(dirname "$MONITOR_STATE_FILE")"

    if ! echo "$profile" > "$MONITOR_STATE_FILE"; then
        echo "Error: Could not save monitor state."
        return 1
    fi

    echo "Monitor state saved: $profile"
}

set_audio_output() {
    local sink_name="$1"

    if pactl list short sinks | grep -q "$sink_name"; then
        pactl set-default-sink "$sink_name"

        # Move active audio streams to the new sink
        pactl list short sink-inputs | while read -r input; do
            input_id=$(echo "$input" | awk '{print $1}')
            pactl move-sink-input "$input_id" "$sink_name"
        done

        echo "Audio output changed to: $sink_name"
    else
        echo "Warning: Audio output not found: $sink_name"
        echo "Use 'pactl list short sinks' to check available outputs."
    fi
}

# Validate arguments
case "$1" in
    4k|FULLHD|ultrawide|ultrawide-apart)
        save_monitor_state "$1" || exit 1
        ;;

    -h|--help)
        show_help
        exit 0
        ;;

    *)
        echo "Unknown profile: $1"
        echo "Use --help to see available options."
        exit 1
        ;;
esac

# Apply monitor profile
case "$1" in
    4k)
        echo "Applying 4K monitor profile..."

        hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "3840x0", scale = 1 })'
        hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@60", position = "0x0", scale = 1 })'

        echo "Switching audio output to HDMI..."
        set_audio_output "$HDMI_SINK"
        ;;

    FULLHD)
        echo "Applying FULLHD monitor profile..."

        hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "1920x0", scale = 1 })'
        hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x0", scale = 1 })'

        echo "Switching audio output to HDMI..."
        set_audio_output "$HDMI_SINK"
        ;;

    # Mudei tmp para o o ultra wide ficar no topo do laptop
    ultrawide)
        echo "Applying Ultrawide monitor profile..."

        # hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "2560x0", scale = 1 })'
        # hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@60", position = "0x0", scale = 1 })'
        hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "320x1080", scale = 1 })'
        hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@60", position = "0x0", scale = 1 })'

        echo "Switching audio output to headset..."
        set_audio_output "$HEADPHONES_SINK"
        ;;

    ultrawide-apart)
        echo "Applying Ultrawide Apart monitor profile..."

        hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "3000x0", scale = 1 })'
        hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@60", position = "0x0", scale = 1 })'

        echo "Switching audio output to headset..."
        set_audio_output "$HEADPHONES_SINK"
        ;;
esac

# Restart AGS
echo "Restarting AGS..."

ags quit
ags run &
