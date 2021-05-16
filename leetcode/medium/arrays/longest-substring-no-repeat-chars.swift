// Given a string s, find the length of the longest substring without repeating characters.

// Time complexity: O(n*k), being k the longest substring
// Space complexity: O(n)
func lengthOfLongestSubstring(_ s: String) -> Int {
	var charIndexes = [Character: Int]()
	var currentLength = 0
	var maxLength = 0

	for (i, c) in s.enumerated() {
		defer {
			maxLength = max(maxLength, currentLength)
		}

		guard let charIndex = charIndexes[c] else {
			charIndexes[c] = i
			currentLength += 1
			continue
		}

		let nextSubstringLength = i - charIndex
		if nextSubstringLength < currentLength {
			charIndexes = getCharIndexes(start: charIndex + 1, end: i, str: s)
            //removeChars(charIndexes: &charIndexes, beforeIndex: charIndex)
		}

		charIndexes[c] = i
		currentLength = nextSubstringLength
	}

	return maxLength
}

func getCharIndexes(start: Int, end: Int, str: String) -> [Character: Int] {
	let startIndex = str.index(str.startIndex, offsetBy: start)
	let endIndex = str.index(str.startIndex, offsetBy: end)
	let mySubstring = str[startIndex...endIndex]

	var charIndexes = [Character: Int]()

	for (i, char) in mySubstring.enumerated() {
		charIndexes[char] = i + start
	}

	return charIndexes
}

func removeChars(charIndexes: inout [Character: Int], beforeIndex index: Int) {
	for (currChar, currCharIndex) in charIndexes {
		if  currCharIndex <= index {
			charIndexes.removeValue(forKey: currChar)
		}
	}
}

print(lengthOfLongestSubstring("asljlj")) // 4
print(lengthOfLongestSubstring("bbtablud")) // 6
print(lengthOfLongestSubstring("ohvhjdml")) // 6
print(lengthOfLongestSubstring("abcabcbb")) // 3
print(lengthOfLongestSubstring("bbbbb")) // 1
print(lengthOfLongestSubstring("pwwkew")) // 3
print(lengthOfLongestSubstring("")) // 0
print(lengthOfLongestSubstring("abcade")) // 5
print(lengthOfLongestSubstring("bcaabcdef")) // 6
