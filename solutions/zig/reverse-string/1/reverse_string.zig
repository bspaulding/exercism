const std = @import("std");

/// Writes a reversed copy of `s` to `buffer`.
pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    const reversed = buffer[0..s.len];
    @memcpy(reversed, s);
    std.mem.reverse(u8, reversed);
    return reversed;
}
