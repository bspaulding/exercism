const std = @import("std");
const mem = std.mem;

pub const TranslationError = error{
    InvalidCodon,
};

pub const Protein = enum {
    methionine, // AUG
    phenylalanine, // UUU, UUC
    leucine, // UUA, UUG
    serine, // UCU, UCC, UCA, UCG
    tyrosine, // UAU, UAC
    cysteine, // UGU, UGC
    tryptophan, // UGG
    // UAA, UAG, UGA <- STOP
};

const protein_map = std.StaticStringMap(Protein).initComptime(.{
    .{ "AUG", .methionine },
    .{ "UUU", .phenylalanine },
    .{ "UUC", .phenylalanine },
    .{ "UUA", .leucine },
    .{ "UUG", .leucine },
    .{ "UCU", .serine },
    .{ "UCC", .serine },
    .{ "UCA", .serine },
    .{ "UCG", .serine },
    .{ "UAU", .tyrosine },
    .{ "UAC", .tyrosine },
    .{ "UGU", .cysteine },
    .{ "UGC", .cysteine },
    .{ "UGG", .tryptophan },
});

const stop_codons = [_][]const u8{ "UAA", "UAG", "UGA" };

pub fn proteins(allocator: mem.Allocator, strand: []const u8) (mem.Allocator.Error || TranslationError)![]Protein {
    if (strand.len < 3) return &[_]Protein{};

    var ps: std.ArrayList(Protein) = .empty;
    defer ps.deinit(allocator);

    var i: usize = 0;
    while (i < (strand.len - 2)) : (i += 1) {
        if (strand[i] != 'A' and strand[i] != 'C' and strand[i] != 'G' and strand[i] != 'U') return TranslationError.InvalidCodon;
        const triple: []const u8 = strand[i .. i + 3];
        for (stop_codons) |stop| {
            if (std.mem.eql(u8, triple, stop)) return ps.toOwnedSlice(allocator);
        }
        const p = protein_map.get(triple);
        if (p != null) {
            try ps.append(allocator, p.?);
            i += 2;
        }
    }
    if (i != strand.len) return TranslationError.InvalidCodon;
    return ps.toOwnedSlice(allocator);
}
