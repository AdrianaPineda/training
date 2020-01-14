// Complete the biggerIsGreater function below.
// https://www.hackerrank.com/challenges/bigger-is-greater/problem
// Big O
function biggerIsGreater(string) {
    for (let i = string.length - 2; i >= 0; i--) {
        const charCode = string.charCodeAt(i);
        let remainingChars = string.substring(i);
        let nextHighestCharIndex = getNextHighestCharIndex(charCode, remainingChars);

        if (nextHighestCharIndex >= 0) {
            const nextChar = remainingChars.charAt(nextHighestCharIndex);
            const secondHalfString = remainingChars.substring(0, nextHighestCharIndex) + remainingChars.substring(nextHighestCharIndex + 1);
            const orderedSecondHalfString = secondHalfString.split("").sort().join("");
            const finalString = string.substring(0, i) + nextChar + orderedSecondHalfString;
            return finalString;
        }
    }

    return "no answer";
}

function getNextHighestCharIndex(baseValue, string) {
    let nextHighest = Infinity;
    let nextHighestIndex = -1;
    for (let i = 0; i < string.length; i++) {
        const char = string[i]
        const charCode = char.charCodeAt(0);
        if (charCode > baseValue && charCode < nextHighest) {
            nextHighest = charCode;
            nextHighestIndex = i;
        }
    }

    return nextHighestIndex;
}

function reorderChars(startIndex, string) {
    let finalString = "";

    let nextHighestCharIndex = startIndex;
    while (nextHighestCharIndex >= 0) {
        const nextChar = string.charAt(nextHighestCharIndex);
        string = string.substring(0, nextHighestCharIndex) + string.substring(nextHighestCharIndex + 1);
        finalString = finalString + nextChar;
        nextHighestCharIndex = getNextHighestCharIndex(0, string);
    }

    return finalString;

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
