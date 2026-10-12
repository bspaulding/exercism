const std = @import("std");
const mem = std.mem;

fn som(k: u64, limit: u32) u64 {
    const m: u64 = (limit - 1) / k;
    const sum_k: u64 = k * m * (m + 1) / 2;
    return sum_k;
}

pub fn sum(_: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    if (limit <= 1) return 0;

    var acc_pos: u64 = 0;
    var acc_neg: u64 = 0;
    const size: usize = (@as(usize, 1) << @intCast(factors.len)) - 1;
    outer: for (1..(size + 1)) |bits| {
        var l: u64 = 1;
        for (factors, 0..) |f, i| {
            if ((bits >> @intCast(i)) & 1 == 0) continue;

            l = (l / std.math.gcd(l, f)) * f;
            if (l == 0) break :outer;
            if (l >= limit) break;
        }

        if (@popCount(bits) % 2 != 0) {
            acc_pos +%= som(l, limit);
        } else {
            acc_neg +%= som(l, limit);
        }
    }

    return acc_pos - acc_neg;
}
