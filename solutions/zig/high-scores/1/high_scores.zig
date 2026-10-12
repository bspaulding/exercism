const std = @import("std");

pub const HighScores = struct {
    latest_score: ?i32,
    top: [3]i32,
    top_n: u2,

    pub fn init(scores: []const i32) HighScores {
        var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
        defer arena.deinit();

        var allocator = arena.allocator();
        const sorted = allocator.dupe(i32, scores) catch unreachable;
        std.mem.sort(i32, sorted, {}, std.sort.desc(i32));

        var top = [3]i32{ 0, 0, 0 };
        var top_n: u2 = 3;
        for (0..top_n) |i| {
            if (i >= sorted.len) {
                top_n = @intCast(i);
                break;
            }
            top[i] = sorted[i];
        }

        const latest_score = if (scores.len == 0) null else scores[scores.len - 1];
        return HighScores{ .top = top, .top_n = top_n, .latest_score = latest_score };
    }

    pub fn latest(self: *const HighScores) ?i32 {
        return self.latest_score;
    }

    pub fn personalBest(self: *const HighScores) ?i32 {
        return if (self.top.len == 0) null else self.top[0];
    }

    pub fn personalTopThree(self: *const HighScores) []const i32 {
        return self.top[0..self.top_n];
    }
};
