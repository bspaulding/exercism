const std = @import("std");

pub fn binarySearch(comptime T: type, target: T, items_in: []const T) ?usize {
    var items = items_in;
    var shift: usize = 0;
    while (items.len > 0) {
        const middle_ix = items.len / 2;
        const middle = items[middle_ix];
        if (middle == target) {
            return middle_ix + shift;
        }
        if (items.len == 1) return null;
        if (middle > target) {
            items = items[0..middle_ix];
        } else {
            items = items[middle_ix..];
            shift += middle_ix;
        }
    }
    return null;
}
