// https://leetcode.com/explore/interview/card/facebook/54/sorting-and-searching-3/3032/
// A peak element is an element that is strictly greater than its neighbors.
// Given an integer array nums, find a peak element, and return its index. If the array
// contains multiple peaks, return the index to any of the peaks.
// You may imagine that nums[-1] = nums[n] = -∞.
// You must write an algorithm that runs in O(log n) time.

/**
Example 1:
    Input: nums = [1,2,3,1]
    Output: 2
    Explanation: 3 is a peak element and your function should return the index number 2.

Example 2:
    Input: nums = [1,2,1,3,5,6,4]
    Output: 5
    Explanation: Your function can return either index number 1 where the peak element is 2, or index number 5 where the peak element is 6.

 index  0 1 2 3 4 5 6
 array [1,2,1,3,5,6,4] => 7

start = 0
end = array.count - 1 = 6
mid = (start + end) / 2 = 3
num = 3
left = 1
right = 5

    left half
        start = 0
        end = mid - 1 = 2
        mid = (start + end) / 2 = 1
        num = 2
        left = 1
        right = 1
        => return mid

    right half
        start = mid + 1 = 4
        end = 6
        mid = (start + end) / 2 = 5
        num = 6
        left = 5
        right = 4
**/

// Time complexity: O(log(n))
// Space complexity: O(log(n))
func findPeakElement(_ nums: [Int]) -> Int {
    return findPeakElementRecursive(nums, start: 0, end: nums.count - 1)
}

func findPeakElementRecursive(_ nums: [Int], start: Int, end: Int) -> Int {
    if start > end {
        return -1
    }

    let midPoint = (start + end) / 2
    let num = nums[midPoint]
    let left = (midPoint - 1) >= 0 ? nums[midPoint - 1] : Int.min
    let right = (midPoint + 1) <= (nums.count - 1) ? nums[midPoint + 1] : Int.min
    if num > left && num > right {
        return midPoint
    }

    if left > num {
        return findPeakElementRecursive(nums, start: start, end: midPoint - 1)
    }

    return findPeakElementRecursive(nums, start: midPoint + 1, end: end)
}

// Time complexity: O(n)
func findPeakElementRecursive(_ nums: [Int], start: Int, end: Int) -> Int {
    if start > end {
        return -1
    }

    let midPoint = (start + end) / 2
    let num = nums[midPoint]
    let left = (midPoint - 1) >= 0 ? nums[midPoint - 1] : Int.min
    let right = (midPoint + 1) <= (nums.count - 1) ? nums[midPoint + 1] : Int.min
    if num > left && num > right {
        return midPoint
    }

    let leftHalfPeak = findPeakElementRecursive(nums, start: start, end: midPoint - 1)
    if leftHalfPeak != -1 {
        return leftHalfPeak
    }

    let rightHalfPeak = findPeakElementRecursive(nums, start: midPoint + 1, end: end)
    return rightHalfPeak
}

print(findPeakElement([1,2,3,1])) // 2
print(findPeakElement([1,2,1,3,5,6,4])) // 1 OR 5