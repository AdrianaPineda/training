
// Given a string, write a function to chekc if it is a permutation of a palindrome

// With hash table
// Time complexity: O(n)
// Space complexity: O(n)
func isLetter(char: Character) -> Bool {
    let string = String(char)
    return string.range(of: #"[a-zA-Z]"#, options: .regularExpression) != nil
}

func getCharFrequencies(s: String) -> [Character: Int] {
    var charFrequencies = [Character: Int]()
    for char in s {
        guard isLetter(char: char) else { continue }
        let lowercasedChar = Character(char.lowercased())
        guard let frequency = charFrequencies[lowercasedChar] else {
            charFrequencies[lowercasedChar] = 1
            continue
        }

        charFrequencies[lowercasedChar] = (frequency + 1)
    }

    return charFrequencies
}

func isEven(number: Int) -> Bool {
    return number % 2 == 0
}

func isPalindromePermutation(s: String) -> Bool {
    // Create hash table
    let charFrequencies = getCharFrequencies(s: s)

    // Iterate over hash table and look for odd/even frequencies
    var oddFrequencies = 0
    for frequency in charFrequencies.values {
        if isEven(number: frequency) {
            continue
        }

        if oddFrequencies > 0 {
            // More than one frequency is odd
            return false
        }

        oddFrequencies += 1
    }

    return true
}

// With bit vector
// Time complexity: O(n)
// Space complexity: O(1)
let charsetSize = 128
func isLetter(char: Character) -> Bool {
    let string = String(char)
    return string.range(of: #"[a-zA-Z]"#, options: .regularExpression) != nil
}

func isPalindromePermutation(s: String) -> Bool {
    var checker = Array(repeating: 0, count: charsetSize)
    let firstChar: Character = "a"
    let firstCharAsciiValue = firstChar.asciiValue ?? 0

    for char in s {
        guard isLetter(char: char) else { continue }

        let lowercasedChar = Character(char.lowercased())
        guard let asciiValue = lowercasedChar.asciiValue else { continue }
        let value = Int(asciiValue - firstCharAsciiValue)
        
        var bitRepresentation = Array(repeating: 0, count: charsetSize)
        bitRepresentation[charsetSize - 1 - value] = 1

        checker = checker.enumerated().map { (index, element) in  element ^ bitRepresentation[index]}
    }

    let sum = checker.reduce(0, { x, y in x + y })
    return sum <= 1

}

func isPalindromePermutationAlt(s: String) -> Bool {
    var checker = 0
    let firstChar: Character = "a"
    let firstCharAsciiValue = firstChar.asciiValue ?? 0

    for char in s {
        guard isLetter(char: char) else { continue }

        let lowercasedChar = Character(char.lowercased())
        guard let asciiValue = lowercasedChar.asciiValue else { continue }
        let value = Int(asciiValue - firstCharAsciiValue)

        let bitRepresentation = 1 << value

        checker = checker ^ bitRepresentation
    }

    let bitString = String(checker, radix: 2)
    let bitArray = bitString.compactMap { $0.wholeNumberValue }
    let sum = bitArray.reduce(0, { x, y in x + y })
    return sum <= 1

}

print(isPalindromePermutation(s: "tact coA")) // true
print(isPalindromePermutation(s: "ticcittaccatoz")) // false
print(isPalindromePermutation(s: "ticcittaccato")) // true
print(isPalindromePermutation(s: "ticcittaccat")) // true
print(isPalindromePermutation(s: "tact cA")) // true
print(isPalindromePermutation(s: "tact co$")) // false
