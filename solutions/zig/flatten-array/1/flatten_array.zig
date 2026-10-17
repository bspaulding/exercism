const std = @import("std");
const mem = std.mem;

pub const Box = union(enum) {
    none,
    one: i12,
    many: []const Box,
};

pub fn flatten(allocator: mem.Allocator, box: Box) mem.Allocator.Error![]i12 {
    var xs: std.ArrayList(i12) = .empty;
    defer xs.deinit(allocator);

    var boxes: std.ArrayList(Box) = .empty;
    defer boxes.deinit(allocator);
    try boxes.append(allocator, box);

    while (boxes.pop()) |b| {
        switch (b) {
            .none => continue,
            .one => |x| try xs.append(allocator, x),
            .many => |boxen| {
                for (boxen) |b2| {
                    try boxes.append(allocator, b2);
                }
            }
        }
    }

    std.mem.reverse(i12, xs.items);
    return xs.toOwnedSlice(allocator);
}
