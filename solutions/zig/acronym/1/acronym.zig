const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var tokens = std.mem.tokenizeAny(u8, words, " -_");
    var xs: std.ArrayList(u8) = .empty;
    while (tokens.next()) |w| {
        try xs.append(allocator, std.ascii.toUpper(w[0]));
    }
    return xs.toOwnedSlice(allocator);
}
