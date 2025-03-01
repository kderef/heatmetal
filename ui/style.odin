package ui

import rl "vendor:raylib"
import "core:fmt"

apply_style :: proc() {
    using rl

    STYLE :: "assets/style_terminal.rgs"
    fmt.printfln("Loading style %s", STYLE)
    GuiLoadStyle("assets/style_terminal.rgs")

    GuiSetStyle(GuiControl.DEFAULT, auto_cast GuiDefaultProperty.TEXT_SIZE, 30)
}