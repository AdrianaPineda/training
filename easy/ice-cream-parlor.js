// Complete the icecreamParlor function below.
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
    for (const costAsString of costIndexesKeys) {
        const cost = parseInt(costAsString);
        if (cost > money) {
            continue;
        }

        const remainingMoney = money - cost;
        const canChooseSameCost = remainingMoney === cost && costIndexesDict[cost].length == 2;
        if (canChooseSameCost) {
            return costIndexesDict[cost].sort(((a, b) => a > b));
        }

        if (costIndexesDict[remainingMoney]) {
            return [...costIndexesDict[cost], ...costIndexesDict[remainingMoney]].sort(((a, b) => a > b));
        }
    }

    return [];
}

// console.log(icecreamParlor(4, [1, 4, 5, 3, 2]));
console.log(icecreamParlor(5, [1, 4, 5, 3, 2]));
console.log(icecreamParlor(4, [2, 2, 4, 3]));