/**
You've devised a simple encryption method for alphabetic strings that
 shuffles the characters in such a way that the resulting string is 
 hard to quickly read, but is easy to convert back into the original string.
When you encrypt a string S, you start with an initially-empty resulting 
string R and append characters to it as follows:
Append the middle character of S (if S has even length, then we define
 the middle character as the left-most of the two central characters)
Append the encrypted version of the substring of S that's to the left 
of the middle character (if non-empty)
Append the encrypted version of the substring of S that's to the right
 of the middle character (if non-empty)
For example, to encrypt the string "abc", we first take "b", and then 
append the encrypted version of "a" (which is just "a") and the encrypted
 version of "c" (which is just "c") to get "bac".
If we encrypt "abcxcba" we'll get "xbacbca". That is, we take "x" and 
then append the encrypted version "abc" and then append the encrypted 
version of "cba".

Input
    S contains only lower-case alphabetic characters
    1 <= |S| <= 10,000

Output
    Return string R, the encrypted version of S.

Example 1
    S = "abc"
    R = "bac"

Example 2
    S = "abcd"
    R = "bacd"

Example 3
    S = "abcxcba"
    R = "xbacbca"

Example 4
    S = "facebook"
    R = "eafcobok"

string => 
    middleCharacter + encrypted(s[0..<mid]) + encrypted(s[mid+1...])

base case => single char

0 1 2 3 4 5 6 7
f a c e b o u k

e a f c o b u k

startIndex: 0
endIndex: 7
midPoint = 3
midChar = e

  leftSide
    starIndex: 0
    endIndex: 2
    midPoint = 1
    midChar = a

    lefSide
      starIndex: 0
      endIndex: 0
      => f
    rightSide
      starIndex: 2
      endIndex: 2
      => c
    ==> afc
  rightSide
    starIndex: 4
    endIndex: 7
    midPoint = 5
    midChar = o

    lefSide
      starIndex: 4
      endIndex: 4
      => b
    rightSide
      starIndex: 6
      endIndex: 7
      midPoint: 6
      midChar = u

      lefSide
        startIndex: 6
        endIndex: 5
        => ""
      rightSide
        startIndex: 7
        endIndex: 7
        => k
      ==> uk
  ==> obuk

==> eafcobuk
      
*/

// Add any helper functions you may need here
func findEncryptedWordRecursive(chars: [Character], startIndex: Int, endIndex: Int) -> String {
  if startIndex > endIndex {
    return ""
  }
  
  if startIndex == endIndex {
    return "\(chars[startIndex])"
  }
  
  let midPoint = (startIndex + endIndex) / 2
  let midChar = chars[midPoint]
  let leftSide = findEncryptedWordRecursive(chars: chars, startIndex: startIndex, endIndex: midPoint - 1)
  let rightSide = findEncryptedWordRecursive(chars: chars, startIndex: midPoint + 1, endIndex: endIndex)
  return "\(midChar)\(leftSide)\(rightSide)"
  
}

// Time complexity: O(n)
// Space complexity: O(log(n))
func findEncryptedWord(s: String) -> String {
  // Write your code here
  let chars = Array(s) // O(n)
  return findEncryptedWordRecursive(chars: chars, startIndex: 0, endIndex: chars.count - 1)
}

print(findEncryptedWord(s: "abc")) // bac
print(findEncryptedWord(s: "abcd")) // bacd
print(findEncryptedWord(s: "abcxcba")) // xbacbca
print(findEncryptedWord(s: "facebouk")) // eafcobuk
print(findEncryptedWord(s: "facebuok")) // eafcubok
