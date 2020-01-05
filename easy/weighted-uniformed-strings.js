
// Complete the weightedUniformStrings function below.
// https://www.hackerrank.com/challenges/weighted-uniform-string/problem

// Solution:
// loop through s
// find contiguous s
// charCodeAt(char)
// add to set
// loop through queries
// set.has(x(i))? 'True' : 'False'

// O(n) + O(m)
function weightedUniformStrings(string, queries) {
    let results = []
    const weights = getUniformSubstringWeights(string);
    for (let query of queries) {
        const result = weights.has(query) ? "Yes" : "No";
        results.push(result)
    }

    return results;
}

function getUniformSubstringWeights(string) {
    const chars = string.split("");
    const weights = new Set();
    let previousChar = "";
    let contiguousChars = 1;
    for (let i = 0; i < chars.length; i++) {
        const currentChar = chars[i];
        const charWeight = currentChar.charCodeAt(0) - 96;
        weights.add(charWeight);
        if (i > 0 && currentChar === previousChar) {
            contiguousChars = contiguousChars + 1;
            weights.add(charWeight * contiguousChars);
        } else {
            contiguousChars = 1
        }
        previousChar = currentChar
    }

    return weights;
}

console.log(weightedUniformStrings("abccddde", [1, 3, 12, 5, 9, 10]));

