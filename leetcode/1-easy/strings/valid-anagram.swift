// https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/882/
// Given two strings s and t , write a function to determine if t is an anagram of s.
// You may assume the string contains only lowercase alphabets.

// Input: s = "anagram", t = "nagaram" => true
// Input: s = "rat", t = "car"         => false

// 2 options
// Check length of the string, different lengths -> false
// 1) sort t, iterate over s at the same time
// 2) loop t and add char ocurrences in hash map, iterate over s and look in the hash map

// Sorting
// Time complexity: O(n*log(n))
// Space complexity: O(n)
func isAnagram(_ s: String, _ t: String) -> Bool {
    let sLength = s.count
    let tLength = t.count

    if sLength != tLength {
        return false
    }

    // Sort t and s
    let sortedT = t.sorted() // O(n*log(n))
    let sortedS = s.sorted() // O(n*log(n))

    // Loop through s and t
    for i in 0..<sLength { // O(n)
        let sChar = sortedS[i]
        let tChar = sortedT[i]

        if sChar != tChar {
            return false
        }
    }

    return true
}

func isAnagram_v2(_ s: String, _ t: String) -> Bool {
    let sLength = s.count
    let tLength = t.count

    if sLength != tLength {
        return false
    }

    // Sort t and s
    let sortedT = t.sorted() // O(n*log(n))
    let sortedS = s.sorted() // O(n*log(n))

    // Compare s and t
    return sortedT.elementsEqual(sortedS)
}

// With hash map
// Time complexity: O(n)
// Space complexity: O(1) -> only alphabet letters ~26
func isAnagram(_ s: String, _ t: String) -> Bool {
    let sLength = s.count
    let tLength = t.count

    if sLength != tLength {
        return false
    }

    var tOcurrences = getCharOcurrences(string: t)

    for char in s {
        guard let ocurrence = tOcurrences[char], ocurrence > 0 else {
            return false
        }

        let newOcurrence = ocurrence - 1
        if newOcurrence >= 0 {
            tOcurrences[char] = newOcurrence
        }
    }

    return true
}

func getCharOcurrences(string: String) -> [Character: Int] {
    var charOcurrences = [Character: Int]()
    for char in string {
        guard let ocurrence = charOcurrences[char] else {
            charOcurrences[char] = 1
            continue
        }

        charOcurrences[char] = ocurrence + 1
    }

    return charOcurrences
}

// Follow up:
// What if the inputs contain unicode characters? How would you adapt your solution to such case?

print(isAnagram("anagram", "nagaram")) // true
print(isAnagram("rat", "car")) // false

