package game

ALWAYS_SAVE_SETTINGS :: #config(ALWAYS_SAVE_SETTINGS, false)

import rl "vendor:raylib"
import "core:fmt"

import "../settings"
import "../ui"

SETTINGS_FILE :: "settings.json"

Game :: struct {
    // Essential state
    running: bool,
    state: State,
    // Settings
    settings_upon_load: settings.Settings,
    settings: settings.Settings,
}

initialize :: proc(g: ^Game, title: cstring) {
    // Load up raylib and such
    rl.InitWindow(800, 600, title)
    rl.InitAudioDevice()
    rl.SetExitKey(rl.KeyboardKey.KEY_NULL)

    // Set all the fields
    g.running = true
    g.state = .MainMenu

    // Try read settings
    fmt.println("[SETTINGS]")
    fmt.printfln("settings file = \"%s\"", SETTINGS_FILE)

    set, err := settings.read(SETTINGS_FILE)
    if err != nil {
        fmt.printfln("Failed to read settings(%w), resorting to default", err)
        g.settings = settings.default()
    } else {
        fmt.println("Read settings successfully.")
    }
    set.show_fps = false // Hide FPS on startup
    g.settings = set
    g.settings_upon_load = set
    fmt.printfln("settings = %#v", set)
    
    // Apply settings
}

close :: proc(g: ^Game) {
    rl.CloseAudioDevice()
    rl.CloseWindow()
    fmt.println("Raylib successfully shutdown")

    // Only write settings if changed (or flag is set)
    g.settings.show_fps = false
    settings_changed := g.settings != g.settings_upon_load

    if settings_changed || ALWAYS_SAVE_SETTINGS {
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

    if IsKeyPressed(KeyboardKey.F5) {
        settings.show_fps ~= true
    }
}

handle_mainmenu_option :: proc(g: ^Game, o: ui.MainMenuOption) {
    switch o {
    case .Exit:
        fmt.println("user requested exit...")
        g.running = false
    case .Start:
        g.state = .Playing
    case .Settings:
        g.state = .Settings
    }
}

draw :: proc(using g: ^Game){
    using rl

    BeginDrawing()
    ClearBackground(BLACK)

    switch state {
        case .MainMenu:
            chosen := ui.show_main_menu()
            if chosen != nil do handle_mainmenu_option(g, chosen.?)
        case .Paused:
        case .Playing:
        case .Settings:
            ui.show_settings()
    }

    if settings.show_fps do DrawFPS(0, 0)

    EndDrawing()
}