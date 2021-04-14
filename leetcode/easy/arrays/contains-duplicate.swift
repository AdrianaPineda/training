// https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/578/

// Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.

// Using bit operations (only works if currNum is less than Int.max number of digits)
// Time complexity: O(n)
// Space complexity: O(1)
func containsDuplicate(_ nums: [Int]) -> Bool {
	var referenceNumber = 0

	for num in nums {
		let currNum = 1 << num
		if currNum & referenceNumber > 0 {
			return true
		}

		referenceNumber = currNum ^ referenceNumber
	}

	return false
}


// Using has table
// Time complexity: O(n)
// Space complexity: O(n)
func containsDuplicate(_ nums: [Int]) -> Bool {
	var numOcurrences = [Int: Bool]()

	for num in nums {
		if let _ = numOcurrences[num] {
            return true
        }

		numOcurrences[num] = true
	}

	return false
}

print(containsDuplicate([1, 2, 3, 1])) // true
print(containsDuplicate([1, 2, 3, 4])) // false
print(containsDuplicate([12969, 2, 3, 12969])) // true