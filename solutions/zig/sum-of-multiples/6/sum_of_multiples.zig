const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var multiples = try std.bit_set.DynamicBitSet.initEmpty(allocator, limit);
    defer multiples.deinit();

    for (factors) |f| {
        if (f == 0) {
            continue;
        }

        var n: usize = f;
        while (n < limit) : (n += f) multiples.set(n);
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
