// https://leetcode.com/explore/interview/card/facebook/54/sorting-and-searching-3/279/
/**
There is an integer array nums sorted in ascending order (with distinct values).

Prior to being passed to your function, nums is rotated at an unknown pivot index k (0 <= k < nums.length) 
such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). 
For example, [0,1,2,4,5,6,7] might be rotated at pivot index 3 and become [4,5,6,7,0,1,2].

Given the array nums after the rotation and an integer target, return the index of target if it is in nums, or -1 if it is not in nums.

You must write an algorithm with O(log n) runtime complexity.
*/

func search(_ nums: [Int], _ target: Int) -> Int {
	let pivot = searchPivot(nums: nums)
	return binarySearch(nums: nums, pivot: pivot, target: target)
}

func searchPivot(nums: [Int]) -> Int {
	var startIndex = 0
	var endIndex = nums.count - 1

	while startIndex <= endIndex {
		let currIndex = startIndex + (endIndex - startIndex) / 2
		if currIndex < (nums.count - 1) && nums[currIndex] > nums[currIndex + 1] {
			return currIndex + 1
		} else {
			if nums[startIndex] > nums[currIndex] {
				endIndex = currIndex - 1
			} else {
				startIndex = currIndex + 1
			}
		}
	}

	return 0
}

func searchPivotRecursive(nums: [Int], startIndex: Int, endIndex: Int) -> Int {
	if startIndex > endIndex {
		return 0
	}

	let midPoint = startIndex + (endIndex - startIndex) / 2
	let nextNumber = midPoint + 1

	if nextNumber < (nums.count - 1) && nums[midPoint] > nums[nextNumber] {
		return nextNumber
	} else {
		if (nums[startIndex] < nums[midPoint]) {
			return searchPivotRecursive(nums: nums, startIndex: midPoint + 1, endIndex: endIndex)
		} else {
			return searchPivotRecursive(nums: nums, startIndex: startIndex, endIndex: midPoint - 1)
		}
	}
}

func binarySearchRecursive(nums: [Int], pivot: Int, startIndex: Int, endIndex: Int, target: Int) -> Int {
	if startIndex > endIndex {
		return -1
	}

	let midPoint = startIndex + (endIndex - startIndex) / 2
	let realMidPoint = (pivot + midPoint) % nums.count
	let currNumber = nums[realMidPoint]
	if currNumber == target {
		return realMidPoint
	}

	if currNumber > target {
		return binarySearchRecursive(nums: nums, pivot: pivot, startIndex: startIndex, endIndex: midPoint - 1, target: target)
	} else {
		return binarySearchRecursive(nums: nums, pivot: pivot, startIndex: midPoint + 1, endIndex: endIndex, target: target)
	}
}

func binarySearch(nums: [Int], pivot: Int, target: Int) -> Int {
	var startIndex = 0
	var endIndex = nums.count - 1

	while startIndex <= endIndex {
		let midPoint = startIndex + (endIndex - startIndex) / 2
		let realMidPoint = (pivot + midPoint) % nums.count
		let currNumber = nums[realMidPoint]
		if currNumber == target {
			return realMidPoint
		}

		if currNumber > target {
			endIndex = midPoint - 1
		} else {
			startIndex = midPoint + 1
		}
	}

	return -1
}

print(search([4, 5, 6, 7, 0, 1, 2], 4)) // 0
print(search([4, 5, 6, 7, 0, 1, 2], 5)) // 1
print(search([4, 5, 6, 7, 0, 1, 2], 6)) // 2
print(search([4, 5, 6, 7, 0, 1, 2], 7)) // 3
print(search([4, 5, 6, 7, 0, 1, 2], 0)) // 4
print(search([4, 5, 6, 7, 0, 1, 2], 1)) // 5
print(search([4, 5, 6, 7, 0, 1, 2], 2)) // 6

func singlePassBinarySearch(_ nums: [Int], _ target: Int) -> Int {
	var startIndex = 0
	var endIndex = nums.count - 1

	while startIndex <= endIndex {
		let midPoint = (startIndex + endIndex) / 2 // startIndex + (endIndex - startIndex) /2
		if nums[midPoint] == target {
			return midPoint
		}

		if nums[startIndex] <= nums[midPoint] {
			if nums[startIndex] <= target && target < nums[midPoint] {
				endIndex = midPoint - 1
			} else {
				startIndex = midPoint + 1
			}
		} else {
			if nums[midPoint] < target && target <= nums[endIndex] {
				startIndex = midPoint + 1
			} else {
				endIndex = midPoint - 1
			}
		}
	}

	return -1
}

print(singlePassBinarySearch([4, 5, 6, 7, 0, 1, 2], 4)) // 0
print(singlePassBinarySearch([4, 5, 6, 7, 0, 1, 2], 5)) // 1
print(singlePassBinarySearch([4, 5, 6, 7, 0, 1, 2], 6)) // 2
print(singlePassBinarySearch([4, 5, 6, 7, 0, 1, 2], 7)) // 3
print(singlePassBinarySearch([4, 5, 6, 7, 0, 1, 2], 0)) // 4
print(singlePassBinarySearch([4, 5, 6, 7, 0, 1, 2], 1)) // 5
print(singlePassBinarySearch([4, 5, 6, 7, 0, 1, 2], 2)) // 6
