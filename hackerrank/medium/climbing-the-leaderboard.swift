// https://www.hackerrank.com/challenges/climbing-the-leaderboard/problem

/**
            1   1   2    3   3   4   5
ranked = [100, 100, 50, 40, 40, 20, 10]
                                    ^ 

player = [5, 25, 50, 120]
          ^


currRanking = 1 -> 2 -> 3 -> 4 -> 5
results = [1, 2, 4, 6]


            1   2   2   3   4   5
ranked = [100, 90, 90, 80, 75, 60]
                               ^ 

player = [50, 65, 77, 90, 102]
          ^


currRanking = 1 -> 2 -> 3 -> 4 -> 5
results = [1, 2, 4, 5, 6]
*/
// Time complexity: O(n+m)
// Space complexity: O(1)
func climbingLeaderboard(ranked: [Int], player: [Int]) -> [Int] {
    var playerIndex = player.count - 1
    var rankedIndex = 0
    var previousRank = ranked[0]
    var currRanking = 1
    var results = [Int]()

    while playerIndex >= 0 {
        let currPlayer = player[playerIndex]

        while rankedIndex < ranked.count {
            let currRank = ranked[rankedIndex]

            guard currRank >= currPlayer else { break }

            if currRank != previousRank {
                currRanking += 1
            }

            previousRank = currRank
            rankedIndex += 1
        }

        if previousRank > currPlayer {
            results.append(currRanking + 1)
        } else {
            results.append(currRanking)
        }

        playerIndex -= 1

    }

    return results.reversed()
}
// Alt
func climbingLeaderboard(ranked: [Int], player: [Int]) -> [Int] {
    var playerIndex = player.count - 1
    var rankedIndex = 0
    var previousRank = -1
    var currRanking = 1
    var results = [Int]()

    while playerIndex >= 0 {
        let currPlayer = player[playerIndex]

        while rankedIndex < ranked.count {
            let currRank = ranked[rankedIndex]

            if previousRank == currRank {
                rankedIndex += 1
                continue
            }

            guard currRank > currPlayer else { break }

            currRanking += 1
            rankedIndex += 1
            previousRank = currRank
        }

        results.append(currRanking)

        playerIndex -= 1

    }

    return results.reversed()
}


// Alt
// Time complexity: O(n+m)
// Space complexity: O(n)
func climbingLeaderboard(ranked: [Int], player: [Int]) -> [Int] {
    var playerIndex = player.count - 1
    var rankedIndex = 0
    let rankedNoDups = removeDups(nums: ranked)
    var results = [Int]()

    while playerIndex >= 0 {
        let currPlayer = player[playerIndex]

        while rankedIndex < rankedNoDups.count {
            let currRank = rankedNoDups[rankedIndex]

            guard currRank > currPlayer else { break }

            rankedIndex += 1
        }

        results.append(rankedIndex + 1)
        playerIndex -= 1

    }

    return results.reversed()
}

func removeDups(nums: [Int]) -> [Int] {
    var prevNum = -1
    var results = [Int]()
    for num in nums {
        if num == prevNum { continue }
        results.append(num)
        prevNum = num
    }

    return results
}

print(climbingLeaderboard(ranked: [200, 100, 100, 100, 100], player: [9, 9, 9, 8])) // [3, 3, 3, 3]
print(climbingLeaderboard(ranked: [100, 100, 50, 40, 40, 20, 10], player: [5, 25, 50, 120])) // [6, 4, 2, 1]
print(climbingLeaderboard(ranked: [100, 90, 90, 80, 75, 60], player: [50, 65, 77, 90, 102])) // [6, 5, 4, 2, 1]