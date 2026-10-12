pub fn squareRoot(radicand: usize) usize {
    var l: usize = 0;
    while ((l+1) * (l+1) <= radicand) : (l += 1) continue;
    return l;
}
