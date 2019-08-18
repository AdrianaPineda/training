function permutationEquation(p) {
    // find any integer y such that p(p(y)) === x
    const valToIndexDict = getValueToIndexDictionary(p);
    const permutations = []
    for (let i = 1; i <= p.length; i++) {
        const py = valToIndexDict[i]
        const ppy = valToIndexDict[py]
        permutations.push(ppy)
    }

    return permutations
}

function getValueToIndexDictionary(p) {
    const valToIndexDict = {};
    p.forEach((value, index) => valToIndexDict[value] = (index + 1))
    return valToIndexDict
}

console.log(permutationEquation([2, 3, 1]))