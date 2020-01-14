// Complete the biggerIsGreater function below.
// https://www.hackerrank.com/challenges/bigger-is-greater/problem
// Big O
function biggerIsGreater(string) {
    let finalString = "";
    for (let i = string.length - 2; i >= 0; i--) {
        const char = string.charAt(i);
        const charCode = char.charCodeAt(0);
        let remainingChars = string.substring(i);
        let nextHighestCharIndex = getNextHighestCharIndex(charCode, remainingChars);

        if (nextHighestCharIndex >= 0) {
            const secondhalfString = reorderChars(nextHighestCharIndex, remainingChars);
            finalString = string.substring(0, i) + secondhalfString;
            break;
        }
    }

    return finalString ? finalString : "no answer";
}

function getNextHighestCharIndex(baseValue, string) {
    let currentHighest = Infinity;
    let highestCharIndex = -1;
    for (let char of string) {
        const charCode = char.charCodeAt(0);
        if (charCode > baseValue && charCode < currentHighest) {
            currentHighest = charCode;
            highestCharIndex = string.indexOf(char);
        }
    }

    return highestCharIndex;
}

function reorderChars(nextHighestCharIndex, remainingChars) {
    let finalString = "";

    while (nextHighestCharIndex >= 0) {
        const nextChar = remainingChars.charAt(nextHighestCharIndex);
        remainingChars = remainingChars.substring(0, nextHighestCharIndex) + remainingChars.substring(nextHighestCharIndex + 1);
        finalString = finalString + nextChar;
        nextHighestCharIndex = getNextHighestCharIndex(0, remainingChars);
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
