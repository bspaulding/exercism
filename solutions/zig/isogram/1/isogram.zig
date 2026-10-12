const std = @import("std");

pub fn isIsogram(str: []const u8) bool {
    var counts = [_]u8{0} ** 26;
    for (str) |c| {
        if (!std.ascii.isAscii(c)) {
            return false;
        }

        if (!std.ascii.isAlphabetic(c)) {
            continue;
        }

        const ci = std.ascii.toLower(c) - 'a';
        counts[ci] += 1;
        if (counts[ci] > 1) {
            return false;
        }
    }
    return true;

}
