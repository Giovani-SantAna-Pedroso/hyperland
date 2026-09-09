#!/usr/bin/env bash

DATE=$(date +%s)
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
SCREENSHOT="$SCREENSHOT_DIR/$DATE.png"

show_help() {
    cat << EOF
Print screen helper

Usage:
  .config/hypr/scripts/print_screen.sh <mode>

Mode:
  REGULAR
    Regular print screen, save the image in:
    ~/Pictures/Screenshots/

  OCR_ENG
    Read the text (English) of the print screen image
    and send it to the clipboard

  OCR_BR
    Read the text (Portuguese) of the print screen image
    and send it to the clipboard

EOF
}

notify() {
    local message="$1"

    echo "$message"
    notify-send \
        -t 4000 \
        "Print Screen" \
        "$message"
}

regular() {
    mkdir -p "$SCREENSHOT_DIR"

    if grimshot save area "$SCREENSHOT"; then
        notify "Image saved in $SCREENSHOT"
    else
        notify "Error: could not save screenshot."
        exit 1
    fi
}

ocr_eng() {
    mkdir -p "$SCREENSHOT_DIR"

    if grimshot save area "$SCREENSHOT"; then
        if tesseract "$SCREENSHOT" stdout -l eng | wl-copy; then
            notify "English OCR copied to clipboard."
        else
            notify "Error: OCR failed."
            exit 1
        fi
    else
        notify "Error: could not take screenshot."
        exit 1
    fi
}

ocr_pt_br() {
    mkdir -p "$SCREENSHOT_DIR"

    if grimshot save area "$SCREENSHOT"; then
        if tesseract "$SCREENSHOT" stdout -l por | wl-copy; then
            notify "Portuguese OCR copied to clipboard."
        else
            notify "Error: OCR failed."
            exit 1
        fi
    else
        notify "Error: could not take screenshot."
        exit 1
    fi
}

case "$1" in
    REGULAR)
        regular
        ;;

    OCR_ENG)
        ocr_eng
        ;;

    OCR_PT_BR)
        ocr_pt_br
        ;;

    *)
        show_help
        exit 1
        ;;
esac
