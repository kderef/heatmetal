package settings

import "core:encoding/json"
import "core:os"
import "core:io"

Settings :: struct {
    show_fps: bool,
    start_fullscreen: bool,
    fps_limit: u32,
    fov: u32,
}

Error :: union {
    os.Error,
    json.Unmarshal_Error,
    json.Marshal_Error
}

default :: proc() -> Settings {
    return Settings {
        show_fps = true,
        start_fullscreen = true,
        fov = 80,
        fps_limit = monitor_refresh_rate() 
    }
}

write :: proc(settings: ^Settings, filename: string) -> Maybe(Error) {
    options := json.Marshal_Options {
        pretty = true,
        use_enum_names = true,
    }

    data := json.marshal(settings^, options) or_return
    os.write_entire_file_or_err(filename, data) or_return

    return nil // OK!
}

read :: proc(filename: string) -> (set: Settings, err: Error) {
    err = nil

    data := os.read_entire_file_from_filename_or_err(filename) or_return
    json.unmarshal(data, &set) or_return

    return
}