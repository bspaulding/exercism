pub const ChessboardError = error{IndexOutOfBounds};

pub fn square(index: usize) ChessboardError!u64 {
    return switch (index) {
        1 => 1,
        2...64 => 2 * (try square(index - 1)),
        else => ChessboardError.IndexOutOfBounds,
    };
}

pub fn total() u64 {
    var x: u64 = 0;
    for (1..65) |n| {
        x += square(n) catch unreachable;
    }
    return x;
}
