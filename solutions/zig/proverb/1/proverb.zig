const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;

pub fn recite(allocator: mem.Allocator, words: []const []const u8) mem.Allocator.Error![][]u8 {
    if (words.len == 0) return &[_][]u8{};
    
    var lines: std.ArrayList([]u8) = .empty;
    errdefer {
        for (lines.items) |line| allocator.free(line);
        lines.deinit(allocator);
    }

    for (words[0..words.len - 1], words[1..]) |a, b| {
        const line = try std.fmt.allocPrint(allocator, "For want of a {s} the {s} was lost.\n", .{a, b});
        errdefer allocator.free(line);
        try lines.append(allocator, line);
    }
    {
        const line = try std.fmt.allocPrint(allocator, "And all for the want of a {s}.\n", .{words[0]});
        errdefer allocator.free(line);
        try lines.append(allocator, line);
    }
    return lines.toOwnedSlice(allocator);
}
