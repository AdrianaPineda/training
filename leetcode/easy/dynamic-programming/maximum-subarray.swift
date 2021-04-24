// https://leetcode.com/explore/interview/card/top-interview-questions-easy/97/dynamic-programming/566/

// Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

// Example: nums = [5,4,-1,7,8]
// max = 9
// current = 8

// Time complexity: O(n)
// Space complexity: O(1)
func maxSubArray(_ nums: [Int]) -> Int {
	var max = Int.min
	var current = 0

	for num in nums {
		let tempSum = current + num
		current = tempSum > num ? tempSum : num
		max = current > max ? current : max
	}

	return max
}

// Using max
func maxSubArray(_ nums: [Int]) -> Int {
	var maxNum = Int.min
	var current = 0

	for num in nums {
		let tempSum = current + num
		current = max(tempSum, num)
		maxNum = max(current, maxNum)
	}

	return maxNum
}

print(maxSubArray([5, 4, -1, 7, 8])) // 23
print(maxSubArray([5, 4, -10, 5, 5])) // 10
print(maxSubArray([5, 4, -10, 5, 2])) // 9
print(maxSubArray([5, 4, -1, 5, 2])) // 15
print(maxSubArray([-1])) // -1
print(maxSubArray([-2, 1, -3, 4, -1, 2, 1, -5, 4])) // 6

//              [5,    4,    -1,    7,   8]
// tempSum      5     9      8     15    23
// curr = 0     5     9      8     15    23
// max = 0      5     9      9     15    23

//              [5,    4,   -10,    5,   5]
// tempSum      5     9      -1     4    10
// curr = 0     5     9      -1     5    10
// max = 0      5     9      9      9    10

//              [5,    4,   -10,    5,   2]
// tempSum      5     9      -1     4    7
// curr = 0     5     9      -1     5    7
// max = 0      5     9      9      9    9

//              [5,    4,   -1,    5,   2]
// tempSum      5     9      8     13   15
// curr = 0     5     9      8     13   15
// max = 0      5     9      9     13   15
