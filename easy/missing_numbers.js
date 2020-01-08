// Complete the missingNumbers function below.
// https://www.hackerrank.com/challenges/missing-numbers/problem
// Big O
// Time complexity: O(n) + O(m) => O(n)
// Spacial complexity: O(n) + O(n) + O(m) + O(m) => O(n)
function missingNumbers(misingNumbersArray, originalArray) {

    // Loop through array of missing numbers to get ocurrences
    const numberOcurrences = getNumberOcurrences(misingNumbersArray);

    // Loop through original array
    const missingNumbers = findMissingNumbers(numberOcurrences, originalArray);
    return missingNumbers.sort((a, b) => a - b);

}

function getNumberOcurrences(array) {
    const numberOcurrences = {};
    for (let number of array) {
        const ocurrences = numberOcurrences[number] ? numberOcurrences[number] : 0;
        numberOcurrences[number] = ocurrences + 1;
    }

    return numberOcurrences;
}

function findMissingNumbers(numberOcurrences, originalArray) {
    const numberOcurrencesCopy = { ...numberOcurrences };
    const missingNumbers = new Set();
    for (let number of originalArray) {
        const ocurrences = numberOcurrencesCopy[number];
        if (!ocurrences || (ocurrences - 1) < 0) {
            missingNumbers.add(number)
        }
        numberOcurrencesCopy[number] = ocurrences - 1;
    }

    return Array.from(missingNumbers);
}

console.log(missingNumbers([203, 204, 205, 206, 207, 208, 203, 204, 205, 206], [203, 204, 204, 205, 206, 207, 205, 208, 203, 206, 205, 206, 204]));
console.log(missingNumbers([11, 4, 11, 7, 13, 4, 12, 11, 10, 14], [11, 4, 11, 7, 3, 7, 10, 13, 4, 8, 12, 11, 10, 14, 12]));
