const std = @import("std");
const mem = std.mem;

const wheel = [_]u8{ 4, 2, 4, 2, 4, 6, 2, 6 };

pub fn factors(allocator: mem.Allocator, value: u64) mem.Allocator.Error![]u64 {
    var fs: std.ArrayList(u64) = .empty;
    defer fs.deinit(allocator);

    var wheel_i: u4 = 0;

    var x: u128 = if (value == 0) 1 else value;
    var divisor: u128 = 2;
    while (x != 1 and (divisor * divisor) <= x) {
        if (x % divisor != 0) {
            // basis cases 2,3,5,7
            if (divisor == 2) {
                divisor = 3;
            } else if (divisor == 3) {
                divisor = 5;
            } else if (divisor == 5) {
                divisor = 7;
            } else { // wheel
                divisor += wheel[wheel_i];
                wheel_i = if (wheel_i == wheel.len - 1) 0 else wheel_i + 1;
            }
            continue;
        }

        try fs.append(allocator, @intCast(divisor));
        x /= divisor;
    }
    if (value != 1 and value % x == 0) {
        try fs.append(allocator, @intCast(x));
    }
    if (value != 1 and fs.items.len == 0) {
        try fs.append(allocator, value);
    }

    return fs.toOwnedSlice(allocator);
}
