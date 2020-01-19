// Complete the migratoryBirds function below.
function migratoryBirds(arr) {
    const arrDict = {};
    let mostCommonBird = {
        id: 0,
        frequency: 0
    };
    arr.forEach(id => {
        const currentFrequency = arrDict[id] ? arrDict[id] : 0;
        arrDict[id] = currentFrequency + 1;

        if (mostCommonBird.frequency < currentFrequency) {
            mostCommonBird = {
                id: id,
                frequency: currentFrequency
            };
        }

        const isIdLowerThanMostCommon = id < mostCommonBird.id;
        if (
            mostCommonBird.frequency == currentFrequency &&
            isIdLowerThanMostCommon
        ) {
            mostCommonBird.id = id;
        }
    });

    return mostCommonBird.id;
}

console.log(migratoryBirds([1, 4, 4, 4, 5, 3]));
console.log(migratoryBirds([2, 2, 1, 3, 4, 1, 1, 4, 2]));
console.log(migratoryBirds([1, 1, 2, 3, 4, 2, 2, 4, 1]));
console.log(migratoryBirds([1, 2, 3, 4, 5, 4, 3, 2, 1, 3, 4]));
