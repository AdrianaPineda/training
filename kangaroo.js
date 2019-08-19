function kangaroo(x1, v1, x2, v2) {
    const jumps = (x1 - x2)/(v2 - v1);
    return jumps > 0 && (jumps % 1 === 0) ? "YES" : "NO"
}

// console.log(kangaroo(0, 2, 5, 3))
// console.log(kangaroo(0, 3, 4, 2))
console.log(kangaroo(4181, 3976, 6312, 988))