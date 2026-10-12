const std = @import("std");
const mem = std.mem;

var multiples = std.bit_set.ArrayBitSet(u64, std.math.maxInt(u32)).initEmpty();

pub fn sum(_: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    // reset the static bit set
    multiples.setRangeValue(.{ .start = 0, .end = std.math.maxInt(u32) }, false);

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
