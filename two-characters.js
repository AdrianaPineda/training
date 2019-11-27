// Complete the alternate function below.
function alternate(s) {
    const stringAsArray = s.split("");
    const dict = buildDict(stringAsArray);
    let largestString = 0;
    Object.keys(dict).forEach(key => {
        Object.keys(dict).forEach(secondKey => {
            if (key === secondKey) {
                return;
            }
            const result = buildLongest(key, secondKey, stringAsArray);
            if (result.length > largestString) {
                largestString = result.length;
            }
        });
    });

    return largestString;
}

function buildDict(s) {
    const dict = {};
    s.forEach((element, index) => {
        const ocurrences = dict[element] ? dict[element] : [];
        ocurrences.push(index);
        dict[element] = ocurrences;
    });
    console.log(dict);
    return dict;
}

function buildLongest(key1, key2, originalStringArray) {
    const result = [];
    originalStringArray.forEach(currentKey => {
        if (currentKey === key1 || currentKey === key2) {
            result.push(currentKey);
        }
    });

    const valid = isValidString(result);
    return valid ? result : [];
}

function isValidString(resultingOcurrences) {
    let isValidString = true;
    for (let i = 0; i < resultingOcurrences.length; i++) {
        const currentElement = resultingOcurrences[i];
        if (i > 0) {
            if (currentElement === resultingOcurrences[i - 1]) {
                isValidString = false;
            }
        }
    }

    return isValidString;
}

console.log(alternate("abaacdabd"));
// console.log(alternate("beabeefeab"));
