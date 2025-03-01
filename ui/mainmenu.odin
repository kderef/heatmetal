package ui

import rl "vendor:raylib"

MainMenuOption :: enum {
    Start,
    Exit,
    Settings,
}

button :: proc(r: rl.Rectangle, text: cstring) -> bool {

    return rl.GuiButton(r, text)
}

show_main_menu :: proc() -> Maybe(MainMenuOption) {
    if button({10, 10, 200, 50}, "play") do return .Start
    if button({10, 210, 200, 50}, "settings") do return .Settings
    if button({10, 410, 200, 50}, "exit") do return .Exit

    return nil
}