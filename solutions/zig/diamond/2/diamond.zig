const std = @import("std");
const mem = std.mem;

pub fn rows(allocator: mem.Allocator, letter: u8) mem.Allocator.Error![][]u8 {
    std.debug.assert(letter >= 'A');
    std.debug.assert(letter <= 'Z');

    var diamond: std.ArrayList([]u8) = .empty;
    defer {
        for (diamond.items) |line| allocator.free(line);
        diamond.deinit(allocator);
    }

    const letter_i = letter - 'A';
    const d_size = 2 * letter_i + 1;
    var i: u8 = 0;
    while (i < d_size) : (i += 1) {
        var line: []u8 = try allocator.alloc(u8, d_size);
        errdefer allocator.free(line);
        @memset(line, ' ');

        const center = if (d_size == 0) 0 else d_size / 2;
        const row_letter_i = if (i <= d_size / 2) i else d_size - i - 1;

        line[center + row_letter_i] = 'A' + row_letter_i;
        line[center - row_letter_i] = 'A' + row_letter_i;

        try diamond.append(allocator, line);
    }

    return diamond.toOwnedSlice(allocator);
}
