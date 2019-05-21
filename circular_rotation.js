function circularArrayRotation(array, rotationCount, queries) {
    const rotatedArray = rotateArray(array, rotationCount)
    const queriesIndexes = queries.map(query => rotatedArray[query])
    return queriesIndexes
}

function rotateArray(array, rotationCount) {
    let rotations = rotationCount
    if (rotations >= array.length) {
        rotations = (rotationCount % array.length)
    }
    if (rotations == 0) {
        return array
    }
    const splitPosition = array.length - rotations
    const rotatedArrayFirstPart = array.slice(splitPosition)
    const rotatedArraySecondPart = array.slice(0, splitPosition)
    return rotatedArrayFirstPart.concat(rotatedArraySecondPart)
}