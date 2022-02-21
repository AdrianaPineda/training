// https://leetcode.com/explore/interview/card/facebook/55/dynamic-programming-3/3034/

// Given a string s, return the longest palindromic substring in s.

/**
Example 1:
Input: s = "babad"
Output: "bab"
Note: "aba" is also a valid answer.

Example 2:
Input: s = "cbbd"
Output: "bb"

Example 3:
Input: s = "a"
Output: "a"

Example 4:
Input: s = "ac"
Output: "a"

*/

// No optimaztion
// Time complexity: O(n^3)
// Space complexity: O(n)
func longestPalindrome(_ s: String) -> String {
	var longesPalindromeSize = 0
	var startIndex = -1
	var endIndex = -1
	let stringArray = Array(s)
	let charIndexes = getCharIndexes(stringArray: stringArray)

	for (i, char) in stringArray.enumerated() {
		guard let indexes = charIndexes[char] else {
			continue
		}

		for j in (0..<indexes.count).reversed() {
			let index = indexes[j]
			if index <= i {
				continue
			}

			let isSubstringPalindrome = isPalindrome(startIndex: i, endIndex: index, stringArray: stringArray)
			let currentPalindromeSize = index - i + 1
			if (isSubstringPalindrome && currentPalindromeSize > longesPalindromeSize) {
				longesPalindromeSize =  currentPalindromeSize
				startIndex = i
				endIndex = index
                break
			}
		}
	}

	if startIndex == -1 && endIndex == -1 {
		return ""
	}

	let startRange = s.index(s.startIndex, offsetBy: startIndex)
	let endRange = s.index(s.startIndex, offsetBy: endIndex)

	return String(s[startRange...endRange])

}

func isPalindrome(startIndex: Int, endIndex: Int, stringArray: [Character]) -> Bool {
	var currentStartIndex = startIndex
	var currentEndIndex = endIndex

	while currentStartIndex < currentEndIndex {
		let leftChar = stringArray[currentStartIndex]
		let rightChar = stringArray[currentEndIndex]

		if leftChar != rightChar {
			return false
		}

		currentStartIndex -= 1
		currentEndIndex -= 1
	}

	return true
}

func getCharIndexes(stringArray: [Character]) -> [Character: [Int]] {
	var charIndexes = [Character: [Int]]()

	for (i, char) in stringArray.enumerated() {
		guard var indexes = charIndexes[char] else {
			charIndexes[char] = [i]
			continue
		}

		indexes.append(i)
		charIndexes[char] = indexes
	}

	return charIndexes
}

// With optimization
// Time complexity: O(n^2)
// Space complexity: O(n)
func longestPalindrome(_ s: String) -> String {
	let stringArray = Array(s)
	var maxPalindromeSize = 0
	var startIndex = -1
	var endIndex = -1

	for i in 0..<stringArray.count {
		let firstSize = checkForPalindrome(startIndex: i, endIndex: i, stringArray: stringArray)
		let secondSize = checkForPalindrome(startIndex: i, endIndex: i + 1, stringArray: stringArray)
		let currentSize = max(firstSize, secondSize)

		if (currentSize > 0 && currentSize > maxPalindromeSize) {
			startIndex = i - (currentSize - 1) / 2
			endIndex = i + currentSize / 2
			maxPalindromeSize = currentSize
		}
	}

	if startIndex == -1 && endIndex == -1 {
		return ""
	}

	let startRange = s.index(s.startIndex, offsetBy: startIndex)
	let endRange = s.index(s.startIndex, offsetBy: endIndex)
	return String(s[startRange...endRange])
}

func checkForPalindrome(startIndex: Int, endIndex: Int, stringArray: [Character]) -> Int {
	var currentStartIndex = startIndex
	var currentEndIndex = endIndex

	while currentStartIndex >= 0 && currentEndIndex < stringArray.count {
		if stringArray[currentStartIndex] != stringArray[currentEndIndex] {
			break
		}
		currentStartIndex -= 1
		currentEndIndex += 1
	}

	let size = currentEndIndex - currentStartIndex - 1

	return size
}