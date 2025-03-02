package game

import "../settings"
import rl "vendor:raylib"

render :: proc(using g: ^Game) {
    using rl
    DrawGrid(1000, 20.0)
}