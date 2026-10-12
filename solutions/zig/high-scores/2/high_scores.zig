const std = @import("std");

pub const HighScores = struct {
    latest_score: ?i32,
    top: [3]i32,
    top_n: u2,

    pub fn init(scores: []const i32) HighScores {
        const latest_score = if (scores.len == 0) null else scores[scores.len - 1];

        var top = [4]i32{ 0, 0, 0, 0 };
        for (scores) |s| {
            top[3] = s;
            std.mem.sort(i32, &top, {}, std.sort.desc(i32));
        }
        const top_n: u2 = if (scores.len < 3) @intCast(scores.len) else 3;

        return HighScores{ .top = [3]i32{ top[0], top[1], top[2] }, .top_n = top_n, .latest_score = latest_score };
    }

    pub fn latest(self: *const HighScores) ?i32 {
        return self.latest_score;
    }

    pub fn personalBest(self: *const HighScores) ?i32 {
        return if (self.top_n == 0) null else self.top[0];
    }

    pub fn personalTopThree(self: *const HighScores) []const i32 {
        return self.top[0..self.top_n];
    }
};
