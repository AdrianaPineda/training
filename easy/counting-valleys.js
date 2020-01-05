// Complete the countingValleys function below.
function countingValleys(steps, path) {

    // U => +1
    // D => -1
    // Loop through steps (adding or substracting)
    // If 0 => -1, 1 valley
    // O(n)

    let altitude = 0;
    let valleys = 0;
    for (let i = 0; i < steps; i++) {
        const stepWeight = path.charAt(i) === "U" ? 1 : -1;
        const isValley = altitude === 0 && stepWeight === -1;
        if (isValley) {
            valleys += 1;
        }

        altitude += stepWeight;
    }

    return valleys;
}

console.log(countingValleys(8, "UDDDUDUU"));
console.log(countingValleys(12, "DDUUDDUDUUUD"));