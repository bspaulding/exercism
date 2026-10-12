const std = @import("std");
const mem = std.mem;

var multiples = std.bit_set.ArrayBitSet(u64, std.math.maxInt(u32)).initEmpty();

fn som(k: u64, limit: u32) u64 {
    const m: u64 = (limit - 1) / k;
    const sum_k: u64 = k * m * (m + 1) / 2;
    return sum_k;
}

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
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
        const m = lcm(fs.items);
        if (m == 0) {
            continue;
        }
        if (fs.items.len % 2 != 0) {
            acc_pos += som(m, limit);
        } else {
            acc_neg += som(m, limit);
        }
    }

    return acc_pos - acc_neg;
}

pub fn lcm(factors: []u32) u64 {
    if (factors.len == 0) {
        return 0; // hack
    }

    var l: u64 = factors[0];
    for (factors[1..]) |b| {
        l = (l / gcd(l, b)) * b;
    }

    return l;
}

pub fn gcd(ain: u64, bin: u64) u64 {
    if (bin == 0) {
        return 1; // hack
    }
    var a = ain;
    var b = bin;
    var r = a % b;
    while (r != 0) {
        a = b;
        b = r;
        r = a % b;
    }
    return b;
}
