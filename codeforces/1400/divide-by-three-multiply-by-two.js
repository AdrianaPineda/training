// https://codeforces.com/contest/977/problem/D
// Big O:
// Time complexity:
// Space complexity:
const readline = require("readline");

// Read input
var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let length;
rl.on('line', (input) => {
    if (length != undefined) {
        console.log("asas");
        const a = BigInt(5);
        console.log(a);
        const numbers = input.split(" ").map((value) => BigInt(value));
        console.log(findPolycarpSequence(numbers, length));
        rl.close();
    } else {
        length = parseInt(input);
    }
});

function findPolycarpSequence(numbers, length) {

    console.log("start");
    const numbersOrdered = {}
    // Maps numbers to index position
    const numbersMap = {}
    numbers.forEach((value, index) => numbersMap[value] = index);

    let initial = BigInt(0);
    for (let i = 0; i < numbers.length; i++) {
        const currentNumber = numbers[i];
        const multipliedByTwo = currentNumber % BigInt(2) === BigInt(0) ? currentNumber / BigInt(2) : 0;

        if (multipliedByTwo > 0 && numbersMap[multipliedByTwo] >= 0) {
            numbersOrdered[multipliedByTwo] = currentNumber;
            continue;
        }

        const dividedByThree = currentNumber * BigInt(3);
        if (dividedByThree > 0 && numbersMap[dividedByThree] >= 0) {
            numbersOrdered[dividedByThree] = currentNumber;
            continue;
        }

        initial = currentNumber;
    }

    let result = `${initial}`;
    let nextNumber = numbersOrdered[BigInt(initial)];
    while (nextNumber > 0) {
        result = `${result} ${nextNumber}`
        nextNumber = numbersOrdered[nextNumber] ? BigInt(numbersOrdered[nextNumber]) : 0;
    }

    return result;

}