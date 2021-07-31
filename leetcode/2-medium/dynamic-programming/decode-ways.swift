// https://leetcode.com/explore/interview/card/facebook/55/dynamic-programming-3/264/
/**
A message containing letters from A-Z can be encoded into numbers using the following mapping:

'A' -> "1"
'B' -> "2"
...
'Z' -> "26"

To decode an encoded message, all the digits must be grouped then mapped back into letters using 
the reverse of the mapping above (there may be multiple ways). For example, "11106" can be mapped into:

"AAJF" with the grouping (1 1 10 6)
"KJF" with the grouping (11 10 6)
Note that the grouping (1 11 06) is invalid because "06" cannot be mapped into 'F' since "6" is different from "06".

Given a string s containing only digits, return the number of ways to decode it.

The answer is guaranteed to fit in a 32-bit integer.
*/

// Time complexity: O(n)
// Space complexity: O(n)
func numDecodings(_ s: String) -> Int {
	var codingNumbers = [String: Int]()
	return numDecodings(Array(s), &codingNumbers)
}

func numDecodings(_ s: [Character], _ codingNumbers: inout [String: Int]) -> Int {
	guard s.count > 0 else {
		return 1
	}

	if let codingNums = codingNumbers[String(s)] {
		return codingNums
	}

	var codings = 0
	defer {
		codingNumbers[String(s)] = codings
	}

	guard isValidNumber(num: s[0..<1]) else { // one digit num
		return codings
	}
	codings += numDecodings(Array(s[1...]), &codingNumbers)

	guard s.count > 1 && isValidNumber(num: s[0..<2]) else { // two digit num
		return codings
	}
	codings += numDecodings(Array(s[2...]), &codingNumbers)

	return codings
}

func isValidNumber(num: ArraySlice<Character>) -> Bool {
	guard num.count > 0 && num.count <= 2 else {
		return false
	}

	let firstNumber = Int(String(num[0])) ?? 0
	let bothNumbers = Int(String(num)) ?? 0
	return firstNumber >= 1 && firstNumber <= 9 && bothNumbers >= 1 && bothNumbers <= 26
}

print(numDecodings("11106")) // 2
print(numDecodings("12")) // 2
print(numDecodings("226")) // 3
print(numDecodings("0")) // 0