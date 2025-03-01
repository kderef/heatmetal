package ui
import rl "vendor:raylib"
import "core:fmt"
import "core:mem"

clear_bufs :: proc() {
    mem.zero(&buf_a, len(buf_a))
    mem.zero(&buf_b, len(buf_b))
}

cstr :: proc(b: ^$T) -> cstring {
    return cstring(raw_data(b))
}

slider :: proc(expl: string, bounds: rl.Rectangle, val: ^$T, min: T, max: T) -> Maybe(T) {
    old := val^

    clear_bufs()

    val_float := cast(f32)val^
    fmt.bprintf(buf_a[:], "%s %v - %v", expl, val^, min)
    fmt.bprintf(buf_b[:], "%v", max)

    rl.GuiSlider(bounds, cstr(&buf_a), cstr(&buf_b), &val_float, auto_cast min, auto_cast max)

    new_val := cast(T)val_float

    if new_val != old {
        val^ = new_val
        return new_val
    }
    return nil
}

draw_grid :: proc(bounds: rl.Rectangle, width: f32, cell_size: i32, color: rl.Color) {
    cols := cast(i32)bounds.width / cell_size
    rows := cast(i32)bounds.height / cell_size

    start_x, start_y: f32
    x, y: i32

    for y = 0; y <= rows; y += 1 {
        start_y = bounds.y + cast(f32)(y * cell_size)
        rl.DrawLineV({bounds.x, start_y}, {bounds.x + bounds.width, start_y}, color)
    }

    for x = 0; x <= cols; x += 1 {
        start_x = bounds.x + cast(f32)(x * cell_size)
        rl.DrawLineV({start_x, bounds.y}, {start_x, bounds.y + bounds.height}, color)
    } 
}