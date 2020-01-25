// https://codeforces.com/problemset/problem/1091/A
// Big O:
// Time complexity:
// Space complexity:

// Read input
const readline = require("readline")
var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

rl.on('line', (input) => {
    const numbers = input.split(" ").map(Number);
    const yellow = numbers[0];
    const blue = numbers[1];
    const red = numbers[2];
    console.log(findMaxOrnaments(yellow, blue, red));
    rl.close();
});

function findMaxOrnaments(yellow, blue, red) {
    const isYellowMinimum = yellow <= blue && yellow <= red

    if (isYellowMinimum) {
        return findMaxWithYellowMinimum(yellow, blue, red);
    }

    const isBlueMinimum = blue <= yellow && blue <= red;
    if (isBlueMinimum) {
        return findMaxWithBlueMinimum(yellow, blue, red);
    }

    return findMaxWithRedMinimum(yellow, blue, red);
}

function findMaxWithYellowMinimum(yellow, blue, red) {
    let solutionFound = false;

    let yellowChosen = yellow;
    let blueChosen = 0;
    let redChosen = 0;

    while (!solutionFound) {
        blueChosen = 1 + yellowChosen;
        redChosen = 2 + yellowChosen;
        if (blueChosen > blue || redChosen > red) {
            yellowChosen = yellowChosen - 1;
        } else {
            solutionFound = true;
        }

    }
    return yellowChosen + blueChosen + redChosen;
}

function findMaxWithBlueMinimum(yellow, blue, red) {
    let solutionFound = false;

    let yellowChosen = 0;
    let blueChosen = blue;
    let redChosen = 0;

    while (!solutionFound) {
        yellowChosen = blueChosen - 1;
        redChosen = blueChosen + 1;
        if (yellowChosen > yellow || redChosen > red) {
            blueChosen = blueChosen - 1;
        } else {
            solutionFound = true;
        }

    }

    return yellowChosen + blueChosen + redChosen;
}

function findMaxWithRedMinimum(yellow, blue, red) {
    let solutionFound = false;

    let yellowChosen = 0;
    let blueChosen = 0;
    let redChosen = red;

    while (!solutionFound) {
        yellowChosen = redChosen - 2;
        blueChosen = redChosen - 1;
        if (yellowChosen > yellow || blueChosen > blue) {
            redChosen = redChosen - 1;
        } else {
            solutionFound = true;
        }

    }
    return yellowChosen + blueChosen + redChosen;
}