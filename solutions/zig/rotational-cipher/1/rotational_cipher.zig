const std = @import("std");
const mem = std.mem;

pub fn rotate(allocator: mem.Allocator, text: []const u8, shiftKey: u5) mem.Allocator.Error![]u8 {
    var buff = try allocator.alloc(u8, text.len);
    for (text, 0..) |c, i| {
        if (!std.ascii.isAlphabetic(c)) {
            buff[i] = c;
            continue;
        }
        const shift_base: u8 = if (std.ascii.isUpper(c)) 'A' else 'a';
        const shift = ((c - shift_base) + shiftKey) % 26 + shift_base;
        buff[i] = shift;
    }
    return buff;
}
