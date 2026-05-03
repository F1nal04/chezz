const rl = @import("raylib");
const gui = @import("gui.zig");

pub fn main() !void {
    rl.initWindow(gui.BOARD_SIZE, gui.BOARD_SIZE, "chezz");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        gui.drawBoard();
    }
}
