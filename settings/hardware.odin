package settings

import rl "vendor:raylib"
import "core:fmt"

monitor_refresh_rate :: proc() -> u32 {
    monitor := rl.GetCurrentMonitor()
    refresh := rl.GetMonitorRefreshRate(monitor)
    return auto_cast refresh
}

monitor_resolution :: proc() -> Resolution {
    monitor := rl.GetCurrentMonitor()
    resolution := Resolution {
        cast(u32)rl.GetMonitorWidth(monitor),
        cast(u32)rl.GetMonitorHeight(monitor)
    }
    return resolution
}