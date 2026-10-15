const std = @import("std");
const mem = std.mem;

/// Encodes `plaintext` using the square code. Caller owns the returned memory.
pub fn ciphertext(allocator: mem.Allocator, plaintext: []const u8) mem.Allocator.Error![]u8 {
    var normalized: std.ArrayList(u8) = .empty;
    defer normalized.deinit(allocator);

    for (plaintext) |c| {
        if (!std.ascii.isAlphanumeric(c)) continue;

        try normalized.append(allocator, std.ascii.toLower(c));
    }

    const len_f: f64 = @floatFromInt(normalized.items.len);
    const r: u64 = @round(std.math.sqrt(len_f));
    const c: u64 = if (r * r >= normalized.items.len) r else r + 1;

    var cipher: std.ArrayList(u8) = .empty;
    defer cipher.deinit(allocator);

    for (0..c) |c1| {
        for (0..r) |r1| {
            const i = r1 * c + c1;
            const cipher_c = if (i >= normalized.items.len) ' ' else normalized.items[i];
            try cipher.append(allocator, cipher_c);
        }
        if (c1 < c - 1) try cipher.append(allocator, ' ');
    }

    return cipher.toOwnedSlice(allocator);
}
