// https://leetcode.com/explore/interview/card/facebook/53/recursion-3/267/

let digitToLetters: [Character: [Character]] = [
    "1": [],
    "2": ["a", "b", "c"],
    "3": ["d", "e", "f"],
    "4": ["g", "h", "i"],
    "5": ["j", "k", "l"],
    "6": ["m", "n", "o"],
    "7": ["p", "q", "r", "s"],
    "8": ["t", "u", "v"],
    "9": ["w", "x", "y", "z"],
    "0": [" "]
]

// keep a current combination param
// loop through each digit
// append the char to the current combination
// if base case: no more digits to iterate

// Option 1
// Time complexity: O((m^n)*n), being m the avg number of chars, n the number of digits
// Space complexity: O(m^n)
func letterCombinations(_ digits: String) -> [String] {
    var result = [String]()
    letterCombinationsRecursive(Array(digits), 0, &result)
    return result
}

func letterCombinationsRecursive(_ digits: [Character], _ digitIndex: Int, _ result: inout [String], _ currCombination: String? = nil) {
    if digitIndex == digits.count {
        if let currCombination = currCombination {
            result.append(currCombination)
        }
        return
    }

    let digit = digits[digitIndex]
    guard let letters = digitToLetters[digit] else { return }

    for letter in letters {
        let updatedCombination = "\(currCombination ?? "")\(letter)"
        letterCombinationsRecursive(digits, digitIndex + 1, &result, updatedCombination)
    }
}

// Option 2
let digitToLetters: [Character: [String]] = [
    "1": [],
    "2": ["a", "b", "c"],
    "3": ["d", "e", "f"],
    "4": ["g", "h", "i"],
    "5": ["j", "k", "l"],
    "6": ["m", "n", "o"],
    "7": ["p", "q", "r", "s"],
    "8": ["t", "u", "v"],
    "9": ["w", "x", "y", "z"],
    "0": [" "]
]

// Time complexity: O(sum(m^0 ... m^m))
// Space complexity: O(m^n)
func letterCombinations(_ digits: String) -> [String] {
    return letterCombinationsRecursive(Array(digits))
}

func letterCombinationsRecursive(_ digits: [Character], _ digitIndex: Int = 0) -> [String] {
    if digitIndex == digits.count {
        return []
    }

    let digit = digits[digitIndex]
    guard let letters = digitToLetters[digit] else { return [] }

    if digitIndex == (digits.count - 1) {
        return letters
    }

    var currentResult = [String]()
    for letter in letters {
        let result = letterCombinationsRecursive(digits, digitIndex + 1)

        for val in result {
            currentResult.append("\(letter)\(val)")
        }
    }

    return currentResult
}


print(letterCombinations("23")) // ["ad","ae","af","bd","be","bf","cd","ce","cf"]
print(letterCombinations("")) // []
print(letterCombinations("2")) // ["a","b","c"]