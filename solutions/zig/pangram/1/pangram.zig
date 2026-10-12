const std = @import("std");

pub fn isPangram(str: []const u8) bool {
    var counts = [_]u8{0} ** 26;
    for (str) |c| {
        if (!std.ascii.isAlphabetic(c)) {
            continue;
        }

        counts[std.ascii.toLower(c) - 'a'] += 1;
    }

    const counts_v: @Vector(26, u8) = counts;
    return @reduce(.Min, counts_v) > 0;
}
