// https://codeforces.com/problemset/problem/1238/A
// Big O:
// Time complexity:
// Space complexity:

// Read input
var readline = require("readline");
var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let testCases;
let responses = [];
rl.on('line', (input) => {

    if (testCases === undefined) {
        testCases = parseInt(input);
        return;
    }

    if (testCases > 0) {
        const numbers = input.split(" ");
        responses.push(canBeSubstracted(numbers[0], numbers[1]));
        testCases--;
    }

    if (testCases <= 0) {
        responses.forEach((response) => console.log(response));
        rl.close();
    }
});

// Problem
function canBeSubstracted(x, y) {
    const difference = x - y;
    return isDividedByPrimeNumber(difference) ? "YES" : "NO";
}

function isDividedByPrimeNumber(number) {
    for (let i = 2; i <= number; i++) {
        const isPrime = isPrimeNumber(i);
        if (!isPrime) {
            continue;
        }
        if (number % i === 0) {
            return true
        }
    }
    return false;
}

function isPrimeNumber(number) {
    for (let i = 2; i < number; i++) {
        if (number % i === 0) {
            return false;
        }
    }

    return true;
}