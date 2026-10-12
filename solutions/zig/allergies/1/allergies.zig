const std = @import("std");
const EnumSet = std.EnumSet;

pub const Allergen = enum {
    eggs,
    peanuts,
    shellfish,
    strawberries,
    tomatoes,
    chocolate,
    pollen,
    cats,
};

pub fn isAllergicTo(score: u8, allergen: Allergen) bool {
    return score >> @intFromEnum(allergen) & 1 == 1;
}

pub fn initAllergenSet(score: usize) EnumSet(Allergen) {
    const score_u8: u8 = @truncate(score);
    var set = EnumSet(Allergen).initEmpty();
    for (std.enums.values(Allergen)) |allergen| {
        set.setPresent(allergen, isAllergicTo(score_u8, allergen));
    }
    return set;
}