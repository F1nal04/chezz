const std = @import("std");

pub const PieceType = enum(u3) {
    pawn,
    knight,
    bishop,
    rook,
    queen,
    king,
};

pub const PieceColor = enum(u1) {
    white,
    black,
};

pub const Piece = packed struct {
    color: PieceColor,
    type: PieceType,
};

pub const Square = u6;
pub const BitBoard = u64;

pub const Board = struct {
    pieces: [2][6]BitBoard,
    occupied: [2]BitBoard,
    all: BitBoard = 0,

    pub fn bit(square: Square) BitBoard {
        return @as(BitBoard, 1) << square;
    }

    pub fn setPiece(self: *Board, square: Square, piece: Piece) void {
        const piece_color = @intFromEnum(piece.color);
        const piece_type = @intFromEnum(piece.type);
        const square_bit = Board.bit(square);

        self.pieces[piece_color][piece_type] |= square_bit;
        self.occupied[piece_color] |= square_bit;
        self.all |= square_bit;
    }

    pub fn removePiece(self: *Board, square: Square) void {
        const square_bit = Board.bit(square);
        const clear_bit = ~square_bit;

        for (0..2) |piece_color| {
            for (0..6) |piece_type| {
                self.pieces[piece_color][piece_type] &= clear_bit;
            }
            self.occupied[piece_color] &= clear_bit;
        }
        self.all &= clear_bit;
    }

    pub fn pieceAt(self: Board, square: Square) ?Piece {
        const mask = Board.bit(square);
        for (0..2) |piece_color| {
            for (0..6) |piece_type| {
                if ((self.pieces[piece_color][piece_type] & mask) != 0) {
                    return Piece{
                        .color = @enumFromInt(piece_color),
                        .type = @enumFromInt(piece_type),
                    };
                }
            }
        }
        return null;
    }
};
