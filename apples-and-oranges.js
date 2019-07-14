function countApplesAndOranges(s, t, a, b, apples, oranges) {
    const applesInRange = getFruitsInRange(apples, a, s, t)
    const orangesInRange = getFruitsInRange(oranges, b, s, t)

    console.log(applesInRange)
    console.log(orangesInRange)
}

function getFruitsInRange(fruitsDistances, treePosition, startPoint, endPoint) {
    return fruitsDistances.reduce((accumulator, fruitDistance) => {
        const fruitPosition = treePosition + fruitDistance
        return fruitPosition >= startPoint && fruitPosition <= endPoint
            ? accumulator + 1
            : accumulator
    }, 0)
}
