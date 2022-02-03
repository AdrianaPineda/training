// https://leetcode.com/problems/longest-substring-without-repeating-characters/
// Given a string s, find the length of the longest substring without repeating characters.

// Time complexity: O(n)
// Space complexity: O(n)
func lengthOfLongestSubstring(_ s: String) -> Int {
    let charArray = Array(s)
    var charsIndexes = [Character: Int]()
    var maxLength = 0

    var i = 0
    for (j, char) in charArray.enumerated() {
        if let charIndex = charsIndexes[char] {
            i = max(i, charIndex + 1)
        }

        maxLength = max(maxLength, j - i + 1)
        charsIndexes[char] = j
    }

    return maxLength
}

// Time complexity: O(n)
// Space complexity: O(n)
func lengthOfLongestSubstring(_ s: String) -> Int {
    let charArray = Array(s)
    var charsCount = [Character: Int]()
    var leftPointer = 0
    var rightPointer = 0
    var maxLength = 0

    while rightPointer < charArray.count {

        let charAtRight = charArray[rightPointer]
        charsCount[charAtRight] = (charsCount[charAtRight] ?? 0) + 1

        while let currCount = charsCount[charAtRight], currCount > 1 {
            let charAtLeft = charArray[leftPointer]
            charsCount[charAtLeft] = (charsCount[charAtLeft] ?? 0) - 1
            leftPointer += 1
        }

        maxLength = max(maxLength, rightPointer - leftPointer + 1)
        rightPointer += 1
    }

    return maxLength
}

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
