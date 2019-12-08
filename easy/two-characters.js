// Complete the alternate function below.
//https://www.hackerrank.com/challenges/two-characters/problem
function alternate(string) {
    const chars = string.split("");
    let largestSequence = 0;
    const uniqueCharsArray = getUniqueCharsArray(chars);
    for (let i = 0; i < uniqueCharsArray.length - 1; i++) {
        const char = uniqueCharsArray[i];
        for (let j = i + 1; j < uniqueCharsArray.length; j++) {
            const secondChar = uniqueCharsArray[j];
            const sequence = buildLongestSequenceWithChars(
                char,
                secondChar,
                chars
            );
            if (sequence.length > largestSequence) {
                largestSequence = sequence.length;
            }
        }
    }

    return largestSequence;
}

function getUniqueCharsArray(chars) {
    const charsSet = new Set(chars);
    return Array.from(charsSet);
}

function buildLongestSequenceWithChars(char1, char2, originalChars) {
    const charSequence = [];
    originalChars.forEach(currentChar => {
        if (currentChar === char1 || currentChar === char2) {
            charSequence.push(currentChar);
        }
    });

    const valid = isValidCharSequence(charSequence);
    return valid ? charSequence : [];
}

function isValidCharSequence(charSequence) {
    let isValidString = true;
    for (let i = 1; i < charSequence.length; i++) {
        const currentElement = charSequence[i];
        if (currentElement === charSequence[i - 1]) {
            isValidString = false;
        }
    }

    return isValidString;
}

console.log(alternate("abaacdabd"));
// console.log(alternate("beabeefeab"));
