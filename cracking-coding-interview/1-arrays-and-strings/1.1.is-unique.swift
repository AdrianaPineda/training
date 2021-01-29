// Implement an algorithm to determine if a string has all unique characters. What if you cannot use additional data structures?

// 1) with hash table
// Time complexity: O(n)
// Space complexity: O(n)
func doesStringHaveUniqueChars(s: String) -> Bool {
    var charOccurrences = [Character: Bool]()

    for char in s {
        guard let _ = charOccurrences[char] else {
            charOccurrences[char] = true
            continue
        }

        return false
    }

    return true
}

// 2) without additional data structure
// Time complexity: O(n*log(n))
// Space complexity: O(n)
func doesStringHaveUniqueChars(s: String) -> Bool {
    let sortedString = s.sorted()
    print(sortedString)

    for i in 0..<(sortedString.count - 1) {
        let currChar = sortedString[i]
        let nextChar = sortedString[i + 1]

        if currChar == nextChar {
            return false
        }
    }

    return true
}


print(doesStringHaveUniqueChars(s: "aaaaa")) // false
print(doesStringHaveUniqueChars(s: "abcdef")) // true
print(doesStringHaveUniqueChars(s: "abdefc")) // true