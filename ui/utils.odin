package ui

import rl "vendor:raylib"

prev_font_size: i32

set_fontsize_temp :: proc(new: i32) {
    using rl
    prev_font_size = GuiGetStyle(GuiControl.DEFAULT, auto_cast GuiDefaultProperty.TEXT_SIZE)

    GuiSetStyle(
        GuiControl.DEFAULT,
        auto_cast GuiDefaultProperty.TEXT_SIZE,
        new
    )
}

restore_fontsize :: proc() {
    using rl
    GuiSetStyle(GuiControl.DEFAULT, auto_cast GuiDefaultProperty.TEXT_SIZE, prev_font_size)
}