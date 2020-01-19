// Complete the biggerIsGreater function below.
// https://www.hackerrank.com/challenges/bigger-is-greater/problem
// Big O
// Time complexity: O(n^3)? + O(O(n) + O(n)? + n*log(n)) => O(n^3)
// Spacial complexity: O(n) + O(n*n)
function biggerIsGreater(string) {
    for (let i = string.length - 2; i >= 0; i--) {
        const char = string[i];
        const charCode = char.charCodeAt(0);
        const remainingString = string.substring(i);

        const nextBiggestString = findNextBiggestString(charCode, remainingString);
        if (nextBiggestString) {
            const finalString = string.substring(0, i) + nextBiggestString;
            return finalString;
        }
    }

    return "no answer";
}

function findNextBiggestString(baseCharCode, string) {
    const nextHighestCharIndex = getNextHighestCharIndex(baseCharCode, string);
    if (nextHighestCharIndex >= 0) {
        return getNextBiggestString(string, nextHighestCharIndex);
    }

    return undefined;
}

function getNextHighestCharIndex(baseCharCode, string) {
    let nextHighest = Infinity;
    let nextHighestIndex = -1;
    for (let i = 0; i < string.length; i++) {
        const char = string[i]
        const charCode = char.charCodeAt(0);
        const isNextHighest = charCode > baseCharCode && charCode < nextHighest;
        if (isNextHighest) {
            nextHighest = charCode;
            nextHighestIndex = i;
        }
    }

    return nextHighestIndex;
}

function getNextBiggestString(string, firstCharIndex) {
    const firstChar = string.charAt(firstCharIndex);
    const remainingString = removeChar(string, firstCharIndex);
    const orderedString = orderAlphabetical(remainingString);
    return firstChar + orderedString;
}

function removeChar(string, charIndex) {
    return string.substring(0, charIndex) + string.substring(charIndex + 1);
}

function orderAlphabetical(string) {
    return string.split("").sort().join("");
}


console.log("ab => ba =>", biggerIsGreater("ab"));
console.log("bb => no answer =>", biggerIsGreater("bb"));
console.log("hefg => hegf =>", biggerIsGreater("hefg"));
console.log("dhck => dhkc =>", biggerIsGreater("dhck"));
console.log("dkhc => hcdk =>", biggerIsGreater("dkhc"));
console.log("abdc => acbd =>", biggerIsGreater("abdc"));
console.log("lmno => lmon => ", biggerIsGreater("lmno"));
console.log("dcba => no answer => ", biggerIsGreater("dcba"));
console.log("dcbb => no answer => ", biggerIsGreater("dcbb"));
console.log("abdc => acbd => ", biggerIsGreater("abdc"));
console.log("abcd => abdc => ", biggerIsGreater("abcd"));
console.log("fedcbabcd => fedcbabdc => ", biggerIsGreater("fedcbabcd"));
