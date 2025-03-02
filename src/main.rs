
use macroquad::prelude::*;

fn app() -> Conf {
    Conf {
        window_title: "HEATMETAL".to_owned(),
        ..Default::default()
    }
}


#[macroquad::main(app)]
async fn main() {
    loop {

        next_frame().await;
    }
}