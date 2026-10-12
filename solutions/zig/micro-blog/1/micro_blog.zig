const std = @import("std");

pub fn truncate(phrase: []const u8) []const u8 {
    var len: usize = 0;
    var it = std.unicode.Utf8Iterator{ .bytes = phrase, .i = 0 };
    var i: u4 = 0;
    while (it.nextCodepointSlice()) |c| {
        len += c.len;
        i += 1;
        if (i == 5) break;
    }
    return phrase[0..len];
}
