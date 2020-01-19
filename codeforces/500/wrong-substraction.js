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
    const lastDigitAsString = numberAsString[numberLength - 1];
    return parseInt(lastDigitAsString);
}

function removeLastDigit(number) {
    const { numberAsString, numberLength } = getNumberStringValues(number);
    return parseInt(numberAsString.slice(0, numberLength - 1));
}

function getNumberStringValues(number) {
    const numberAsString = number.toString()
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