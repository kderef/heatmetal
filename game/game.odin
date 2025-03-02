package game

// Settings are always saved, show fps on by default
DEBUG :: #config(DEBUG, false)

import rl "vendor:raylib"
import "core:fmt"

import "../settings"
import "../ui"

SETTINGS_FILE :: "settings.json"

Game :: struct {
    // Essential state
    running: bool,
    state: State,
    player: Player,
    // Settings
    show_fps: bool,
    settings_upon_load: settings.Settings,
    settings: settings.Settings,
}

initialize :: proc(g: ^Game, title: cstring) {
    flags := rl.ConfigFlags {
    }
    if DEBUG do flags += {rl.ConfigFlag.WINDOW_RESIZABLE}

    g.show_fps = DEBUG

    rl.SetConfigFlags(flags)

    // Load up raylib and such
    rl.InitWindow(cast(i32)ui.DEFAULT_WINDOW_SIZE[0], cast(i32)ui.DEFAULT_WINDOW_SIZE[1], title)
    rl.InitAudioDevice()
    rl.SetExitKey(rl.KeyboardKey.KEY_NULL)


    // Set all the fields
    g.running = true
    g.state = .MainMenu
    player_init(g)

    // Try read settings
    fmt.println("[SETTINGS]")
    fmt.printfln("settings file = \"%s\"", SETTINGS_FILE)

    set, err := settings.read(SETTINGS_FILE)
    if err != nil {
        fmt.printfln("Failed to read settings(%w), resorting to default", err)
        set = settings.default()

    } else {
        fmt.println("Read settings successfully.")
    }

    set.start_fullscreen = !DEBUG
    g.settings = set
    g.settings_upon_load = set
    fmt.printfln("settings = %#v", set)
    
    // Apply settings
    rl.SetTargetFPS(auto_cast g.settings.fps_limit)
    player_apply_settings(g)

    // Apply UI style
    ui.apply_style()
}

close :: proc(g: ^Game) {
    rl.CloseAudioDevice()
    rl.CloseWindow()
    fmt.println("Raylib successfully shutdown")

    // Only write settings if changed (or flag is set)
    settings_changed := g.settings != g.settings_upon_load

    if settings_changed || DEBUG {
        fmt.println("settings changed, saving...")
        settings_write_err := settings.write(&g.settings, SETTINGS_FILE)
        if settings_write_err != nil {
            fmt.printfln("Failed to write settings: %w", settings_write_err)
        }
    } else {
        fmt.println("settings have not changed, skipping save")
    }
}


update :: proc(using g: ^Game) {
    using rl

    g.running ~= WindowShouldClose()

    key := GetKeyPressed()

    handle_inputs(g, key)

    if state == .Playing {
        player_update_view(g)
    }
}


draw :: proc(using g: ^Game){
    using rl

    BeginDrawing()
    ClearBackground(BLACK)

    if ui.popup != nil do GuiDisable()

    switch state {
        case .MainMenu:
            chosen := ui.show_main_menu()
            if chosen != nil do handle_main_menu_option(g, chosen.?)
        case .Paused, .Playing:
            BeginMode3D(g.player.camera)
            render(g)
            EndMode3D()

            if state == .Paused {
                if opt := ui.show_pause_menu(); opt != nil {
                    handle_pause_menu_option(g, opt.?)
                }
            }
        case .MainMenuSettings, .PausedSettings:
            if ui.show_settings(&settings) {
                new_state: State = .MainMenu if state == .MainMenuSettings else .PausedSettings
                state = new_state
            }
    }

    GuiEnable()
    handle_popup(g)

    if show_fps do DrawFPS(0, 0)

    EndDrawing()
}