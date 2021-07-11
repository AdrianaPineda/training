/**
Given two strings s and t of length N, find the maximum number of possible 
matching pairs in strings s and t after swapping exactly two characters within s.
A swap is switching s[i] and s[j], where s[i] and s[j] denotes the character 
that is present at the ith and jth index of s, respectively. The matching pairs 
of the two strings are defined as the number of indices for which s[i] and t[i] 
are equal.

Note: This means you must swap two characters at different indices.

Signature
    int matchingPairs(String s, String t)

Input
    s and t are strings of length N
    N is between 2 and 1,000,000

Output
    Return an integer denoting the maximum number of matching pairs

Example 1
    s = "abcd"
    t = "adcb"
    output = 4
    Explanation:
    Using 0-based indexing, and with i = 1 and j = 3, s[1] and s[3] can be swapped, 
    making it  "adcb".
    Therefore, the number of matching pairs of s and t will be 4.

Example 2
    s = "mno"
    t = "mno"
    output = 1
    Explanation:
    Two indices have to be swapped, regardless of which two it is, only one letter 
    will remain the same. If i = 0 and j=1, s[0] and s[1] are swapped, making s = "nmo", which shares only "o" with t.
*/

// Time complexity: O(n)
// Space complexity: O(n)

func getNoMatchStrings(sChars: [Character], tChars: [Character]) -> ([Character], [Character], Int, Bool) {
  var ocurrences = Set<Character>()
  var noMatchS = [Character]()
  var noMatchT = [Character]()
  var matchingOriginal = 0
  var duplicates = false
  for i in 0..<sChars.count {
    let charInS = sChars[i]
    let charInT = tChars[i]
    
    if charInS == charInT {
      matchingOriginal += 1
      
      if ocurrences.contains(charInS) {
        duplicates = true
      } else {
        ocurrences.insert(charInS)
      }
      
      continue
    }
    
    noMatchS.append(charInS)
    noMatchT.append(charInT)
  }
  
  return (noMatchS, noMatchT, matchingOriginal, duplicates)
}

func exchangeChars(i: Int, charToFind: Character, noMatchT: inout [Character]) -> Bool {
  for k in (i + 1)..<noMatchT.count {
      let nextChar = noMatchT[k]
      guard nextChar == charToFind else { continue }
  
      noMatchT[k] = noMatchT[i]
      noMatchT[i] = nextChar
      
      return true
   }
  return false
}


func matchingPairs(s: String, t: String) -> Int {
  // Write your code here
  let sChars = Array(s)
  let tChars = Array(t)

  var matching = 0
  var hasExchanged = false
  
  var (noMatchS, noMatchT, matchingOriginal, duplicates) = getNoMatchStrings(sChars: sChars, tChars: tChars)
  for i in 0..<noMatchS.count {
    let charInS = noMatchS[i]
    let charInT = noMatchT[i]
    
    if charInS == charInT {
      matching += 1
      continue
    }
    
    if hasExchanged {
      continue
    }
    
    let exchanged = exchangeChars(i: i, charToFind: charInS, noMatchT: &noMatchT)
    if exchanged {
      matching += 1
      hasExchanged = true
    }
  }
  
  if !hasExchanged && !duplicates {
    matching -= 2
  }
  
  return matching + matchingOriginal
    
}

print(matchingPairs(s: "abcd", t: "adcb")) // 4
print(matchingPairs(s: "abcde", t: "adcbe")) // 5
print(matchingPairs(s: "mno", t: "mno")) // 1
print(matchingPairs(s: "aba", t: "aba")) // 3
print(matchingPairs(s: "aab", t: "aab")) // 3
print(matchingPairs(s: "abcd", t: "abcd")) // 2
print(matchingPairs(s: "aabbcc", t: "cabbca")) // 6
