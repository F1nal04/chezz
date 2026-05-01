const raylib = @import("raylib");

pub const Board = struct {
    squares: [8][8]Square,
};

pub const Square = struct {
    piece: ?Piece,
};

pub const Piece = struct {
    color: raylib.Color,
    type: PieceType,
};

pub const PieceType = enum {
    pawn,
    knight,
    bishop,
    rook,
    queen,
    king,
};

pub fn drawBoard(board: *Board) void {
    for (board.squares) |row| {
        for (row) |square| {
            if (square.piece) |piece| {
                raylib.DrawCircle(square.x, square.y, 10, piece.color);
            }
        }
    }
}
