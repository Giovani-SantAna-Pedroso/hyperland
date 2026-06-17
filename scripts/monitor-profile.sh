#!/usr/bin/env bash


HDMI_SINK="alsa_output.pci-0000_03_00.1.hdmi-stereo"
HEADPHONES_SINK="alsa_output.pci-0000_03_00.6.analog-stereo"

show_help() {
    cat << EOF
Monitor Profile Manager

Usage:
    monitor-profile <profile>

Profiles:
    4k
        Apply the 4K monitor layout and switch audio output to HDMI.

    ultrawide
        Apply the Ultrawide monitor layout and switch audio output to the headset.

    ultrawide-apart
        Apply the Ultrawide monitor layout with monitors separated in the
        virtual desktop space. This prevents the mouse cursor from freely
        moving between monitors. Switching monitors must be done using
        Hyprland keybindings. Useful for games that do not properly confine
        the mouse cursor to a single monitor.

Options:
    -h, --help
        Show this help message.

Examples:
    monitor-profile 4k
    monitor-profile ultrawide
    monitor-profile ultrawide-apart
EOF
}

set_audio_output() {
  local sink_name="$1"

  if pactl list short sinks | grep -q "$sink_name"; then
    pactl set-default-sink "$sink_name"

    # Move fluxos ativos para o novo sink
    pactl list short sink-inputs | while read -r input; do
      input_id=$(echo "$input" | awk '{print $1}')
      pactl move-sink-input "$input_id" "$sink_name"
    done

    echo -e "${GREEN}🔊 Saída de áudio alterada para:${RESET} $sink_name"
  else
    echo -e "${RED}⚠️ Saída de áudio não encontrada:${RESET} $sink_name"
    echo "Use 'pactl list short sinks' para verificar os nomes disponíveis."
  fi
}



case "$1" in
    4k)
        echo "Applying 4K monitor profile..."

        # Hyprland monitor configuration goes here
        hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "3840x0", scale = 1 })'
        hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@60", position = "0x0", scale = 1 })'

        echo "Switching audio output to HDMI..." 
        set_audio_output "$HDMI_SINK"
        ;;

    ultrawide)
        echo "Applying Ultrawide monitor profile..."

        # Hyprland monitor configuration goes here
        hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "2560x0", scale = 1 })'
        hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@60", position = "0x0", scale = 1 })'

        echo "Switching audio output to headset..."
        set_audio_output "$HEADPHONES_SINK"
        ;;
    ultrawide-apart)
        echo "Applying Ultrawide Apart monitor profile..."

        # Hyprland monitor configuration goes here
        hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "3000x0", scale = 1 })'
        hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@60", position = "0x0", scale = 1 })'

        echo "Switching audio output to headset..."
        set_audio_output "$HEADPHONES_SINK"
        ;;

    -h|--help)
        show_help
        ;;

    *)
        echo "Unknown profile: $1"
        echo "Use --help to see available options."
        exit 1
        ;;
esac







echo "Restrating the ags"
ags quit 
ags run &
