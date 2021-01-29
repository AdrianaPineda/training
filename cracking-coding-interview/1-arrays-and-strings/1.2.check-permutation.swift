// Given two strings, write a method to decide if one is a permutation of the other

// 1) Without additional data structures - Sorting the strings
// Time complexity: O(n*log(n))
// Space complexity: O(n)
func isPermutation(stringA: String, stringB: String) -> Bool {
    if stringA.count != stringB.count {
        return false
    }

    let sortedStringA = stringA.sorted() // O(n*log(n))
    let sortedStringB = stringB.sorted() // O(n*log(n))

    for i in 0..<sortedStringA.count {
        let charAtA = sortedStringA[i]
        let charAtB = sortedStringB[i]
        if charAtA != charAtB {
            return false
        }
    }

    return true
}

func isPermutationAlt(stringA: String, stringB: String) -> Bool {
    if stringA.count != stringB.count {
        return false
    }

    let sortedStringA = stringA.sorted() // O(n*log(n))
    let sortedStringB = stringB.sorted() // O(n*log(n))

    return sortedStringA.elementsEqual(sortedStringB)
}

// 1) With a hash table
// Time complexity: O(n)
// Space complexity: O(n)
func isPermutation(stringA: String, stringB: String) -> Bool {
    if stringA.count != stringB.count {
        return false
    }

    let charFrequencies = getCharFrequencies(string: stringA)

    let updatedCharFrequencies = checkFrequencies(charFrequencies: charFrequencies, inString: stringB)

    return updatedCharFrequencies.keys.count == 0

}

func checkFrequencies(charFrequencies: [Character: Int], inString string: String) -> [Character: Int] {
    var updatedCharFrequencies = charFrequencies
    
    for char in string {
        guard let frequency = updatedCharFrequencies[char] else {
            return updatedCharFrequencies
        }

        if frequency == 1 {
            updatedCharFrequencies.removeValue(forKey: char)
        } else {
            updatedCharFrequencies[char] = frequency - 1
        }
    }

    return updatedCharFrequencies
}

func getCharFrequencies(string: String) -> [Character: Int] {
    var charFrequencies = [Character: Int]()
    for char in string {
        guard let frequency = charFrequencies[char] else {
            charFrequencies[char] = 1
            continue
        }

        charFrequencies[char] = frequency + 1
    }

    return charFrequencies
}

print(isPermutation(stringA: "abcdefg", stringB: "cdefgba")) // true
print(isPermutation(stringA: "abcdefg", stringB: "cdffefgba")) // false
print(isPermutation(stringA: "abcdefg", stringB: "cdefgbc")) // false
