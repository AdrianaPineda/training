// https://codeforces.com/problemset/problem/977/B
// Big O:
// n: string length
// Time complexity: O(n)
// Space complexity:

const readline = require("readline");

// Read input
var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let stringLength;
rl.on('line', (input) => {
    if (stringLength) {
        console.log(findMostCommonGram(input, stringLength));
        rl.close();
    } else {
        stringLength = input;
    }
});

// Problem
function findMostCommonGram(string, stringLength) {
    let mostCommonGram = "";
    let mostCommonGramOccurrences = 0;
    const gramOccurrences = {};

    for (let i = 0; i < stringLength - 1; i++) {
        const twogram = string[i] + string[i + 1];
        const occurrences = gramOccurrences[twogram] ? gramOccurrences[twogram] : 0;
        const currentOcurrences = occurrences + 1;
        if (currentOcurrences > mostCommonGramOccurrences) {
            mostCommonGram = twogram;
            mostCommonGramOccurrences = currentOcurrences;
        }

        gramOccurrences[twogram] = currentOcurrences;
    }

    return mostCommonGram;
}