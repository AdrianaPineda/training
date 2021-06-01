// https://leetcode.com/explore/interview/card/facebook/53/recursion-3/278/
// Given an integer array nums of unique elements, return all possible subsets (the power set).
// The solution set must not contain duplicate subsets. Return the solution in any order.

/**
Example 1:
    Input: nums = [1,2,3]
    Output: [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]

Example 2:
    Input: nums = [0]
    Output: [[],[0]]

Example 3:
    Input: nums = []
    Output: [[]]
*/

/**
=> 1, 2, 3
results = [[1], [2], [3], [1, 2], [1, 3], [1, 2, 3], [2, 3]]

==> [1]           , [2, 3]
    [1, 2]        , [3]
    [1, 2, 3]
    [1, 3]

==> [2]             , [3]
    [2, 3]

==> [3]

=> 1, 2, 3, 4
results: [[], [1], [1, 2], [1, 2, 3], [1, 2, 3, 4], [1, 2, 4], [1, 3] , [1, 3, 4], [1, 4]  ]

currNums: []
remain: [1, 2, 3, 4]
    
    i: 0, num: 1

        currNums: [1]
        remain: [2, 3, 4]

            i: 0, num: 2

            currNums: [1, 2]
            remain: [3, 4]

                i: 0, num: 3

                    currNums: [1, 2, 3]
                    remain: [4]

                        i: 0, num: 4

                            currNums: [1, 2, 3, 4]
                            remain: []
                
                i: 1, num: 4

                    currNums: [1, 2, 4]
                    remain: []
            
            i: 1, num: 3

            currNums: [1, 3]
            remain: [4]
            ...

            i: 2, num: 4

            currNums: [1, 4]
            remain: []
            ...

==> [1]             , [2, 3, 4]
    [1, 2]          , [3, 4]
    [1, 2, 3]       , [4]
    [1, 2, 3, 4]    
    [1, 2, 4]

    [1, 3]          , [4]
    [1, 3, 4]

    [1, 4]

===> [2]            , [3, 4]
     [2, 3]         , [4]
     [2, 3, 4]


             1,         2,       3,          4
          /  |  \      /  \
        2    3   4     3   4      4
      /  \   |         |
     3   4   4         4
     |
     4           
*/



// Time complexity: O((2^n)*n)
// Space complexity: O(2^n * n + n)
func subsets(_ nums: [Int]) -> [[Int]] {
    let currNums: [Int] = []
    var results: [[Int]] = [currNums]
    subsetsRecursive(currNums, remain: nums, results: &results)
    return results
}

func subsetsRecursive(_ currNums: [Int], remain: [Int], results: inout [[Int]]) {
    if remain.isEmpty {
        return
    }

    for (i, num) in remain.enumerated() {
        var nextNums = currNums
        nextNums.append(num) // O(n)
        results.append(nextNums) // O(1)

        let nextRemain = remain[(i + 1)...]
        subsetsRecursive(nextNums, remain: Array(nextRemain), results: &results)
    }
}

print(subsets([1, 2, 3])) // [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
print(subsets([1, 2, 3, 4])) // [[], [1], [1, 2], [1, 2, 3], [1, 2, 3, 4], [1, 2, 4], [1, 3], [1, 3, 4], [1, 4], [2], [2, 3], [2, 3, 4], [2, 4], [3], [3, 4], [4]]
