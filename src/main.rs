use imgui::{Context, FontSource};
use raylib::prelude::*;
use raylib_imgui_rs::Renderer;

fn main() {
    // Init raylib
    let (mut rl, thread) = raylib::init()
        .resizable()
        .size(640, 480)
        .title("Hello, World")
        .build();

    let mut imgui = Context::create();

    // imgui
    // .fonts()
    // .add_font(&[FontSource::DefaultFontData { config: None }]);

    let mut renderer = Renderer::create(&mut imgui, &mut rl, &thread);

    while !rl.window_should_close() {
        renderer.update(&mut imgui, &mut rl);

        {
            let ui = imgui.new_frame();
            ui.show_demo_window(&mut true);
            // Draw Imgui stuff here
        }

        {
            let mut d = rl.begin_drawing(&thread);

            d.clear_background(Color::WHITE);
            // Draw raylib stuff here

            renderer.render(&mut imgui, &mut d);
        }
    }
}
