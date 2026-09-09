PRINT_SCREEN_SCRIPT_PATH = os.getenv("HOME") .. "/.config/hypr/scripts/print_screen.sh"

hl.bind(" + Print", hl.dsp.exec_cmd(PRINT_SCREEN_SCRIPT_PATH .. " REGULAR"))
-- F17
hl.bind("XF86Launch9", hl.dsp.exec_cmd(PRINT_SCREEN_SCRIPT_PATH .. " OCR_ENG"))
-- F18
hl.bind("XF86Launch8", hl.dsp.exec_cmd(PRINT_SCREEN_SCRIPT_PATH .. " OCR_PT_BR"))
