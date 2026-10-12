const std = @import("std");
const mem = std.mem;

pub const ColorBand = enum{black, brown, red, orange, yellow, green, blue, violet, grey, white};

pub fn label(allocator: mem.Allocator, colors: []const ColorBand) mem.Allocator.Error![]u8 {
    var value: usize = @as(usize, @intFromEnum(colors[0])) * 10 + @intFromEnum(colors[1]);
    value *= std.math.pow(usize, 10, @intFromEnum(colors[2]));

    var m: usize = 0;
    var value_f: f64 = @floatFromInt(value);
    if (value_f >= 1000) {
        while (value_f > 1000) : (m += 1) {
            value_f /= 1000;
        }
    }

    const prefix = switch (m) {
        1 => "kilo",
        2 => "mega",
        3 => "giga",
        else => "",
    };

    return std.fmt.allocPrint(allocator, "{d} {s}ohms", .{value_f, prefix});
}
