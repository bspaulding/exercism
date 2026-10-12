pub const Plant = enum {
    clover,
    grass,
    radishes,
    violets,
};

fn parsePlant(p: u8) Plant {
    return switch (p) {
        'C' => .clover,
        'G' => .grass,
        'R' => .radishes,
        'V' => .violets,
        else => unreachable,
    };
}

pub fn plants(diagram: []const u8, student: []const u8) [4]Plant {
    // student offset, Alice -> 0, Bob -> 2, Charlie -> 4 etc.
    const offset: u8 = (student[0] - 'A') * 2;
    // next row offset, including newline
    const row = diagram.len / 2 + 1;

    return [4]Plant{
        parsePlant(diagram[offset]),
        parsePlant(diagram[offset + 1]),
        parsePlant(diagram[row + offset]),
        parsePlant(diagram[row + offset + 1]),
    };
}
