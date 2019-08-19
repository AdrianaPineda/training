function breakingRecords(scores) {

    if (scores.length <= 0) {
        return [0, 0]
    }

    let highestScore = scores[0];
    let countHighestScore = 0;
    let lowestScore = scores[0];
    let countLowestScore = 0;

    scores.forEach(element => {
        if (element > highestScore) {
            highestScore = element;
            countHighestScore++;
        }

        if (element < lowestScore) {
            lowestScore = element;
            countLowestScore++;
        }
    })

    return [countHighestScore, countLowestScore]

}

console.log(breakingRecords([10, 5, 20, 20, 4, 5, 2, 25, 1]))