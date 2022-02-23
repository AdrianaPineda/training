// https://leetcode.com/problems/search-in-rotated-sorted-array/

/**
There is an integer array nums sorted in ascending order (with distinct values).
Prior to being passed to your function, nums is rotated at an unknown pivot 
index k (0 <= k < nums.length) such that the resulting array is [nums[k], 
nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). 

For example, [0,1,2,4,5,6,7] might be rotated at pivot index 3 and become [4,5,6,7,0,1,2].

Given the array nums after the rotation and an integer target, return the 
index of target if it is in nums, or -1 if it is not in nums.

You must write an algorithm with O(log n) runtime complexity.

Example 1:
    Input: nums = [4,5,6,7,0,1,2], target = 0
    Output: 4

Example 2:
    Input: nums = [4,5,6,7,0,1,2], target = 3
    Output: -1

Example 3:
    Input: nums = [1], target = 0
    Output: -1

*/
// Time complexity: O(log(n))
// Space complexity: O(1)
func search(_ nums: [Int], _ target: Int) -> Int {
    var startIndex = 0
    var endIndex = nums.count - 1

    while startIndex <= endIndex {
        let midPointIndex = (startIndex + endIndex) / 2
        let start = nums[startIndex]
        let end = nums[endIndex]
        let midPoint = nums[midPointIndex]

        if midPoint == target {
            return midPointIndex
        }

        if start <= midPoint {
            if start <= target && target < midPoint {
                endIndex = midPointIndex - 1
            } else {
                startIndex = midPointIndex + 1
            }
            continue
        }

        if midPoint <= end {
            if midPoint < target && target <= end {
                startIndex = midPointIndex + 1
            } else {
                endIndex = midPointIndex - 1
            }
        }
    }

    return -1
}

// Alt - recursive
// Time complexity: O(log(n))
// Space complexity: O(log(n))
func search(_ nums: [Int], _ target: Int) -> Int {
    return searchRecursive(nums, target, startIndex: 0, endIndex: nums.count - 1)
}

func searchRecursive(_ nums: [Int], _ target: Int, startIndex: Int, endIndex: Int) -> Int {
    if startIndex > endIndex { return -1 }

    let midPointIndex = (startIndex + endIndex) / 2
    let start = nums[startIndex]
    let end = nums[endIndex]
    let midPoint = nums[midPointIndex]

    if midPoint == target {
        return midPointIndex
    }

    var updatedStartIndex = startIndex
    var updatedEndIndex = endIndex
    if start <= midPoint {
        if start <= target && target < midPoint {
            updatedEndIndex = midPointIndex - 1
        } else {
            updatedStartIndex = midPointIndex + 1
        }
    }

    if midPoint <= end {
        if midPoint < target && target <= end {
            updatedStartIndex = midPointIndex + 1
        } else {
            updatedEndIndex = midPointIndex - 1
        }
    }

    return searchRecursive(nums, target, startIndex: updatedStartIndex, endIndex: updatedEndIndex)
}

print(search([7,8,9,0,1,2,4,5,6], 8)) // 1
print(search([7,8,9,0,1,2,4,5,6], 2)) // 5
print(search([4,5,6,7,0,1,2], 0)) // 4
print(search([4,5,6,7,0,1,2], 3)) // -1
print(search([1], 0)) // -1
