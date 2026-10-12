pub const QueenError = error{
    InitializationFailure,
};

pub const Queen = struct {
    row: u8,
    col: u8,
    
    pub fn init(row: i8, col: i8) QueenError!Queen {
        if (row < 0 or row > 7 or col < 0 or col > 7) {
            return QueenError.InitializationFailure;
        }
        return Queen{.row = @intCast(row), .col = @intCast(col)};
    }

    pub fn canAttack(self: Queen, other: Queen) QueenError!bool {
        if (self.row == other.row or self.col == other.col) return true;

        // positive diagonal -> y= col - row
        if (self.col >= self.row and other.col >= other.row and self.col - self.row == other.col - other.row) return true;

        // negative diagonal -> y= col + row
        if (self.col + self.row == other.col + other.row) return true;

        return false;
    }
};
