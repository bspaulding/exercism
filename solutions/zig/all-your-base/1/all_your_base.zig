const std = @import("std");
const mem = std.mem;

pub const ConversionError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

/// Converts `digits` from `input_base` to `output_base`, returning a slice of digits.
/// Caller owns the returned memory.
pub fn convert(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || ConversionError)![]u32 {
    if (input_base <= 1) return ConversionError.InvalidInputBase;
    if (output_base <= 1) return ConversionError.InvalidOutputBase;

    var out: std.ArrayList(u32) = .empty;
    defer out.deinit(allocator);

    if (digits.len == 0) {
        try out.append(allocator, 0);
        return out.toOwnedSlice(allocator);
    }

    var n: u32 = 0;
    for (0..digits.len) |i| {
        const id = digits.len - 1 - i;
        const d = digits[id];
        if (d >= input_base) return ConversionError.InvalidDigit;
        n += d * std.math.pow(u32, input_base, @intCast(i));
    }

    if (n == 0) {
        try out.append(allocator, 0);
        return out.toOwnedSlice(allocator);
    }

    while (n > 0) {
        const d = n % output_base;
        try out.append(allocator, d);
        n /= output_base;
    }
    std.mem.reverse(u32, out.items);
    return out.toOwnedSlice(allocator);
}
