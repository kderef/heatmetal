package settings

import rl "vendor:raylib"
import "core:fmt"

monitor_refresh_rate :: proc() -> u32 {
    monitor := rl.GetCurrentMonitor()
    refresh := rl.GetMonitorRefreshRate(monitor)
    fmt.println(cast(u32)refresh)
    return auto_cast refresh
}