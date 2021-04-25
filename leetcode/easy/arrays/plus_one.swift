// https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/559/

// Given a non-empty array of decimal digits representing a non-negative integer, increment one to the integer.
// The digits are stored such that the most significant digit is at the head of the list, and each element in the array contains a single digit.
// You may assume the integer does not contain any leading zero, except the number 0 itself.

/**
Example 1:
    Input: digits = [1,2,3]
    Output: [1,2,4]
    Explanation: The array represents the integer 123.

Example 2:
    Input: digits = [4,3,2,1]
    Output: [4,3,2,2]
    Explanation: The array represents the integer 4321.


Example 3:
    Input: digits = [0]
    Output: [1]
*/

// Time complexity: O(n)
// Space complexity: O(n)

func plusOne(_ digits: [Int]) -> [Int] {
	var updatedDigits = digits
	var lastIndex = digits.count - 1

	while lastIndex >= 0 && digits[lastIndex] == 9 {
		updatedDigits[lastIndex] = 0
		lastIndex -= 1
	}

	if (lastIndex == -1) { // when all digits are 9
		updatedDigits.insert(1, at: 0)
	} else {
		updatedDigits[lastIndex] = digits[lastIndex] + 1
	}

	return updatedDigits
}

func plusOne(_ digits: [Int]) -> [Int] {
	var updatedDigits = digits
	var lastIndex = digits.count - 1

	while lastIndex >= 0 && digits[lastIndex] == 9 {
		updatedDigits[lastIndex] = 0
		lastIndex -= 1
	}

	if (lastIndex == -1) { // when all digits are 9
		updatedDigits = Array(repeating: 0, count: digits.count + 1)
        updatedDigits[0] = 1
	} else {
		updatedDigits[lastIndex] = digits[lastIndex] + 1
	}

	return updatedDigits
}

print(plusOne([9, 9, 9, 9])) // [1, 0, 0, 0, 0]
print(plusOne([1, 2, 9])) // [1, 3, 0]
print(plusOne([1, 2, 3])) // [1, 2, 4]
print(plusOne([4, 3, 2, 1])) // [4, 3, 2, 2]
print(plusOne([0])) // [1]
print(plusOne([9])) // [1, 0]