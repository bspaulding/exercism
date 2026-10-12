const std = @import("std");

pub fn isArmstrongNumber(num: u128) bool {
    var x: u128 = num;
    var i: u128 = 0;
    while (x != 0) {
        x /= 10;
        i += 1;
    }

    x = num;
    var a: u128 = 0;
    while (x != 0) {
        a += std.math.pow(u128, x % 10, i);
        x /= 10;
    }

    return a == num;
}
