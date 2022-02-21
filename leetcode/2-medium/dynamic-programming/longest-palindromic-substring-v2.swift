// https://leetcode.com/problems/longest-palindromic-substring/

// Option 2
// Time complexity: O(n^2), being n the number of chars in the string
// Space complexity: O(n), for the char array
func longestPalindrome(_ s: String) -> String {
    let chars = Array(s)
    var longest = Int.min
    var leftIndex = 0
    var rightIndex = 0

    for i in 0..<chars.count {
        let oddSize = getPalindrome(chars, i, i)
        let evenSize = getPalindrome(chars, i, i + 1)
        let currSize = max(oddSize, evenSize)
        if (currSize > longest) {
            longest = currSize
            leftIndex = i - (currSize - 1) / 2
            rightIndex = i + currSize / 2
        }
    }

    return String(chars[leftIndex...rightIndex])
}

func getPalindrome(_ chars: [Character], _ left: Int, _ right: Int) -> Int {
    var currLeft = left
    var currRight = right

    while currLeft >= 0 && currRight < chars.count {
        let leftChar = chars[currLeft]
        let rightChar = chars[currRight]
        guard leftChar == rightChar else {
            break
        }

        currLeft -= 1
        currRight += 1
    }

    return currRight - currLeft - 1
}

// Option 1
// loop through each char, and each pair of equal chars and expand to the side
// Time complexity: O(n^2), being n the number of chars in the string
// Space complexity: O(n), for the char array and the palindromes 
func longestPalindrome(_ s: String) -> String {
    let chars = Array(s)
    var longest = ""
    for i in 0..<chars.count {
        // Odd palindrome
        let currOddPalindrome = getPalindrome(chars, i, i)
        longest = currOddPalindrome.count > longest.count ? currOddPalindrome : longest

        // Even palindrome
        let currentEventPalindrome = getPalindrome(chars, i, i + 1)
        longest = currentEventPalindrome.count > longest.count ? currentEventPalindrome : longest
    }

    return longest
}

func getPalindrome(_ chars: [Character], _ left: Int, _ right: Int) -> String {
    var currLeft = left
    var currRight = right

    var palindrome = ""

    while currLeft >= 0 && currRight < chars.count {
        let leftChar = chars[currLeft]
        let rightChar = chars[currRight]
        guard leftChar == rightChar else { return palindrome }

        // palindrome = String(chars[currLeft...currRight]) => timeout
        if currLeft != currRight {
            palindrome = "\(leftChar)\(palindrome)\(rightChar)"
        } else {
            palindrome = "\(leftChar)\(palindrome)"
        }

        currLeft -= 1
        currRight += 1
    }

    return palindrome
}

print(longestPalindrome("abababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababa"))
print(longestPalindrome("babad")) // "bab"
print(longestPalindrome("cbbd")) // "bb"