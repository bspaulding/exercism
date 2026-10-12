const std = @import("std");

pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

/// Asserts that `n` is nonzero.
pub fn classify(n: u64) Classification {
    var sum: usize = 0;
    for (1..n) |ni| {
        const mod = n % ni;
        if (mod != 0) continue;
        sum += ni;
    }

    // sum == 0 means no factors
    if (sum == 0 or sum < n) return .deficient;
    if (n == sum) return .perfect;
    return .abundant;
}
