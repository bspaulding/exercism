const std = @import("std");

pub fn clean(phrase: []const u8) ?[10]u8 {
    var x: [10]u8 = undefined;
    var i: u4 = 0;
    for (phrase) |c| {
        // skip non-digits
        if (!std.ascii.isDigit(c)) continue;
        if (i >= 10) return null;
        // skip 1 if its the first digit we see
        if (i == 0 and c == '1') continue;
        x[i] = c;
        i += 1;
    }

    return if (i == 10 and x[0] >= '2' and x[3] >= '2') x else null;
}
