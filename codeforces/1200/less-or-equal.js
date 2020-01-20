
// https://codeforces.com/problemset/problem/977/C
// Big O:
// Time complexity: O(n*log(n))
// Space complexity: O(n)

const readline = require("readline");

// Read input
var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let kValue;
rl.on('line', (input) => {
    if (kValue != undefined) {
        const numbers = input.split(" ").map(Number);
        console.log(findLessOrEqual(numbers, kValue));
        rl.close();
    } else {
        kValue = parseInt(input.split(" ")[1]);
    }
});

// Problem
function findLessOrEqual(numbers, kValue) {
    const orderedNumbers = numbers.sort((a, b) => a - b);

    if (kValue === numbers.length) {
        return numbers[kValue - 1];
    }

    const numberAtKPos = orderedNumbers[kValue];
    const comparisonValue = numberAtKPos - 1;

    if (comparisonValue === 0) {
        return -1;
    }

    if (kValue === 0) {
        return comparisonValue;
    }

    const previousNumber = orderedNumbers[kValue - 1];
    return previousNumber <= comparisonValue ? previousNumber : -1;
}