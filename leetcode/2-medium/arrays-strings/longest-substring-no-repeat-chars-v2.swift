// https://leetcode.com/problems/longest-substring-without-repeating-characters/
// Given a string s, find the length of the longest substring without repeating characters.

// Time complexity: O(n^2)
// Space complexity: O(n)
func lengthOfLongestSubstring(_ s: String) -> Int {
    let charArray = Array(s)
    var leftPointer = 0
    var maximumLength = 0
    while leftPointer < charArray.count {
        var charIndexes = [Character: Int]()
        charIndexes[charArray[leftPointer]] = leftPointer

        var rightPointer = leftPointer + 1
        while rightPointer < charArray.count {
            if let currIndex = charIndexes[charArray[rightPointer]] {
                maximumLength = max(maximumLength, rightPointer - leftPointer)
                leftPointer = currIndex
                break
            }

            charIndexes[charArray[rightPointer]] = rightPointer
            rightPointer += 1
        }

        maximumLength = max(maximumLength, rightPointer - leftPointer)

        leftPointer += 1
    }

    return maximumLength
}

print(lengthOfLongestSubstring("aab")) // 2
print(lengthOfLongestSubstring("abcabcbb")) // 3
print(lengthOfLongestSubstring("bbbbb")) // 1
print(lengthOfLongestSubstring("pwwkew")) // 3
