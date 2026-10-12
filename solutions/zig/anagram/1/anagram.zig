const std = @import("std");
const mem = std.mem;

/// Returns the set of strings in `candidates` that are anagrams of `word`.
/// Caller owns the returned memory.
pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var set = std.BufSet.init(allocator);
    errdefer set.deinit();

    var target_map = [_]usize{0} ** 26;
    for (word) |c| {
        target_map[std.ascii.toLower(c) - 'a'] += 1;
    }

    for (candidates) |candidate| {
        if (candidate.len != word.len) continue;
        var all_same = true;
        var candidate_map = [_]usize{0} ** 26;
        for (candidate, word) |c, w| {
            const kc = std.ascii.toLower(c);
            if (kc != std.ascii.toLower(w)) all_same = false;
            candidate_map[kc - 'a'] += 1;
        }
        if (!all_same and std.mem.eql(usize, &target_map, &candidate_map)) {
            try set.insert(candidate);
        }
    }
    return set;
}
