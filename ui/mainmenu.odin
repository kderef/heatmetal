package ui

import rl "vendor:raylib"

MainMenuOption :: enum {
    Start,
    Exit,
    Settings,
}

button :: proc(r: ^rl.Rectangle, text: cstring) -> bool {
    PADDING :: 15
    r.y += r.height + PADDING * 2

    return rl.GuiButton(r^, text)
}

exit_menu_shown := false

show_main_menu :: proc() -> Maybe(MainMenuOption) {
    using rl

    screen_w := cast(f32)GetScreenWidth()
    screen_h := cast(f32)GetScreenHeight()

    GRID_BG :: rl.Color{0, 117, 44, 155}
    draw_grid({0, 0, screen_w, screen_h}, 2, 50, GRID_BG)

    // Text size
    text_size := screen_w / 20
    set_fontsize(text_size)

    if exit_menu_shown do GuiDisable()

    button_size := Vector2{screen_w * 0.2, text_size * 1.2}
    button_bounds := Rectangle{
        screen_w / 2 - button_size.x / 2,
        text_size * 2, button_size.x ,button_size.y    
    }

    if button(&button_bounds, "play") do return .Start
    if button(&button_bounds, "settings") do return .Settings
    if button(&button_bounds, "exit") do exit_menu_shown = true

    if exit_menu_shown {
        GuiEnable()

        set_fontsize_temp(20)

        box_size := Vector2{screen_w, screen_h} / 2
        box_pos := Vector2{screen_w, screen_h} / 2 - box_size / 2
        box_bounds := Rectangle{box_pos.x, box_pos.y, box_size.x, box_size.y}
        choice := GuiMessageBox(box_bounds, "Do you want to quit?", "Are you sure you want to exit?", "Yes;No")

        restore_fontsize()

        if choice == 1 do return .Exit // 'Yes'
        if choice == 0 || choice == 2 do exit_menu_shown = false // 'X' button
    }

    return nil
}