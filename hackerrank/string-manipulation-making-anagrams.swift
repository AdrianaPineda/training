//
// Problem: https://www.hackerrank.com/challenges/ctci-making-anagrams/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=strings
// Big O:
// Time complexity: O(a + b) = O(max(a,b))
// Space complexity: O(a)

// Problem
// Complete the makeAnagram function below.
func makeAnagram(a: String, b: String) -> Int {

    // Build a chars occurrences dictionary
    var aCharCount = 0
    var aDict:[Character: Int] = [:]
    for char in a {
        let currentOcurrence = aDict[char] ?? 0
        aDict[char] = currentOcurrence + 1
        aCharCount += 1
    }

    // Loop over b chars
    var charsToRemoveFromB = 0
    var charsToKeepFromB = 0
    for char in b {
        if let count = aDict[char], count > 0 {
            aDict[char] = (count - 1)
            charsToKeepFromB += 1
        } else {
            charsToRemoveFromB += 1
        }
    }

    let charsToRemoveFromA = (aCharCount - charsToKeepFromB)
    let totalCharsToRemove = charsToRemoveFromA + charsToRemoveFromB

    return totalCharsToRemove

}

func getCharOcurrencesDict(string: String) -> [Character: Int] {
    var charDict:[Character: Int] = [:]
    for char in string {
        let currentOcurrence = charDict[char] ?? 0
        charDict[char] = currentOcurrence + 1
    }

    return charDict
}

print(makeAnagram(a: "cde", b: "dcf"))
print(makeAnagram(a: "hello", b: "hithere"))