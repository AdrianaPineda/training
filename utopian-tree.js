function utopianTree(n) {
    let previousHeight = 0
    let height = 0

    for (let i = 0; i < n + 1; i++) {
        height = i % 2 === 0 ? previousHeight + 1 : previousHeight * 2
        previousHeight = height
    }

    return height
}

function utopianTreeWithArray(n) {
    let heights = [0]

    n.forEach(iteration => {
        console.log(iteration)
        if (heights.length < iteration) {
            const index = heights.length > 0 ? heights.length - 1 : 0
            let height = heights[index]
            for (let i = index; i < iteration + 1; i++) {
                height = i % 2 === 0 ? height + 1 : height * 2
                heights.push(height)
            }
        }
    })

    return n.map(iteration => heights[iteration + 1]);
}

// console.log(utopianTreeWithArray([0, 1, 4]))
console.log(utopianTree(0))
console.log(utopianTree(1))
console.log(utopianTree(4))