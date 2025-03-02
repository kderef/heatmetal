package settings

import rl "vendor:raylib"

Key :: rl.KeyboardKey
MouseButton :: rl.MouseButton

Controls :: struct {
    fullscreen: Key,
    menu: Key,
    toggle_show_fps: Key,
}

default_controls :: proc() -> Controls {
    return Controls {
        fullscreen = Key.F11,
        menu = Key.ESCAPE,
        toggle_show_fps = Key.F5,
    }
}