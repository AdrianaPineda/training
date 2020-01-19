// https://codeforces.com/problemset/problem/977/A
// Big O:
// n: iterations, m: length of the string
// Time complexity: O(n*m) => O(n)
// Space complexity: O(n*m) => O(n)

const readline = require("readline");

function substract(number, iterations) {

    let result = number;
    while (iterations > 0) {
        const lastDigit = getLastDigit(result);
        if (lastDigit == 0) {
            result = removeLastDigit(result);
        } else {
            result -= 1;
        }

        iterations--;
    }

    return result;
}

function getLastDigit(number) {
    const { numberAsString, numberLength } = getNumberStringValues(number);
    const lastDigit = numberAsString.charAt(numberLength - 1);
    return parseInt(lastDigit);
}

function removeLastDigit(number) {
    const { numberAsString, numberLength } = getNumberStringValues(number);
    const numberWithoutLastDigit = numberAsString.slice(0, numberLength - 1);
    return parseInt(numberWithoutLastDigit);
}

function getNumberStringValues(number) {
    const numberAsString = number.toString();
    const numberLength = numberAsString.length;
    return { numberAsString, numberLength }
}

// Read input
var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

rl.question("", function (line) {
    const input = line.split(" ");
    const number = parseInt(input[0]);
    const iterations = parseInt(input[1]);
    console.log(substract(number, iterations));

    rl.close();
});