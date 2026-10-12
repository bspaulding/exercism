const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var multiples = try std.bit_set.DynamicBitSet.initEmpty(allocator, limit);
    defer multiples.deinit();

    for (factors) |f| {
        for (0..limit) |m| {
            const n = m * f;
            if (n >= limit) {
                break;
            }
            multiples.set(n);
        }
    }

    var it = multiples.iterator(.{});
    var ix = it.next();
    var score: u64 = 0;
    while (ix != null) {
        score += ix.?;
        ix = it.next();
    }
    return score;
}

pub fn sum1(_: mem.Allocator, factors: []const u32, limit: u32) !u64 {
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
