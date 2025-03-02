package ui

import "../settings"
import rl "vendor:raylib"
import "core:fmt"
import str "core:strconv"


buf_a: [64]u8
buf_b: [64]u8

// return true if exiting settings page
show_settings :: proc(set: ^settings.Settings) -> (exit: bool) {
    using rl

    // Return if escape
    if IsKeyPressed(KeyboardKey.ESCAPE) do return true

    screen_w := GetScreenWidth()
    screen_h := GetScreenHeight()

    center: Vector2 = {auto_cast screen_w, auto_cast screen_h} / 2.0

    PADDING :: 30
    
    // Settings text
    font := GuiGetFont()
    title_fsize: f32 = 50.0
    title_size := MeasureTextEx(font, "SETTINGS", cast(f32)title_fsize, 1.0)
    DrawTextEx(
        GuiGetFont(),
        "SETTINGS",
        {center.x, title_fsize + 10.0} - title_size / 2.0,
        title_fsize,
        1.0, GREEN
    )

    // Return button
    set_fontsize_temp(50)
    if GuiLabelButton({10, 10, 300, 50}, "< return") do return true
    restore_fontsize()

    // FPS slider
    slider_w := cast(f32)screen_w * 0.5
    slider_bounds := Rectangle {300, title_size.y * 2, slider_w , 50}
    fps_changed := slider("FPS Limit", slider_bounds, &set.fps_limit, settings.FPS_MIN, settings.FPS_MAX)

    // If changed, apply
    if fps_changed != nil {
        rl.SetTargetFPS(auto_cast fps_changed.?)
    }

    slider_bounds.y += slider_bounds.height + PADDING * 2
    if fov_changed := slider("FOV", slider_bounds, &set.fov, 60, 130); fov_changed != nil {
        
    }


    return false
}