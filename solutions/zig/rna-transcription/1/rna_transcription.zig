const std = @import("std");
const mem = std.mem;

fn dnaToRna(c: u8) u8 {
    return switch (c) {
        'G' => 'C',
        'C' => 'G',
        'T' => 'A',
        'A' => 'U',
        else => c,
    };
}

pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    var rna: std.ArrayList(u8) = .empty;
    defer rna.deinit(allocator);

    for (dna) |c| {
        try rna.append(allocator, dnaToRna(c));
    }
    return rna.toOwnedSlice(allocator);
}
