const std = @import("std");

pub fn response(s: []const u8) []const u8 {
    const trimmed = std.mem.trim(u8, s, &std.ascii.whitespace);

    var is_yell = true;
    var is_silence = true;
    var seen_alpha = false;
    for (trimmed) |c| {
        if (!std.ascii.isWhitespace(c)) is_silence = false;
        const alpha = std.ascii.isAlphabetic(c);
        if (alpha) seen_alpha = true;
        if (alpha and !std.ascii.isUpper(c)) is_yell = false;
    }
    if (is_silence) return "Fine. Be that way!";
    const is_question = trimmed[trimmed.len - 1] == '?';
    is_yell &= seen_alpha;
    if (is_question and !is_yell) return "Sure.";
    if (is_question and is_yell) return "Calm down, I know what I'm doing!";
    if (!is_question and is_yell) return "Whoa, chill out!";
    return "Whatever.";

}
