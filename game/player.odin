package game

import rl "vendor:raylib"

Player :: struct {
    camera: rl.Camera3D,
}

player_init :: proc(using g: ^Game) {
    player.camera = rl.Camera3D {
        up = {0, 1, 0},
        position = {0, 0, 0},
        projection = rl.CameraProjection.PERSPECTIVE,
        target = {1, 0, 1},
    }
}

player_apply_settings :: proc(using g: ^Game) {
    player.camera.fovy = auto_cast settings.fov
}