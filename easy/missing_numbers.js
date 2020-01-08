// Complete the missingNumbers function below.
// https://www.hackerrank.com/challenges/missing-numbers/problem
// Big O
// Time complexity: O(n) + O(m) + O(nlog(n)) => O(nlog(n))
// Spacial complexity: O(n) + O(n) + O(m) + O(m) + O(log(n)) => O(n)
function missingNumbers(misingNumbersArray, originalArray) {

    // Loop through array of missing numbers to get ocurrences
    const incompleteArrOcurrences = getNumberOcurrences(misingNumbersArray);

    // Loop through original array to find numbers missing from the first array
    const missingNumbers = findMissingNumbers(incompleteArrOcurrences, originalArray);
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

function findMissingNumbers(incompleteArrOcurrences, originalArray) {
    const incompleteArrOcurrencesCopy = { ...incompleteArrOcurrences };
    const missingNumbers = new Set();
    for (let number of originalArray) {
        const ocurrences = incompleteArrOcurrencesCopy[number];
        // If dictionary doesn't have the number or if the number occurs more times in the original array
        // then we add that number as a missing number
        const isNumberMissing = !ocurrences || ocurrences <= 0;
        if (isNumberMissing) {
            missingNumbers.add(number)
        }

        if (ocurrences) {
            // Decrease occurrences in dictionary
            incompleteArrOcurrencesCopy[number] = ocurrences - 1;
        }
    }

    return Array.from(missingNumbers);
}

console.log(missingNumbers([203, 204, 205, 206, 207, 208, 203, 204, 205, 206], [203, 204, 204, 205, 206, 207, 205, 208, 203, 206, 205, 206, 204]));
console.log(missingNumbers([11, 4, 11, 7, 13, 4, 12, 11, 10, 14], [11, 4, 11, 7, 3, 7, 10, 13, 4, 8, 12, 11, 10, 14, 12]));
