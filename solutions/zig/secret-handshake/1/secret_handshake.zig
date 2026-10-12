const std = @import("std");
const mem = std.mem;

pub const Signal = enum {
    wink,
    double_blink,
    close_your_eyes,
    jump, 
};

pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    var actions: std.ArrayList(Signal) = .empty;
    defer actions.deinit(allocator);
    
    inline for (0..4) |i| {
        if ((number >> i) & 1 == 1) {
            const action = switch (i) {
                0 => .wink,
                1 => .double_blink,
                2 => .close_your_eyes,
                3 => .jump,
                else => unreachable,
            };
            try actions.append(allocator, action);
        }
    }
    const reverse = (number >> 4) & 1 == 1;
    if (reverse) std.mem.reverse(Signal, actions.items);
    return actions.toOwnedSlice(allocator);
}
