package ui

import rl "vendor:raylib"
import "vendor:microui"
import "core:fmt"

apply_style :: proc() {
    using rl

    STYLE :: "assets/style_terminal.rgs"
    fmt.printfln("Loading style %s", STYLE)
    GuiLoadStyle("assets/style_terminal.rgs")

    GuiSetStyle(GuiControl.DEFAULT, auto_cast GuiDefaultProperty.TEXT_SIZE, 30)
}

// Font size utils

prev_font_size: i32

set_fontsize :: proc(new: $T) {
    using rl
    new := cast(i32)new
    GuiSetStyle(
        .DEFAULT,
        auto_cast GuiDefaultProperty.TEXT_SIZE,
        new
    )
    GuiSetStyle(
        .DEFAULT,
        auto_cast GuiControlProperty.TEXT_PADDING,
        new
    )
}

set_fontsize_temp :: proc(new: i32) {
    using rl
    prev_font_size = GuiGetStyle(GuiControl.DEFAULT, auto_cast GuiDefaultProperty.TEXT_SIZE)
    set_fontsize(new)
}

restore_fontsize :: proc() {
    using rl
    set_fontsize_temp(prev_font_size)
    // GuiSetStyle(GuiControl.DEFAULT, auto_cast GuiDefaultProperty.TEXT_SIZE, prev_font_size)
    
}