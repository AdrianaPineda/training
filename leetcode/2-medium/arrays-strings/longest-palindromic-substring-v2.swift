// https://leetcode.com/problems/longest-palindromic-substring/
/**
Given a string s, return the longest palindromic substring in s.

Example 1:
    Input: s = "babad"
    Output: "bab"
    Note: "aba" is also a valid answer.

Example 2:
    Input: s = "cbbd"
    Output: "bb"

Example 3:
    Input: s = "a"
    Output: "a"

Example 4:
    Input: s = "ac"
    Output: "a"
*/

// Time complexity: O(n^2)
// Space complexity: O(1)
func longestPalindrome(_ s: String) -> String {
    let chars = Array(s)
    var longestString = ""
    for i in 0..<chars.count {
        let currLongestOdd = getLongestPalindromeOdd(chars, index: i)

        if currLongestOdd.count > longestString.count {
            longestString = currLongestOdd
        }

        let currLongestEven = getLongestPalindromeEven(chars, index: i)
        if currLongestEven.count > longestString.count {
            longestString = currLongestEven
        }
    }

    return longestString
}

func getLongestPalindromeOdd(_ chars: [Character], index: Int) -> String {
    return getLongest(chars, rIndex: index, lIndex: index)
}

func getLongestPalindromeEven(_ chars: [Character], index: Int) -> String {
    return getLongest(chars, rIndex: index + 1, lIndex: index)
}

func getLongest(_ chars: [Character], rIndex: Int, lIndex: Int) -> String {
    var longest = ""
    var leftIndex = lIndex
    var rightIndex = rIndex

    while rightIndex < chars.count && leftIndex >= 0 {
        let rightChar = chars[rightIndex]
        let leftChar = chars[leftIndex]

        guard leftChar == rightChar else {
            break
        }

        if leftIndex == rightIndex {
            longest = "\(leftChar)\(longest)"
        } else {
            longest = "\(leftChar)\(longest)\(rightChar)"
        }

        leftIndex -= 1
        rightIndex += 1
    }

    return longest
}

print(longestPalindrome("bb")) // bb
print(longestPalindrome("ac")) // a
print(longestPalindrome("babad")) // bab
print(longestPalindrome("dbabdad")) // dbabd
print(longestPalindrome("cbbd")) // bb
print(longestPalindrome("cbbc")) // cbbc