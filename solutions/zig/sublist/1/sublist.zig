pub const Relation = enum {
    equal,
    sublist,
    superlist,
    unequal,
};

pub fn compare(list_one: []const i32, list_two: []const i32) Relation {
    if (list_one.len == 0 and list_two.len == 0) return .equal;
    if (list_one.len == 0 and list_two.len != 0) return .sublist;
    if (list_one.len != 0 and list_two.len == 0) return .superlist;
        
    const big, const small = if (list_one.len >= list_two.len) .{list_one,list_two} else .{list_two, list_one};

    var i: usize = 0;
    var found = false;
    const step = small.len;
    outer: while (i + step <= big.len) : (i += 1) {
        const end = i + step;
        for (big[i..end], small) |big_elem, small_elem| {
            if (big_elem != small_elem) continue :outer;
        }
        found = true;
        break;
    }
    if (!found) return .unequal;
    if (big.len == small.len) return .equal;
    if (list_one.len > list_two.len) return .superlist;
    return .sublist;
}
