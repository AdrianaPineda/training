// Complete the alternate function below.
function alternate(s) {
    const dict = buildDict(s);
    let largestString = 0;
    Object.keys(dict).forEach(key => {
        const ocurrences = dict[key];
        console.log("1. ====", key, ocurrences);
        const result = Object.keys(dict).reduce((acc, currentKey) => {
            if (currentKey === key) {
                return acc;
            }

            const currentOccurrences = dict[currentKey];
            console.log("2a. ====", currentKey, currentOccurrences);
            const resultingOcurrences = [];
            currentOccurrences.forEach(occurrence => {
                console.log("2b. ====", occurrence);
                let changedIndexes = 0;
                ocurrences.forEach(occ => {
                    if (occ < occurrence) {
                        changedIndexes++;
                    }
                });
                resultingOcurrences.push(occurrence - changedIndexes);
            });

            console.log("2c. ====", resultingOcurrences);

            let isValidString = true;
            for (let i = 0; i < resultingOcurrences.length; i++) {
                const currentElement = resultingOcurrences[i];
                if (i > 0) {
                    if (currentElement - resultingOcurrences[i - 1] === 1) {
                        isValidString = false;
                    }
                }
            }

            console.log("===== valid", isValidString);
            if (isValidString) {
                acc += currentOccurrences.length;
                return acc;
            }

            return 0;
        }, 0);

        if (result > largestString) {
            largestString = result;
        }

        console.log("largest ====", largestString);
    });

    return largestString;
}

function buildDict(s) {
    const dict = {};
    s.split("").forEach((element, index) => {
        const ocurrences = dict[element] ? dict[element] : [];
        ocurrences.push(index);
        dict[element] = ocurrences;
    });
    console.log(dict);
    return dict;
}

// console.log(alternate("abaacdabd"));
console.log(alternate("beabeefeab"));
