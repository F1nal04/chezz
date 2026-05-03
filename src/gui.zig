const rl = @import("raylib");
const board = @import("board.zig");

pub const BOARD_SIZE: i32 = 640;
pub const SQUARE_SIZE: i32 = BOARD_SIZE / 8;

const LIGHT_WOOD = rl.Color{ .r = 240, .g = 208, .b = 155, .a = 255 };
const DARK_WOOD = rl.Color{ .r = 90, .g = 45, .b = 15, .a = 255 };

const PIECE_PATHS = [2][6][:0]const u8{
    .{
        "assets/white-pawn.png",
        "assets/white-knight.png",
        "assets/white-bishop.png",
        "assets/white-rook.png",
        "assets/white-queen.png",
        "assets/white-king.png",
    },
    .{
        "assets/black-pawn.png",
        "assets/black-knight.png",
        "assets/black-bishop.png",
        "assets/black-rook.png",
        "assets/black-queen.png",
        "assets/black-king.png",
    },
};

pub const Textures = struct {
    data: [2][6]rl.Texture,

    pub fn load() !Textures {
        var t: Textures = undefined;
        for (0..2) |c| {
            for (0..6) |p| {
                t.data[c][p] = try rl.loadTexture(PIECE_PATHS[c][p]);
            }
        }
        return t;
    }

    pub fn unload(self: Textures) void {
        for (0..2) |c| {
            for (0..6) |p| {
                rl.unloadTexture(self.data[c][p]);
            }
        }
    }
};

pub fn drawBoard() void {
    var row: i32 = 0;
    while (row < 8) : (row += 1) {
        var col: i32 = 0;
        while (col < 8) : (col += 1) {
            const is_light = @mod(row + col, 2) == 0;
            rl.drawRectangle(
                col * SQUARE_SIZE,
                row * SQUARE_SIZE,
                SQUARE_SIZE,
                SQUARE_SIZE,
                if (is_light) LIGHT_WOOD else DARK_WOOD,
            );
        }
    }
}

pub fn drawPieces(b: board.Board, textures: Textures) void {
    const sq: f32 = @floatFromInt(SQUARE_SIZE);

    for (0..8) |row| {
        for (0..8) |col| {
            const square: board.Square = @intCast((7 - row) * 8 + col);
            const piece = b.pieceAt(square) orelse continue;

            const tex = textures.data[@intFromEnum(piece.color)][@intFromEnum(piece.type)];
            const src = rl.Rectangle{
                .x = 0,
                .y = 0,
                .width = @floatFromInt(tex.width),
                .height = @floatFromInt(tex.height),
            };
            const dest = rl.Rectangle{
                .x = @as(f32, @floatFromInt(col)) * sq,
                .y = @as(f32, @floatFromInt(row)) * sq,
                .width = sq,
                .height = sq,
            };
            rl.drawTexturePro(tex, src, dest, .{ .x = 0, .y = 0 }, 0, .white);
        }
    }
}
