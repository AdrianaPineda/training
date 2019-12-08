// Complete the icecreamParlor function below.
// https://www.hackerrank.com/challenges/icecream-parlor/problem
function icecreamParlor(money, iceCreamCosts) {
    const costIndexesDict = getIceCreamCostIndexes(iceCreamCosts);
    const selectedIndexes = getSelectedIceCreamsIndexes(money, costIndexesDict)
    return selectedIndexes;
}

function getIceCreamCostIndexes(iceCreamCosts) {
    const costIndexesDict = {};
    for (let i = 0; i < iceCreamCosts.length; i++) {
        const iceCreamCost = iceCreamCosts[i];
        const indexes = costIndexesDict[iceCreamCost] ? costIndexesDict[iceCreamCost] : [];
        const oneIndex = i + 1;
        indexes.push(oneIndex)
        costIndexesDict[iceCreamCost] = indexes;
    }
    return costIndexesDict;
}

function getSelectedIceCreamsIndexes(money, costIndexesDict) {
    const costIndexesKeys = Object.keys(costIndexesDict);
    let chosenIndexes = [];
    for (let i = 0; i < costIndexesKeys.length && chosenIndexes.length <= 0; i++) {
        const iceCreamCost = parseInt(costIndexesKeys[i]);
        if (iceCreamCost >= money) {
            continue;
        }

        const remainingMoney = money - iceCreamCost;
        chosenIndexes = getPossibleIceCreamIndexes(iceCreamCost, remainingMoney, costIndexesDict);
    }

    // Not using sort due to time complexity
    if (chosenIndexes[0] > chosenIndexes[1]) {
        return [chosenIndexes[1], chosenIndexes[0]];
    }

    return chosenIndexes;
}

function getPossibleIceCreamIndexes(iceCreamCost, remainingMoney, costIndexesDict) {
    const areTwoIceCreamsOfSameCost = costIndexesDict[iceCreamCost].length == 2;
    const canChooseSameCost = remainingMoney === iceCreamCost && areTwoIceCreamsOfSameCost;
    if (canChooseSameCost) {
        return costIndexesDict[iceCreamCost];
    }

    if (costIndexesDict[remainingMoney]) {
        // Exercise guarantees there is a unique solution
        // Hence the following array will be always of length 2
        return [...costIndexesDict[remainingMoney], ...costIndexesDict[iceCreamCost]];
    }

    return [];
}

console.log(icecreamParlor(4, [4, 3, 5, 1, 2]));
console.log(icecreamParlor(5, [1, 4, 5, 3, 2]));
console.log(icecreamParlor(4, [2, 2, 4, 3]));