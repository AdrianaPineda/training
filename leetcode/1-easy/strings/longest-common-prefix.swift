// https://leetcode.com/explore/featured/card/top-interview-questions-easy/127/strings/887/
// Write a function to find the longest common prefix string amongst an array of strings.

// If there is no common prefix, return an empty string "".

/**

Example 1:
    Input: strs = ["flower","flow","flight"]
    Output: "fl"

Example 2:
    Input: strs = ["dog","racecar","car"]
    Output: ""
    Explanation: There is no common prefix among the input strings.
*/

// Given n is the size of the array and c the size of each string
// Time complexity: O(n*c)
// Space complexity: O(n*c)
func longestCommonPrefix(_ strs: [String]) -> String {
	var maxPrefix = strs.count > 0 ? strs[0] : ""
	for i in 1..<strs.count {
		maxPrefix = getPrefix(str1: maxPrefix, str2: strs[i])
		if maxPrefix.isEmpty {
			break
		}
	}

	return maxPrefix
}

func getPrefix(str1: String, str2: String) -> String {
	var strPrefix = ""

	let arrayStr1 = Array(str1)
	let arrayStr2 = Array(str2)
	let minCharLength = min(arrayStr1.count, arrayStr2.count)

	for i in 0..<minCharLength {
		let currStr1Char = arrayStr1[i]
		let currStr2Char = arrayStr2[i]

		if currStr1Char != currStr2Char {
			break
		}

		strPrefix += String(currStr1Char)
	}

	return strPrefix
}

print(longestCommonPrefix(["flower", "flow", "flight"])) // "fl"
print(longestCommonPrefix(["dog","racecar","car"])) // ""
print(longestCommonPrefix(["car", "carsen", "dummy", "flow", "flower"])) // ""
print(longestCommonPrefix(["c"])) // "c"
print(longestCommonPrefix(["acc","aaa","aaba"])) // "a"