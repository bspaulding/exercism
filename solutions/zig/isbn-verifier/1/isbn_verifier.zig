const std = @import("std");

pub fn isValidIsbn10(s: []const u8) bool {
    var sum: u16 = 0;
    var i_d: u8 = 0;
    for (s, 0..) |c, i_s| {
        if (c == '-') continue;
        if (!std.ascii.isDigit(c) and (i_s != s.len - 1 or c != 'X')) return false;
        const d = if (c == 'X') 10 else c - '0';
        sum += d * (10 - i_d);
        i_d += 1;
    }
    return i_d == 10 and sum % 11 == 0;
}
