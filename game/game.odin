package game

import rl "vendor:raylib"

Game :: struct {
    running: bool
}

initialize :: proc(g: ^Game, title: cstring) {
    rl.InitWindow(800, 600, title)
    rl.InitAudioDevice()
    g.running = true
}

close :: proc(using g: ^Game) {

    rl.CloseAudioDevice()
    rl.CloseWindow()
}


update :: proc(using g: ^Game) {

}

draw :: proc(using g: ^Game){
     
}