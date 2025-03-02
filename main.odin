package main

import "game"

main :: proc() {
    g: game.Game

	game.initialize(&g, "Heatmetal")

    for g.running {
        game.update(&g);
        game.draw(&g);
    }

    game.close(&g)
}
