const rl = @import("raylib");

pub const BOARD_SIZE: i32 = 640;
pub const SQUARE_SIZE: i32 = BOARD_SIZE / 8;

pub fn drawBoard() void {
    var row: i32 = 0;
    while (row < 8) : (row += 1) {
        var col: i32 = 0;
        while (col < 8) : (col += 1) {
            const is_light = @mod(row + col, 2) == 0;
            const color: rl.Color = if (is_light) .white else .black;
            rl.drawRectangle(
                col * SQUARE_SIZE,
                row * SQUARE_SIZE,
                SQUARE_SIZE,
                SQUARE_SIZE,
                color,
            );
        }
    }
}
