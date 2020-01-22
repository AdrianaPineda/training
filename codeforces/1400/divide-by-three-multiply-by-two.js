// https://codeforces.com/contest/977/problem/D
// Big O:
// Time complexity:
// Space complexity:
const readline = require("readline");

// // Read input
// var rl = readline.createInterface({
//     input: process.stdin,
//     output: process.stdout
// });

// let length;
// rl.on('line', (input) => {
//     if (length != undefined) {
//         const numbers = input.split(" ").map(Number);
//         console.log(findPolycarpSequence(numbers, length));
//         rl.close();
//     } else {
//         length = parseInt(input);
//     }
// });

function findPolycarpSequence(numbers, length) {

    console.log("start");
    const numbersOrdered = {}
    // Maps numbers to index position
    const numbersMap = {}
    numbers.forEach((value, index) => numbersMap[value] = index);
    console.log(numbersMap);

    for (let i = 0; i < length; i++) {
        const currentNumber = numbers[i];
        console.log(currentNumber);
        const multipliedByTwo = currentNumber * 2;
        console.log(multipliedByTwo);

        if (multipliedByTwo > 0 && numbersMap[multipliedByTwo] >= 0) {
            numbersOrdered[currentNumber] = multipliedByTwo;
            continue;
        }

        const dividedByThree = currentNumber % 3 === 0 ? currentNumber / 3 : 0;
        console.log(dividedByThree);
        if (dividedByThree > 0 && numbersMap[dividedByThree] >= 0) {
            console.log("enter 2");
            numbersOrdered[currentNumber] = dividedByThree;
            continue;
        }

        // end of sequence
        console.log("final number", currentNumber);
        // const dividedByTwo = currentNumber % 2 === 0 ? currentNumber / 2 : 0;
        // const multipliedByThree = currentNumber * 3;
    }

    console.log(numbersOrdered);
    return numbersOrdered;

}

// findPolycarpSequence([4, 8, 6, 3, 12, 9], 6)
findPolycarpSequence([42, 28, 84, 126], 4);