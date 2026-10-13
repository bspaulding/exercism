const std = @import("std");
const mem = std.mem;

/// Encodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var cipher: std.ArrayList(u8) = .empty;
    defer cipher.deinit(allocator);

    var word_i: u4 = 0;
    for (s) |c| {
        if (!std.ascii.isAlphanumeric(c)) continue;

        if (word_i == 5) {
            try cipher.append(allocator, ' ');
            word_i = 0;
        }

        if (std.ascii.isDigit(c)) {
            try cipher.append(allocator, c);
        } else {
            const lower_c = std.ascii.toLower(c);
            const alpha_i = lower_c - 'a';
            try cipher.append(allocator, 'a' + (25 - alpha_i));
        }
        word_i += 1;
    }

    return cipher.toOwnedSlice(allocator);
}

/// Decodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var cipher: std.ArrayList(u8) = .empty;
    defer cipher.deinit(allocator);

    for (s) |c| {
        if (std.ascii.isDigit(c)) {
            try cipher.append(allocator, c);
        }
        if (!std.ascii.isAlphabetic(c)) continue;

        const lower_c = std.ascii.toLower(c);
        const alpha_i = lower_c - 'a';
        try cipher.append(allocator, 'a' + (25 - alpha_i));
    }

    return cipher.toOwnedSlice(allocator);
}
