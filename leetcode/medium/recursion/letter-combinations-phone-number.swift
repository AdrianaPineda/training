// https://leetcode.com/explore/interview/card/facebook/53/recursion-3/267/

// Given a string containing digits from 2-9 inclusive, return all possible
// letter combinations that the number could represent. Return the answer in any order.
// A mapping of digit to letters (just like on the telephone buttons) is given below. 
// Note that 1 does not map to any letters.

/**

2 -> a b c
3 -> d e f
4 -> g h i
5 -> j k l
6 -> m n o
7 -> p q r s
8 -> t u v
9 -> w x y z

Input: digits = "23"
Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]

prefix && array digits

[2, 3, 4]
 =>  prefix: "a" || "b" || "c"
     digits: [3, 4]

      => prefix: "ad" || "ae" || "af" || "bd" || "be" || "bf" || "cd" || "ce" || "cf"
         digit: [4]

            => prefix: "adg" || ....
                digit: []

*/ 
// "23" -> ["2", "3"] -> [2, 3]
// results = ["ad", "ae", "af", "bd"]
// index = 0
// 2 => ["a", "b", "c"]
//      prefix: a, b
//      index: 1
//      3 => ["d", "e", "f"]
//           prefix: ad, ae, bd
//           index: 2

// Time complexity: O((m^n)*n), being n the length of the digits, and m the number of letters that map to a digit
// Space complexity: O(m^n)
func letterCombinations(_ digits: String) -> [String] {
	let digitsAsIntArray = digits.compactMap{ Int(String($0)) }
	var results = [String]()
	letterCombinationsRecursive(digits: digitsAsIntArray, index: 0, prefix: "", result: &results)
	return results
}

func letterCombinationsRecursive(digits: [Int], index: Int, prefix: String, result: inout [String]) {
	if index >= digits.count {
		if !prefix.isEmpty {
			result.append(prefix)
		}
		return
	}

	let charsFromDigit = charsFrom(digit: digits[index])
	for char in charsFromDigit {
		let currentPrefix = "\(prefix)\(char)"
		letterCombinationsRecursive(digits: digits, index: index + 1, prefix: currentPrefix, result: &result)
	}
}

func charsFrom(digit: Int) -> [Character] {
	switch(digit) {
		case 2:
			return ["a", "b", "c"]
		case 3:
			return ["d", "e", "f"]
		case 4:
			return ["g", "h", "i"]
		case 5:
			return ["j", "k", "l"]
		case 6:
			return ["m", "n", "o"]
		case 7:
			return ["p", "q", "r", "s"]
		case 8:
			return ["t", "u", "v"]
		case 9:
			return ["w", "x", "y", "z"]
		default:
			return []
	}
}


print(letterCombinations("23")) // ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
print(letterCombinations("")) // []
print(letterCombinations("2")) // ["a", "b", "c"]
