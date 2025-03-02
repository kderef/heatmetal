package ui

import rl "vendor:raylib"

PopupType :: enum {
    ConfirmExit,
}
Popup :: struct {
    kind: PopupType,
    title, message, buttons: cstring
}

popup: Maybe(Popup) = nil

// show_popup("Quit?", "Are you sure?", "Yes;No")
show_popup :: proc(kind: PopupType, title, message: cstring, buttons: cstring) {
    using rl

    popup = Popup { kind, title, message, buttons }
}

draw_popup :: proc() -> i32 {
    using rl

    if popup == nil do return -1
    popup := popup.?

    screen_w := cast(f32)GetScreenWidth()
    screen_h := cast(f32)GetScreenHeight()

    center := Vector2{screen_w, screen_h} / 2

    popup_size := Vector2{screen_w, screen_h} * 0.5
    popup_pos := center - popup_size / 2

    bounds := Rectangle {
        popup_pos.x, popup_pos.y,
        popup_size.x, popup_size.y
    }

    return GuiMessageBox(
        bounds,
        popup.title,
        popup.message,
        popup.buttons
    )
}

hide_popup :: proc() {
    popup = nil
}