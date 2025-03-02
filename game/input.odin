package game

import "core:fmt"
import rl "vendor:raylib"
import "../ui"

@(private)
handle_menu_key :: proc(using g: ^Game) {
    // Check keys
    switch state {
    case .Playing:
        state = .Paused
        ui.grab_control(false)
    case .Paused:
        state = .Playing
        ui.grab_control(true)
    case .MainMenuSettings:
        state = .MainMenu
    case .PausedSettings:
        state = .Paused
    case .MainMenu: {}
    }
}

handle_inputs :: proc(using g: ^Game, key: rl.KeyboardKey) {
    #partial switch key {
    case settings.controls.toggle_show_fps:
        show_fps ~= true
    case settings.controls.fullscreen:
        ui.toggle_fullscreen(&settings)
    case settings.controls.menu:
        handle_menu_key(g)
    }
}
handle_main_menu_option :: proc(g: ^Game, o: ui.MainMenuOption) {
    switch o {
    case .Exit:
        fmt.println("user requested exit...")
        g.running = false
    case .Start:
        g.state = .Playing
        ui.grab_control(true)
    case .Settings:
        g.state = .MainMenuSettings
    }
}

handle_pause_menu_option :: proc(g: ^Game, opt: ui.PauseMenuOption) {
    switch opt {
        case .Resume:
            g.state = .Playing
            ui.grab_control(true)
        case .BackToMenu:
            ui.show_popup(.ConfirmExit, "Exit to main menu?", "Are you sure you want to exit to the main menu?", "Yes;No")
        case .Settings:
            g.state = .PausedSettings
    }
}

handle_popup :: proc(g: ^Game) {
    if ui.popup == nil do return

    response := ui.draw_popup()

    switch ui.popup.?.kind {
    case .ConfirmExit:
        if response == 1 {
            g.running = false
        } else if response == 0 || response == 2 {
            ui.hide_popup()
        }
    }
}