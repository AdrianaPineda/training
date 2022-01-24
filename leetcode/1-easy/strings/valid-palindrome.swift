/**
https://leetcode.com/problems/valid-palindrome/

A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing
all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters
include letters and numbers.

Given a string s, return true if it is a palindrome, or false otherwise.
*/

extension Character {
    func isAlphaNumeric() -> Bool {
        if let _ = Int(String(self)) { return true }

        guard let asciiVal = self.asciiValue else { return false }
        guard let aInAscii = Character("a").asciiValue else { return false }
        guard let zInAscii = Character("z").asciiValue else { return false }
        let unicode = Int(asciiVal)
        return (unicode >= Int(aInAscii) && unicode <= Int(zInAscii))
    }
}

// Time complexity: O(n)
// Space complexity: O(n)
func isPalindrome(_ phrase: String) -> Bool {
    let chars = Array(phrase)
    var leftIndex = 0
    var rightIndex = chars.count - 1

    while leftIndex < rightIndex {
        let leftChar = chars[leftIndex].lowercased()
        let rightChar = chars[rightIndex].lowercased()

        guard Character(leftChar).isAlphaNumeric() else {
            leftIndex += 1
            continue
        }
        guard Character(rightChar).isAlphaNumeric() else {
            rightIndex -= 1
            continue
        }
        guard leftChar == rightChar else {  return false }

        leftIndex += 1
        rightIndex -= 1

    }

    return true
}

print(isPalindrome("A man, a plan, a canal: Panama")) // true
print(isPalindrome("race a car")) // false
print(isPalindrome(" ")) // true
print(isPalindrome("0P")) // false