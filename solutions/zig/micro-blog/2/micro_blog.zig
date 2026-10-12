const std = @import("std");

pub fn truncate(phrase: []const u8) []const u8 {
    var it = std.unicode.Utf8View.initUnchecked(phrase).iterator();
    return it.peek(5);
}
