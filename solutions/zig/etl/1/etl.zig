const std = @import("std");
const mem = std.mem;

pub fn transform(allocator: mem.Allocator, legacy: std.AutoHashMap(i5, []const u8)) mem.Allocator.Error!std.AutoHashMap(u8, i5) {
    var by_letter = std.AutoHashMap(u8, i5).init(allocator);
    var it_legacy = legacy.iterator();
    while (it_legacy.next()) |entry| {
        const p: i5 = entry.key_ptr.*;
        const letters: []const u8 = entry.value_ptr.*;
        for (letters) |l| {
            try by_letter.put(std.ascii.toLower(l), p);
        }
    }
    return by_letter;
}
