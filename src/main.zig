const rl = @import("raylib");
const gui = @import("gui.zig");
const board = @import("board.zig");

pub fn main() !void {
    rl.initWindow(gui.BOARD_SIZE, gui.BOARD_SIZE, "chezz");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    const textures = try gui.Textures.load();
    defer textures.unload();

    var b = board.Board{
        .pieces = .{ .{ 0, 0, 0, 0, 0, 0 }, .{ 0, 0, 0, 0, 0, 0 } },
        .occupied = .{ 0, 0 },
    };

    // White
    b.setPiece(0, .{ .color = .white, .type = .rook });
    b.setPiece(1, .{ .color = .white, .type = .knight });
    b.setPiece(2, .{ .color = .white, .type = .bishop });
    b.setPiece(3, .{ .color = .white, .type = .queen });
    b.setPiece(4, .{ .color = .white, .type = .king });
    b.setPiece(5, .{ .color = .white, .type = .bishop });
    b.setPiece(6, .{ .color = .white, .type = .knight });
    b.setPiece(7, .{ .color = .white, .type = .rook });
    for (8..16) |sq| b.setPiece(@intCast(sq), .{ .color = .white, .type = .pawn });

    // Black
    for (48..56) |sq| b.setPiece(@intCast(sq), .{ .color = .black, .type = .pawn });
    b.setPiece(56, .{ .color = .black, .type = .rook });
    b.setPiece(57, .{ .color = .black, .type = .knight });
    b.setPiece(58, .{ .color = .black, .type = .bishop });
    b.setPiece(59, .{ .color = .black, .type = .queen });
    b.setPiece(60, .{ .color = .black, .type = .king });
    b.setPiece(61, .{ .color = .black, .type = .bishop });
    b.setPiece(62, .{ .color = .black, .type = .knight });
    b.setPiece(63, .{ .color = .black, .type = .rook });

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        gui.drawBoard();
        gui.drawPieces(b, textures);
    }
}
