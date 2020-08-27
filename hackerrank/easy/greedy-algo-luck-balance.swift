//
// Problem: https://www.hackerrank.com/challenges/luck-balance/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=greedy-algorithms
// Big O:
// Time complexity: O(n log n)
// Space complexity: O(n)

// Complete the luckBalance function below.
func luckBalance(k: Int, contests: [[Int]]) -> Int {

    let (nonImportantContests, importantContests) = getContestsByImportance(contests: contests)
    let nonImportantLuck = nonImportantContests.reduce(0) { x, y in x + y }
    let importantLuck = getImportantContestsLuck(k: k, importantContests: importantContests)

    return nonImportantLuck + importantLuck

}

func getContestsByImportance(contests: [[Int]]) -> ([Int], [Int]) {
    var importantContests = [Int]()
    var nonImportantContests = [Int]()
    for contest in contests {
        let luck = contest[0]
        let importance = contest[1]
        if importance == 1 {
            importantContests.append(luck)
        } else {
            nonImportantContests.append(luck)
        }
    }

    return (nonImportantContests, importantContests)
}

func getImportantContestsLuck(k: Int, importantContests: [Int]) -> Int {
    let sortedImportantContests = importantContests.sorted(by: >) // sort important contests descending
    var importantLuck = 0
    for (i, luck) in sortedImportantContests.enumerated() {
        if i < k {
            importantLuck += luck
        } else {
            importantLuck -= luck
        }
    }

    return importantLuck
}

print(luckBalance(k: 1, contests: [[5, 1], [1, 1], [4, 0]])) // 8
print(luckBalance(k: 2, contests: [[5, 1], [1, 1], [4, 0]])) // 10
print(luckBalance(k: 3, contests: [[5, 1], [2, 1], [1, 1], [8, 1], [10, 0], [5, 0]])) // 29

