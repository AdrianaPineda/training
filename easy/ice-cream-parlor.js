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
    for (const costAsString of costIndexesKeys) {
        const iceCreamCost = parseInt(costAsString);
        if (iceCreamCost >= money) {
            continue;
        }

        const remainingMoney = money - iceCreamCost;

        const areTwoIceCreamsOfSameCost = costIndexesDict[iceCreamCost].length == 2;
        const canChooseSameCost = remainingMoney === iceCreamCost && areTwoIceCreamsOfSameCost;
        if (canChooseSameCost) {
            chosenIndexes = costIndexesDict[iceCreamCost];
            break;
        }

        if (costIndexesDict[remainingMoney]) {
            chosenIndexes = [...costIndexesDict[iceCreamCost], ...costIndexesDict[remainingMoney]];
            break;
        }
    }

    return chosenIndexes.sort(((a, b) => a > b));
}

console.log(icecreamParlor(4, [4, 3, 5, 1, 2]));
console.log(icecreamParlor(5, [1, 4, 5, 3, 2]));
console.log(icecreamParlor(4, [2, 2, 4, 3]));