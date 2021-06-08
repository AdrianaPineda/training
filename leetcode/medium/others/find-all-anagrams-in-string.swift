// https://leetcode.com/explore/interview/card/facebook/57/others-3/3040/
// Given two strings s and p, return an array of all the start indices
// of p's anagrams in s. You may return the answer in any order.

// Input: s = "cbaebabacd", p = "abc"
// Output: [0,6]

// Input: s = "abab", p = "ab"
// Output: [0,1,2]

// Timeout
// Time complexity: O(nxm), n size of s, m size of p
// Space complexity: O(max(n, n))
func findAnagrams(_ s: String, _ p: String) -> [Int] {
    var indices = [Int]()
    guard s.count >= p.count else {
        return indices
    }

    let pCharOcurrences = getCharOcurrences(p)
    let sCharArray = Array(s)

    let lastIndex = s.count - p.count
    var i = 0
    while i <= lastIndex {
        var currCharOcurrences = pCharOcurrences
        var isAnagramPresent = true

        for j in i..<(i + p.count) {
            let char = sCharArray[j]
            guard let charOcurrence = currCharOcurrences[char] else {
                isAnagramPresent = false
                i = j
                break
            }

            guard charOcurrence > 0 else {
                isAnagramPresent = false
                break
            }

            currCharOcurrences[char] = charOcurrence - 1
        }

        if isAnagramPresent {
            indices.append(i)
        }

        i += 1
    }

    return indices
}

func getCharOcurrences(_ p: String) -> [Character: Int] {
    var charOcurrences = [Character: Int]()

    for char in p {
        guard let charOcurrence = charOcurrences[char] else {
            charOcurrences[char] = 1
            continue
        }

        charOcurrences[char] = charOcurrence + 1
    }

    return charOcurrences
}

// Alt
func findAnagrams(_ s: String, _ p: String) -> [Int] {
    var indices = [Int]()
    guard s.count >= p.count else {
        return indices
    }

    let pCharOcurrences = getCharOcurrences(p)
    var sCharOcurrences = [Character: Int]()
    let sCharArray = Array(s)

    var i = 0
    while i < s.count {
        let char = sCharArray[i]

        if let charOcurrence = sCharOcurrences[char] {
            sCharOcurrences[char] = charOcurrence + 1
        } else {
            sCharOcurrences[char] = 1
        }

        if i >= p.count {
            let prevChar = sCharArray[i - p.count]
            if let prevCharOccurrence = sCharOcurrences[prevChar], prevCharOccurrence > 1 {
                sCharOcurrences[prevChar] = prevCharOccurrence - 1
            } else {
                sCharOcurrences[prevChar] = 0
            }
        }

        if (i + 1) >= p.count {
            let isAnagramPresent = compareDicts(sCharOcurrences, pCharOcurrences)
            if isAnagramPresent {
                indices.append(i - p.count + 1)
            }
        }

        i += 1
    }

    return indices
}

func compareDicts(_ dictA: [Character: Int], _ dictB: [Character: Int]) -> Bool {

    for (keyB, valueB) in dictB {
        let valueA = dictA[keyB] ?? -1
        if valueA != valueB {
            return false
        }
    }

    return true
}

func getCharOcurrences(_ p: String) -> [Character: Int] {
    var charOcurrences = [Character: Int]()

    for char in p {
        guard let charOcurrence = charOcurrences[char] else {
            charOcurrences[char] = 1
            continue
        }

        charOcurrences[char] = charOcurrence + 1
    }

    return charOcurrences
}

print(findAnagrams("cbaebabacd", "abc")) // [0, 6]
