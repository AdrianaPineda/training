// https://leetcode.com/problems/subsets-ii/

/**
Given an integer array nums that may contain duplicates, return all possible subsets (the power set).

The solution set must not contain duplicate subsets. Return the solution in any order.
*/

/**
[2, 1, 2, 2] => [1, 2, 2, 2, 3]

 0  1  2  3  4
[1, 2, 2, 2, 3]

[1]
    [1, 2]
        [1, 2, 2]
            [1, 2, 2, 2]
                [1, 2, 2, 2, 3]
            [1, 2, 2, 3]
        [1, 2, 3]
    [1, 3]
[2]
    [2, 2]
        [2, 2, 2]
            [2, 2, 2, 3]
        [2, 2, 3]
    [2, 3]

[3]



[1, 2, 2]

[]
[1]
    [1, 2]
        [1, 2, 2]
[2]
    [2, 2]
*/

// Time complexity: O(n*2^n)
// Space complexity: O(n)
func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
    let orderedNums = nums.sorted() // O(n*log(n))
    var results = [[Int]]()
    subsetsRecursive(orderedNums, index: 0, currSet: [], result: &results)
    return results
}

func subsetsRecursive(_ nums: [Int], index: Int, currSet: [Int], result: inout [[Int]]) {
    result.append(currSet)

    var i = index
    var currNum: Int? = nil
    while i < nums.count {
        let num = nums[i]

        defer {
            i += 1
            currNum = num
        }

        if currNum != nil && currNum == num {
            continue
        }

        let nextSet = currSet + [num]
        subsetsRecursive(nums, index: i + 1, currSet: nextSet, result: &result)
    }
}

// Backtracking
func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
    let orderedNums = nums.sorted()
    var results = [[Int]]()
    var currSet = [Int]()
    subsetsRecursive(orderedNums, index: 0, currSet: &currSet, result: &results)
    return results
}

func subsetsRecursive(_ nums: [Int], index: Int, currSet: inout [Int], result: inout [[Int]]) {
    result.append(currSet)

    var i = index
    var currNum: Int? = nil
    while i < nums.count {
        let num = nums[i]

        defer {
            i += 1
            currNum = num
        }

        if currNum != nil && currNum == num {
            continue
        }

        currSet.append(num)
        subsetsRecursive(nums, index: i + 1, currSet: &currSet, result: &result)
        currSet.removeLast()
    }
}

print(subsetsWithDup([1, 2, 2])) // [[],[1],[1,2],[1,2,2],[2],[2,2]]
print(subsetsWithDup([1, 2, 3, 2, 2])) // [[], [1], [1, 2], [1, 2, 2], [1, 2, 2, 2], [1, 2, 2, 2, 3], [1, 2, 2, 3], [1, 2, 3], [1, 3], [2], [2, 2], [2, 2, 2], [2, 2, 2, 3], [2, 2, 3], [2, 3], [3]]
print(subsetsWithDup([0])) // [[], [0]]

