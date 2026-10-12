const std = @import("std");
const mem = std.mem;

pub fn format(allocator: mem.Allocator, name: []const u8, number: u10) ![]u8 {
    return try std.fmt.allocPrint(allocator, "{s}, you are the {d}{s} customer we serve today. Thank you!", .{ name, number, switch (number % 100) {
        11, 12, 13 => "th",
        else => switch (number % 10) {
            1 => "st",
            2 => "nd",
            3 => "rd",
            else => "th",
        },
    } });
}
