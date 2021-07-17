/**
You are given two strings s and t. You can select any substring of string s and rearrange
 the characters of the selected substring. Determine the minimum length of the substring 
 of s such that string t is a substring of the selected substring.
Signature
int minLengthSubstring(String s, String t)
Input
s and t are non-empty strings that contain less than 1,000,000 characters each
Output
Return the minimum length of the substring of s. If it is not possible, return -1
Example
s = "dcbefebce"
t = "fd"
output = 5
Explanation:
Substring "dcbef" can be rearranged to "cfdeb", "cefdb", and so on. String t is a substring 
of "cfdeb". Thus, the minimum length required is 5.
*/

// Time complexity: O(m+n), m the number of chars in t and n the number of chars in s
// Space complexity: O(n)
extension String {
    func findChar(char: Character, index: Int, sCharArray: [Character], charOcurrences: inout [Character: Int]) -> Int {
      for i in index..<sCharArray.count {
          let sChar = sCharArray[i]
          if sChar == char {
            return i + 1
          }
          
          guard let ocurrence = charOcurrences[char] else {
            charOcurrences[sChar] = 1
            continue
          } 
          charOcurrences[sChar] = ocurrence + 1
      }
      return -1
    }

    func minLengthOfRearrangedSubstring(containing substring: String) -> Int {
      var substringIndex = 0
      var charOcurrences = [Character: Int]()
      let sCharArray = Array(self)
      
      for char in substring {
         if let ocurrence = charOcurrences[char], ocurrence > 0 {
           charOcurrences[char] = ocurrence - 1
           continue
         }
        
        let newIndex = findChar(char: char, index: substringIndex, sCharArray: sCharArray, charOcurrences: &charOcurrences)
        guard newIndex >= 0 else { return -1 }
        substringIndex = newIndex
      }
      
      return substringIndex
    }
}

extension String {
    func minLengthOfRearrangedSubstring(containing substring: String) -> Int {
      var substringIndex = 0
      var charOcurrences = [Character: Int]()
      let sCharArray = Array(self)
      
      for char in substring {
         if let ocurrence = charOcurrences[char], ocurrence > 0 {
           charOcurrences[char] = ocurrence - 1
           continue
         }
        
        var foundChar = false
        for i in substringIndex..<sCharArray.count {
          let sChar = sCharArray[i]
          if sChar == char {
            substringIndex = i + 1
            foundChar = true
            break
          }
          
          guard let ocurrence = charOcurrences[char] else {
            charOcurrences[sChar] = 1
            continue
          } 
          charOcurrences[sChar] = ocurrence + 1
        }
        
        if !foundChar {
          return -1
        }
      }
      
      return substringIndex
    }
}