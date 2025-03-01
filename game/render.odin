package game

import "../settings"
import rl "vendor:raylib"

GameState :: struct {
    camera: rl.Camera3D,
}

init_gamestate :: proc(gs: ^GameState) {
    gs.camera = rl.Camera3D {
        up = {0, 1, 0},
        position = {0, 0, 0},
        projection = rl.CameraProjection.PERSPECTIVE,
        target = {1, 0, 1},
    }
}

prepare_for_playing :: proc(g: ^Game) {
    rl.HideCursor()
}

end_playing :: proc(g: ^Game) {
    rl.ShowCursor()
}


apply_settings :: proc(gs: ^GameState, s: ^settings.Settings) {
    gs.camera.fovy = auto_cast s.fov
}

render :: proc(using g: ^Game) {

}