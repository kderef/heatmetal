package ui

import rl "vendor:raylib"
import "core:math"

PopupType :: enum {
    ConfirmExit,
}
Popup :: struct {
    kind: PopupType,
    title, message, buttons: cstring,
    render_target: rl.RenderTexture,
}

popup: Maybe(Popup) = nil

// show_popup("Quit?", "Are you sure?", "Yes;No")
show_popup :: proc(kind: PopupType, title, message: cstring, buttons: cstring) {
    using rl

    sw := GetScreenWidth()
    sh := GetScreenHeight()

    render_target := LoadRenderTexture(sw / 2, sh / 2)
    popup = Popup { kind, title, message, buttons, render_target }
}

draw_popup :: proc() -> i32 {
    using rl

    if popup == nil do return -1

    popup := popup.?

    screen_w := cast(f32)GetScreenWidth()
    screen_h := cast(f32)GetScreenHeight()

    center := Vector2{screen_w, screen_h} / 2

    popup_size := Vector2{screen_w, screen_h} * 0.5
    popup_pos := center - popup_size

    bounds := Rectangle {
        popup_pos.x, popup_pos.y,
        popup_size.x, popup_size.y
    }

    factor := GetScreenWidth() / 50
    fontsize := clamp(factor, 20, 100)


    tex_w := cast(i32)bounds.width
    tex_h := cast(i32)bounds.height
    if popup.render_target.texture.width != tex_w || popup.render_target.texture.height != tex_h {
        UnloadRenderTexture(popup.render_target)
        popup.render_target = LoadRenderTexture(cast(i32)bounds.width / 2, cast(i32)bounds.height / 2)
    }

    BeginTextureMode(popup.render_target)

    // set_fontsize_temp(fontsize)
    choice := GuiMessageBox(
        bounds,
        popup.title,
        popup.message,
        popup.buttons
    )
    EndTextureMode()
    // restore_fontsize()

    DrawTextureEx(
        popup.render_target.texture,
        popup_pos,
        180, 2, WHITE
    )

    return choice
}

hide_popup :: proc() {
    if popup != nil {
        rl.UnloadRenderTexture(popup.?.render_target)
        popup = nil
    }
}