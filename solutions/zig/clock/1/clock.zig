const std = @import("std");
const minutes_per_day = 24 * 60;

pub const Clock = struct {
    // This struct, as well as its fields and methods, needs to be implemented.
    t: u12,

    /// Initializes a Clock, normalizing the given hour and minute.
    pub fn init(hour: i32, minute: i32) Clock {
        return Clock{ .t = @intCast(@mod(hour * 60 + minute, minutes_per_day)) };
    }

    /// Moves the clock forwards by `minutes` minutes.
    pub fn advance(self: *Clock, minutes: i32) void {
        const ti: i32 = @intCast(self.t);
        self.t = @intCast(@mod(ti + minutes, minutes_per_day));
    }

    /// Moves the clock backwards by `minutes` minutes.
    pub fn rewind(self: *Clock, minutes: i32) void {
        const ti: i32 = @intCast(self.t);
        self.t = @intCast(@mod(ti - minutes, minutes_per_day));
    }

    /// Renders the time as "hh:mm".
    pub fn toString(self: Clock) [5]u8 {
        var str =  [5]u8{'0', '0', ':', '0', '0'};

        const hours: u8 = @truncate(self.t /  60);
        if (hours < 10) {
            str[1] = hours + 48;
        } else {
            const tens = hours / 10;
            str[0] = tens + 48;
            const ones = hours % 10;
            str[1] = ones + 48;
        }

        const minutes: u8 = @truncate(self.t % 60);
        if (minutes < 10) {
            str[4] = minutes + 48;
        } else {
            const tens = minutes / 10;
            str[3] = tens + 48;
            const ones = minutes % 10;
            str[4] = ones + 48;
        }
        return str;
    }

    /// Returns whether two clocks show the same time.
    pub fn eql(self: Clock, other: Clock) bool {
        return self.t == other.t;
    }
};
