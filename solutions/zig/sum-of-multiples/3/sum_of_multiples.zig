const std = @import("std");
const mem = std.mem;

pub fn sum(_: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    if (factors.len == 0) {
        return 0;
    }

    var score: u64 = 0;
    for (0..limit) |n| {
        for (factors) |f| {
            if (f == 0) {
                continue;
            }
            if (n % f == 0) {
                score += n;
                break;
            }
        }
    }
    return score;
}
