// https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/881/
// Given a string, find the first non-repeating character in it and return its index. If it doesn't exist, return -1.

// Note: You may assume the string contains only lowercase English letters.

// Time complexity: O(n)
// Space complexity: O(1) (26 letters)
func firstUniqChar(_ s: String) -> Int {
    var charOcurrences = [Character: Int]()

    for char in s {
        guard let charOcurrence = charOcurrences[char] else {
            charOcurrences[char] = 1
            continue
        }

        charOcurrences[char] = charOcurrence + 1
    }

    for (i, char) in s.enumerated() {
        if let charOcurrence = charOcurrences[char], charOcurrence == 1 {
            return i
        }
    }

    return -1
}



// Time complexity: O()
// Space complexity: O()

print(firstUniqChar("leetcode")) // 0
print(firstUniqChar("loveleetcode")) // 2
