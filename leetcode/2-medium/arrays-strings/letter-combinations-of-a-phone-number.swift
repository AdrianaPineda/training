// https://leetcode.com/problems/letter-combinations-of-a-phone-number/
/**
Given a string containing digits from 2-9 inclusive, return all possible
letter combinations that the number could represent. Return the answer in any order.

A mapping of digit to letters (just like on the telephone buttons) is given
below. Note that 1 does not map to any letters.
*/
// Time complexity: O((4^n)*n)
// Space complexity: O(n)
let letters = [1: [], 2: ["a", "b", "c"], 3: ["d", "e", "f"], 4: ["g", "h", "i"], 5: ["j", "k", "l"], 6: ["m", "n", "o"], 7: ["p", "q", "r", "s"], 8: ["t", "u", "v"], 9: ["w", "x", "y", "z"]]
func letterCombinations(_ digits: String) -> [String] {
    let digitsAsNums = digits.compactMap { Int(String($0)) }
    var result = [String]()
    letterCombRecursive(index: 0, digits: digitsAsNums, word: "", result: &result)
    return result
}

func letterCombRecursive(index: Int, digits: [Int], word: String, result: inout [String]) {
    if index >= digits.count {
        if word.isEmpty { return }
        result.append(word)
        return
    }

    let currNum = digits[index]
    guard let currLetters = letters[currNum] else { return }
    for letter in currLetters {
        letterCombRecursive(index: index + 1, digits: digits, word: "\(word)\(letter)", result: &result)
    }
}

// Alt
let letters: [Character: String] = ["1": "", "2": "abc", "3": "def", "4": "ghi", "5": "jkl", "6": "mno", "7": "pqrs", "8": "tuv", "9": "wxyz"]
func letterCombinations(_ digits: String) -> [String] {
    let digitsAsNums = Array(digits)
    var result = [String]()
    if digits.isEmpty { return result }
    letterCombRecursive(index: 0, digits: digitsAsNums, word: "", result: &result)
    return result
}

func letterCombRecursive(index: Int, digits: [Character], word: String, result: inout [String]) {
    if index >= digits.count {
        result.append(word)
        return
    }

    let currNum = digits[index]
    guard let currLetters = letters[currNum] else { return }
    for letter in currLetters {
        letterCombRecursive(index: index + 1, digits: digits, word: "\(word)\(letter)", result: &result)
    }
}


print(letterCombinations("23")) // ["ad","ae","af","bd","be","bf","cd","ce","cf"]
print(letterCombinations("2")) // ["a","b","c"]
print(letterCombinations("")) // []
