package ui

import rl "vendor:raylib"
import cfg "../settings"

DEFAULT_WINDOW_SIZE : cfg.Resolution : {800, 600}

set_window_size :: proc(r: cfg.Resolution) {
    rl.SetWindowSize(cast(i32)r[0], cast(i32)r[1])
}

is_fullscreen :: proc() -> bool {
    return rl.IsWindowFullscreen()
}


toggle_fullscreen :: proc(s: ^cfg.Settings) {
    // first, set the appropriate window size
    if rl.IsWindowFullscreen() {
        // restore
        rl.ToggleFullscreen()
        set_window_size(DEFAULT_WINDOW_SIZE)
    } else {
        set_window_size(s.resolution)
        rl.ToggleFullscreen()
    }

}

grab_control :: proc(control: bool) {
    using rl
    if control {
        HideCursor()
        DisableCursor()
    } else {
        ShowCursor()
        EnableCursor()
    }
}