// https://codeforces.com/problemset/problem/270/A
// Big O:
// Time complexity: O(n)
// Space complexity: O(n)

// Read input
var readline = require("readline");
var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let tests;
let angles = [];
let counter = 0;
rl.on('line', (input) => {
    if (!tests) {
        tests = parseInt(input);
        return;
    }

    counter++;
    if (counter <= tests) {
        angles.push(parseInt(input));
    }

    if (counter === tests) {
        solve(angles);
        rl.close();
    }

});

function solve(angles) {
    for (angle of angles) {
        const output = isRegularPolygon(angle) ? "YES" : "NO";
        console.log(output);
    }
}

// Problem
// For a regular convex n-gon, each interior angle has a measure of: 180(n-2)/n degrees
function isRegularPolygon(angle) {
    const modulus = 360 % (180 - angle);
    return modulus === 0;
}
