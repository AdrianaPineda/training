// https://leetcode.com/explore/interview/card/facebook/53/recursion-3/293/
// Given a collection of numbers, nums, that might contain duplicates, return all possible unique permutations in any order.

/**
Example 1:
    Input: nums = [1,1,2]
    Output:
    [[1,1,2],
    [1,2,1],
    [2,1,1]]

Example 2:
    Input: nums = [1,2,3]
    Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]


 0  1  2
[1, 2, 3]

    1 [2, 3]
        2 => [3]  1, 2 3
        3 => [2]  1, 3, 2
    
    2 [1, 3]
        1 => [3]  2, 1, 3
        3 => [1]  2  3  1

    3 => [1, 2]
        1 => [2]  3 1 2
        2 => [1]  3 2 1

[1, 1, 2]

    1 => [1, 2]
        1 => [2]  1, 1, 2
        2 => [1]  1, 2, 1
    
    1 => [1, 2] /
    
    2 => [1, 1]
        1 => [1] 2 1 1


    1           2         3                 n
  2   3       1    3    1    2              n-1
 3    2       3    1    2    1              n-2 .... 1
*/



// Time complexity: O(n!*n^2)
// Space complexity: O(n^2) without taking into account the results. O(n!) for results
func permuteUnique(_ nums: [Int]) -> [[Int]] {
    var result = Set<[Int]>()
    permuteUniqueRecursive([], nums, &result)
    return Array(result)
}

func permuteUniqueRecursive(_ permutations: [Int], _ remainingNums: [Int], _ result: inout Set<[Int]>) {
    if remainingNums.count == 0 {
        result.insert(permutations) // O(n)
        return
    }

    for (i, num) in remainingNums.enumerated() {
        let currPermutations = permutations + [num]
        let nextRemainingNums = remainingNums[0..<i] + remainingNums[(i + 1)...]
        permuteUniqueRecursive(currPermutations, Array(nextRemainingNums), &result)
    }
}

// Sorting
// Time complexity: O(n!*n^2)
// Space complexity: O(n^2) without taking into account the results.
func permuteUnique(_ nums: [Int]) -> [[Int]] {
    let sortedNums = nums.sorted() // O(n*log(n))
    var result = [[Int]]()
    permuteUniqueRecursive([], sortedNums, &result)
    return result
}

func permuteUniqueRecursive(_ permutations: [Int], _ remainingNums: [Int], _ result: inout [[Int]]) {
    if remainingNums.count == 0 {
        result.append(permutations) // O(1)
        return
    }

    var prevNum = -11
    for (i, num) in remainingNums.enumerated() {
        let currPermutations = permutations + [num]
        let nextRemainingNums = remainingNums[0..<i] + remainingNums[(i + 1)...]

        if num != prevNum {
            permuteUniqueRecursive(currPermutations, Array(nextRemainingNums), &result)
        }

        prevNum = num
    }
}

print(permuteUnique([1,1,2])) // [[1,1,2], [1,2,1], [2,1,1]]
print(permuteUnique([1,2,3])) // [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
