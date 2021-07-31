// https://leetcode.com/explore/interview/card/facebook/55/dynamic-programming-3/3036/
// Given a string s and a dictionary of strings wordDict, return true if s can be 
// segmented into a space-separated sequence of one or more dictionary words.
// Note that the same word in the dictionary may be reused multiple times in the segmentation.
/**
Example 1:
    Input: s = "leetcode", wordDict = ["leet","code"]
    Output: true
    Explanation: Return true because "leetcode" can be segmented as "leet code".

Example 2:
    Input: s = "applepenapple", wordDict = ["apple","pen"]
    Output: true
    Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
    Note that you are allowed to reuse a dictionary word.

Example 3:
    Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
    Output: false

applepenapple
    apple - pen - apple - x

0 1 2 3 4 5 6 7 8
c a t s a n d o g       ["cats","dog","sand","and","cat"]
    count = 9
    index = 0 -> 3 -> 7 -> 4 -> 7

    currentString = "cat"
        currentString = "sand"
            currentString = "og" -> false
        currentString = "sandog" -> false
    currentString = "cats"
        currentString = "and"
            currentString = "og" -> false
        currentString = "andog" -> false

*/

// n -> length of the string
// k -> length of string in dictionary -> max 20 -> O(1)
// m -> number of dictionary items
// Time complexity: O(2^n)
// Space complexity: O(n+m)
// Timeout
func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
    let stringArray = Array(s) // O(n)
    let wordSet = getWordSet(wordDict) // O(m)
    return wordBreakRecursive(stringArray, 0, wordSet)
}

func wordBreakRecursive(_ chars: [Character], _ index: Int, _ wordSet: Set<String>) -> Bool {
    if index >= chars.count {
        return true
    }

    var currentString = ""
    for i in index..<chars.count {
        let char = chars[i]
        currentString = "\(currentString)\(char)"
        guard wordSet.contains(currentString) else {
            continue
        }

        if wordBreakRecursive(chars, i + 1, wordSet) {
            return true
        }
    }

    return false
}

func getWordSet(_ wordDict: [String]) -> Set<String> {
    var wordSet = Set<String>()
    for word in wordDict {
        wordSet.insert(word)
    }

    return wordSet
}


// With cache
// Time complexity: O(n^2)
// Space complexity: O(n^2)
func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
    let stringArray = Array(s) // O(n)
    let wordSet = getWordSet(wordDict) // O(m)
    var cachedWords = [String: Bool]()
    return wordBreakRecursive(stringArray, 0, wordSet, &cachedWords)
}

func wordBreakRecursive(_ chars: [Character], _ index: Int, _ wordSet: Set<String>, _ cachedWords: inout [String: Bool]) -> Bool {
    if let cachedWord = cachedWords[String(chars[index...])] {
        return cachedWord
    }

    if index >= chars.count {
        return true
    }

    var currentString = ""
    for i in index..<chars.count {
        let char = chars[i]
        currentString = "\(currentString)\(char)"
        guard wordSet.contains(currentString) else {
            continue
        }

        if wordBreakRecursive(chars, i + 1, wordSet, &cachedWords) {
            cachedWords[currentString] = true
            return true
        }
    }

    cachedWords[currentString] = false
    return false
}

func getWordSet(_ wordDict: [String]) -> Set<String> {
    var wordSet = Set<String>()
    for word in wordDict {
        wordSet.insert(word)
    }

    return wordSet
}

// With cached indexes
// Time complexity: O(n^2)
// Space complexity: O(n)
func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
    let stringArray = Array(s) // O(n)
    let wordSet = getWordSet(wordDict) // O(m)
    var cachedIndexes = [Int: Bool]()
    return wordBreakRecursive(stringArray, 0, wordSet, &cachedIndexes)
}

func wordBreakRecursive(_ chars: [Character], _ index: Int, _ wordSet: Set<String>, _ cachedIndexes: inout [Int: Bool]) -> Bool {
    if let cachedIndex = cachedIndexes[index] {
        return cachedIndex
    }

    if index >= chars.count {
        return true
    }

    var currentString = ""
    for i in index..<chars.count {
        let char = chars[i]
        currentString = "\(currentString)\(char)"
        guard wordSet.contains(currentString) else {
            continue
        }

        if wordBreakRecursive(chars, i + 1, wordSet, &cachedIndexes) {
            cachedIndexes[index] = true
            return true
        }
    }

    cachedIndexes[index] = false
    return false
}

func getWordSet(_ wordDict: [String]) -> Set<String> {
    var wordSet = Set<String>()
    for word in wordDict {
        wordSet.insert(word)
    }

    return wordSet
}

print(wordBreak("leetcode", ["leet","code"])) // true
print(wordBreak("applepenapple", ["apple","pen"])) // true
print(wordBreak("catsandog", ["cats","dog","sand","and","cat"])) // false