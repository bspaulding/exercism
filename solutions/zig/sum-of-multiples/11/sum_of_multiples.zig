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
            if (l == 0) continue :outer;
            if (l >= limit) break;
        }

        if (@popCount(bits) % 2 != 0) {
            acc_pos +%= som(l, limit);
        } else {
            acc_neg +%= som(l, limit);
        }
    }

    return acc_pos -% acc_neg;
}

test "max u32 limit with a single factor" {
    const expected: u64 = 1_317_624_576_386_756_022;
    const factors = [_]u32{7};
    const limit = std.math.maxInt(u32);
    const actual = try sum(std.testing.allocator, &factors, limit);
    try std.testing.expectEqual(expected, actual);
}

test "max u32 limit with a dozen factors" {
    const expected: u64 = 7_851_662_787_625_716_044;
    const factors = [_]u32{ 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37 };
    const limit = std.math.maxInt(u32);
    const actual = try sum(std.testing.allocator, &factors, limit);
    try std.testing.expectEqual(expected, actual);
}

test "a zero factor first does not discard the other factors" {
    const expected: u64 = 3;
    const factors = [_]u32{ 0, 3 };
    const limit = 4;
    const actual = try sum(std.testing.allocator, &factors, limit);
    try std.testing.expectEqual(expected, actual);
}

test "a zero factor in the middle does not discard later factors" {
    const expected: u64 = 23;
    const factors = [_]u32{ 3, 0, 5 };
    const limit = 10;
    const actual = try sum(std.testing.allocator, &factors, limit);
    try std.testing.expectEqual(expected, actual);
}

test "intermediate positive and negative sums overflow u64 but the total fits" {
    // Every number below the limit is a multiple of 1, so the answer is 0 + 1 + ... + (limit - 1).
    const expected: u64 = 9_223_372_030_412_324_865;
    const factors = [_]u32{ 1, 2, 3, 4 };
    const limit = std.math.maxInt(u32);
    const actual = try sum(std.testing.allocator, &factors, limit);
    try std.testing.expectEqual(expected, actual);
}
