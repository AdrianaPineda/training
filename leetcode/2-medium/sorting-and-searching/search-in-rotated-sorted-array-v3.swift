// https://leetcode.com/problems/search-in-rotated-sorted-array/

// binary search, looking at start and end indexes
// Time complexity: O(log(n))
// Space complexity: O(log(n))
func search(_ nums: [Int], _ target: Int) -> Int {
    return searchRecursive(nums, target, start: 0, end: nums.count - 1) ?? -1
}

func searchRecursive(_ nums: [Int], _ target: Int, start: Int, end: Int) -> Int? {
    if start > end { return nil }

    let midPoint = (start + end) / 2
    if nums[midPoint] == target { return midPoint }

    if nums[start] <= nums[midPoint] {
        if target < nums[midPoint] && target >= nums[start] {
            return searchRecursive(nums, target, start: start, end: midPoint - 1)
        } else {
            return searchRecursive(nums, target, start: midPoint + 1, end: end)
        }
    } else {
        if target > nums[midPoint] && target <= nums[end] {
            return searchRecursive(nums, target, start: midPoint + 1, end: end)
        } else {
            return searchRecursive(nums, target, start: start, end: midPoint - 1)
        }
    }
    
}
// index         0   1  2  3  4  5  6
//              [4, 5, 6, 7, 0, 1, 2], target = 0
// start                    ^
// end                      ^
// mid                      ^