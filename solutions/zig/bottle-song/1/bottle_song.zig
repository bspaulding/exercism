const std = @import("std");

fn num_to_word(n: u32) []const u8 {
    return switch (n) {
        0 => "no",
        1 => "one",
        2 => "two",
        3 => "three",
        4 => "four",
        5 => "five",
        6 => "six",
        7 => "seven",
        8 => "eight",
        9 => "nine",
        10 => "ten",
        else => "bork",
    };
}
fn num_to_word_cap(n: u32) []const u8 {
    return switch (n) {
        0 => "No",
        1 => "One",
        2 => "Two",
        3 => "Three",
        4 => "Four",
        5 => "Five",
        6 => "Six",
        7 => "Seven",
        8 => "Eight",
        9 => "Nine",
        10 => "Ten",
        else => "Bork",
    };
}

pub fn recite(buffer: []u8, start_bottles: u32, take_down: u32) ![]const u8 {
    var i: u32 = 0;
    var total_printed: usize = 0;
    while (i < take_down) : (i += 1) {
        const nl = if (i == 0) "" else "\n\n";
        const bottles = start_bottles - i;
        const bottles_s = num_to_word_cap(bottles);
        const bottles_n_s = num_to_word(bottles - 1);
        const plural = if (bottles == 1) "" else "s";
        const plural_n = if (bottles == 2) "" else "s";
        const printed = try std.fmt.bufPrint(buffer[total_printed..], "{s}{s} green bottle{s} hanging on the wall,\n{s} green bottle{s} hanging on the wall,\nAnd if one green bottle should accidentally fall,\nThere'll be {s} green bottle{s} hanging on the wall.", .{ nl, bottles_s, plural, bottles_s, plural, bottles_n_s, plural_n });
        total_printed += printed.len;
    }
    return buffer[0..total_printed];
}
