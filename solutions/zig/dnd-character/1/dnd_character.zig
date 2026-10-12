const std = @import("std");

pub fn modifier(score: u8) i8 {
    // subtracting 10, divide by 2 and round down.
    return @divFloor(@as(i8, @intCast(score)) - 10, 2);
}

pub fn ability(random: std.Random) u8 {
    var rolls = [4]u8{ 0, 0, 0, 0 };
    for (rolls, 0..) |_, i| {
        rolls[i] = random.intRangeAtMost(u8, 1, 6);
    }
    std.mem.sort(u8, &rolls, {}, std.sort.desc(u8));
    var sum: u8 = 0;
    for (0..3) |i| {
        sum += rolls[i];
    }
    return sum;
}

pub const Character = struct {
    strength: u8,
    dexterity: u8,
    constitution: u8,
    intelligence: u8,
    wisdom: u8,
    charisma: u8,
    hitpoints: u8,

    pub fn init(random: std.Random) Character {
        const constitution = ability(random);
        return Character{
            .strength = ability(random),
            .dexterity = ability(random),
            .constitution = constitution,
            .intelligence = ability(random),
            .wisdom = ability(random),
            .charisma = ability(random),
            .hitpoints = @intCast(10 + modifier(constitution)),
        };
    }
};
