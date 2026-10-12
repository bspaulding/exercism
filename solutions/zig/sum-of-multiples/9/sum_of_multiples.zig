const std = @import("std");
const mem = std.mem;

fn som(k: u64, limit: u32) u64 {
    const m: u64 = (limit - 1) / k;
    const sum_k: u64 = k * m * (m + 1) / 2;
    return sum_k;
}

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    if (limit <= 1) return 0;

    var acc_pos: u64 = 0;
    var acc_neg: u64 = 0;
    const mask_size: usize = std.math.pow(usize, 2, factors.len) - 1;
    const Set = std.bit_set.IntegerBitSet(@bitSizeOf(@TypeOf(mask_size)));
    for (1..(mask_size + 1)) |bits| {
        var set = Set{ .mask = bits };
        var fs: std.ArrayList(u32) = .empty;
        defer fs.deinit(allocator);

        var it = set.iterator(.{});
        while (it.next()) |ix| {
            try fs.append(allocator, factors[ix]);
        }
        const m = lcm(fs.items, limit);
        if (m == 0 or m >= limit) {
            continue;
        }
        if (fs.items.len % 2 != 0) {
            acc_pos +%= som(m, limit);
        } else {
            acc_neg +%= som(m, limit);
        }
    }

    return acc_pos - acc_neg;
}

fn lcm(factors: []u32, limit: u32) u64 {
    var l: u64 = factors[0];
    for (factors[1..]) |b| {
        l = (l / std.math.gcd(l, b)) * b;
        if (l >= limit) break;
    }

    return l;
}
