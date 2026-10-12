const std = @import("std");

pub fn primes(buffer: []u32, limit: u12) []u32 {
    var buff_i: usize = 0;

    var marks: std.bit_set.StaticBitSet(4096) = .full;
    var i: u12 = 2;
    while (i <= limit) : (i += 1) {
        if (!marks.isSet(i)) continue;
        
        buffer[buff_i] = i;
        buff_i += 1;
        
        var n: u12 = i + i;
        while (n <= limit) : (n += i) {
            marks.unset(n);
        }
    }
    return buffer[0..buff_i];
}
