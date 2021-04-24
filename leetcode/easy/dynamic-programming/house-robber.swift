// https://leetcode.com/explore/interview/card/top-interview-questions-easy/97/dynamic-programming/576/
// You are a professional robber planning to rob houses along a street. Each house has a certain amount 
// of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses 
// have security systems connected and it will automatically contact the police if two adjacent houses 
// were broken into on the same night.
// 
// Given an integer array nums representing the amount of money of each house, return the maximum amount 
// of money you can rob tonight without alerting the police.

// 1,2,3,1   => 4
// 2,7,9,3,1 => 12
// 2,1,1,2   => 4

// Timeout
func rob(_ nums: [Int]) -> Int {
    if nums.count <= 2 {
        return nums.reduce(0, max)
    }

    let evenSlice = nums[2...]
    let oddSlice = nums[3...]
    return max(nums[0] + rob(Array(evenSlice)), nums[1] + rob(Array(oddSlice)))
}

// With memoization and endIndex
func rob(_ nums: [Int]) -> Int {
    var cache = [String: Int]()
    return robWithMemo(nums, cache: &cache, startIndex: 0, endIndex: nums.count - 1)
}

func robWithMemo(_ nums: [Int], cache: inout [String: Int], startIndex: Int, endIndex: Int) -> Int {
    let key = "\(startIndex): \(endIndex)"
    if let maxNum = cache[key] {
        return maxNum
    }

    let count = nums.count
    if count <= 2 {
        return nums.reduce(0, max)
    }

    let endIndex = count - 1
    let evenSliceStartIndex = 2
    let evenSliceMax = robWithMemo(Array(nums[evenSliceStartIndex...]), cache: &cache, startIndex: evenSliceStartIndex, endIndex: endIndex)
    let oddSliceStartIndex = 3
    let oddSliceMax = robWithMemo(Array(nums[oddSliceStartIndex...]), cache: &cache, startIndex: oddSliceStartIndex, endIndex: endIndex)
    let maxValue = max(nums[0] + evenSliceMax, nums[1] + oddSliceMax)
    cache[key] = maxValue
    return maxValue
}

// With memoization
// Time complexity: O(n)
// Space complexity: O(n)
let evenStartIndex = 2
let oddStartIndex = 3

func rob(_ nums: [Int]) -> Int {
    var cache = [Int: Int]()
    return robWithMemo(nums, cache: &cache, startIndex: 0)
}

func robWithMemo(_ nums: [Int], cache: inout [Int: Int], startIndex: Int) -> Int {
    if let maxNum = cache[startIndex] {
        return maxNum
    }

    let count = nums.count
    if count <= 2 {
        return nums.reduce(0, max)
    }

    
    let evenSliceMax = robWithMemo(Array(nums[evenStartIndex...]), cache: &cache, startIndex: evenStartIndex + startIndex)
    let oddSliceMax = robWithMemo(Array(nums[oddStartIndex...]), cache: &cache, startIndex: oddStartIndex + startIndex)
    let maxValue = max(nums[0] + evenSliceMax, nums[1] + oddSliceMax)
    cache[startIndex] = maxValue
    return maxValue
}

rob([1, 2, 3, 1]) // 4
rob([2, 7, 9, 3, 1]) // 12
rob([2, 1, 1, 2]) // 4
