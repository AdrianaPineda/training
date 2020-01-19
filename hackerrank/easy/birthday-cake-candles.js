function birthdayCakeCandles(ar) {

    let currentMax = 0
    let counter =  0
    for (let element of ar) {
        if (element > currentMax) {
            currentMax = element
            counter = 1
        } else if (element == currentMax) {
            counter+=1
        }
    }

    return counter

}

const result = birthdayCakeCandles([3, 2, 1, 3])
console.log(result)