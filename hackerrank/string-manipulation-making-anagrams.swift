//
// Problem: https://www.hackerrank.com/challenges/ctci-making-anagrams/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=strings
// Big O:
// Time complexity: O(a + b) = O(max(a,b))
// Space complexity: O(a)

// Problem
// Complete the makeAnagram function below.
func makeAnagram(a: String, b: String) -> Int {

    // Build "a" string chars occurrences dictionary
    let aCharOcurrencesDict = getCharOcurrencesDict(string: a)

    // Get chars in "b" that match chars in "a"
    let charsToKeepFromB = getChars(fromString: b, thatAppearInDict: aCharOcurrencesDict)

    let aCharCount = a.count // This line might cost O(a) time and it will most likely take more time, but the complexity won't change.
    let bCharCount = b.count // This line might cost O(a) time and it will most likely take more time, but the complexity won't change.
    let charsToRemoveFromB = bCharCount - charsToKeepFromB
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

// This method loops over "string" chars and returns the number of chars that appear in the "dict" param
func getChars(fromString string: String, thatAppearInDict dict:[Character: Int]) -> Int {
    var charsThatMatch = 0
    var dictToCompare = dict
    for char in string {
        if let count = dictToCompare[char], count > 0 {
            dictToCompare[char] = (count - 1)
            charsThatMatch += 1
        }
    }

    return charsThatMatch
}

print(makeAnagram(a: "cde", b: "dcf"))
print(makeAnagram(a: "cde", b: "abc"))
print(makeAnagram(a: "hello", b: "hithere"))

func makeAnagram_v1(a: String, b: String) -> Int {

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