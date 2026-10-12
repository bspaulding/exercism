const std = @import("std");

pub fn twoFer(buffer: []u8, name: ?[]const u8) ![]u8 {
    const name1: []const u8 = if (name) |n| n else "you";
    return std.fmt.bufPrint(buffer, "One for {s}, one for me.", .{name1});
}
