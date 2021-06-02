// https://leetcode.com/explore/interview/card/facebook/54/sorting-and-searching-3/3030/
// Given an array of integers nums sorted in ascending order, find the starting and ending position of a given target value.
// If target is not found in the array, return [-1, -1].
// You must write an algorithm with O(log n) runtime complexity.

/**
Example 1:
    Input: nums = [5,7,7,8,8,10], target = 8
    Output: [3,4]

Example 2:
    Input: nums = [5,7,7,8,8,10], target = 6
    Output: [-1,-1]

Example 3:
    Input: nums = [], target = 0
    Output: [-1,-1]

===
        0 1 2 3 4 5 
nums = [5,7,7,8,8,10]
target = 8
range = [3, 4]

startIndex = 0
endIndex = 5
midPoint = 2
numAtMid = 7

startIndex = 3
endIndex = 5
midPoint = (5 - 3) /2 + 3 = 4
numAtMid = 8

startIndex = 3
endIndex = 3
midPoint = 3
numAtMid = 8

startIndex = 3
endIndex = 2

startIndex = 4
endIndex = 3

startIndex = 5
endIndex = 5
midPoint = 5
numAtMid = 10

startIndex = 5
endIndex = 4

startIndex = 6
endIndex = 5
*/

// Time complexity: O(log(n))
// Space complexity: O(log(n))
func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    var range = [-1, -1]
    searchRangeRecursive(nums, 0, (nums.count - 1), target, &range)
    return range
}

func searchRangeRecursive(_ nums: [Int], _ startIndex: Int, _ endIndex: Int, _ target: Int, _ range: inout [Int]) {
    if startIndex > endIndex {
        return
    }

    let midPoint = (endIndex - startIndex) / 2 + startIndex
    let numAtMid = nums[midPoint]
    if numAtMid == target {
        let startRange = range[0] != -1 ? min(range[0], midPoint) : midPoint
        let endRange = max(range[1], midPoint)
        range = [startRange, endRange]
    }

    if numAtMid >= target {
        searchRangeRecursive(nums, startIndex, midPoint - 1, target, &range)
    }

    if numAtMid <= target {
        searchRangeRecursive(nums, midPoint + 1, endIndex, target, &range)
    }
}

print(searchRange([5,7,7,8,8,10], 8)) // [3, 4]
print(searchRange([5,7,7,8,8,10], 6)) // [-1, -1]
print(searchRange([], 0)) // [-1, -1]