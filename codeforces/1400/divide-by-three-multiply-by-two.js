// https://codeforces.com/contest/977/problem/D
// Big O:
// Time complexity: O(n)
// Space complexity: O(n)
const readline = require("readline");

// Read input
var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let length;
rl.on('line', (input) => {
    if (length != undefined) {
        const numbers = input.split(" ").map((value) => BigInt(value));
        console.log(findPolycarpSequence(numbers, length));
        rl.close();
    } else {
        length = parseInt(input);
    }
});

function findPolycarpSequence(numbers, length) {

    const numbersOrdered = {}
    // Maps numbers to index position
    const numbersMap = {}
    numbers.forEach((value, index) => numbersMap[value] = BigInt(index));

    let initial = BigInt(0);
    for (let i = 0; i < length; i++) {
        const currentNumber = BigInt(numbers[i]);
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

// console.log(findPolycarpSequence([4, 8, 6, 3, 12, 9], 6))
// console.log(findPolycarpSequence([42, 28, 84, 126], 4));