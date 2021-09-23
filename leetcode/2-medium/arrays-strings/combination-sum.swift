/**
https://leetcode.com/problems/combination-sum/

Given an array of distinct integers candidates and a target integer target,
return a list of all unique combinations of candidates where the chosen numbers
sum to target. You may return the combinations in any order.

The same number may be chosen from candidates an unlimited number of times.
Two combinations are unique if the frequency of at least one of the chosen numbers is different.

It is guaranteed that the number of unique combinations that sum up to target
is less than 150 combinations for the given input.
*/

// Time complexity: O(n^(target/min(candidate_i))*(target/min(candidate_i))
// Space complexity: O(target/min(candidate_i))
func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    let sortedCandidates = candidates.sorted()
    var result = [[Int]]()
    combinationSum(sortedCandidates, 0, target, [Int](), &result)
    return result
}

func combinationSum(_ candidates: [Int], _ index: Int, _ target: Int, _ curr: [Int], _ result: inout [[Int]]) {
    if target == 0 {
        result.append(curr)
        return
    }

    for i in index..<candidates.count {
        let num =  candidates[i]
        let nextTarget = target - num
        if nextTarget < 0 { break }
        combinationSum(candidates, i, nextTarget, curr + [num], &result)
    }
}

// Backtracking
func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    let sortedCandidates = candidates.sorted()
    var result = [[Int]]()
    var current = [Int]()
    combinationSum(sortedCandidates, 0, target, &current, &result)
    return result
}

func combinationSum(_ candidates: [Int], _ index: Int, _ target: Int, _ curr: inout [Int], _ result: inout [[Int]]) {
    if target == 0 {
        result.append(curr)
        return
    }

    for i in index..<candidates.count {
        let num =  candidates[i]
        let nextTarget = target - num
        if nextTarget < 0 { break }
        curr.append(num)
        combinationSum(candidates, i, nextTarget, &curr, &result)
        curr.removeLast()
    }
}

print(combinationSum([2, 3, 6, 7], 7)) // [[2,2,3],[7]]
print(combinationSum([2, 3, 5], 8)) // [[2,2,2,2],[2,3,3],[3,5]]
print(combinationSum([2], 1)) // []
print(combinationSum([1], 1)) // [[1]]
