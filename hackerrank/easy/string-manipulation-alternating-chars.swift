//
// Problem: https://www.hackerrank.com/challenges/alternating-characters/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=strings
// Big O:
// Time complexity: O(n) + O(n) = O(n)
// Space complexity: O(n)

// Problem
// Complete the alternatingCharacters function below.
func alternatingCharacters(s: String) -> Int {

    var deletions = 0
    let charArray = Array(s)
    for i in 0..<(charArray.count - 1) {
        let currentChar = charArray[i]
        let nextChar = charArray[i+1]
        if currentChar == nextChar {
            deletions += 1
        }
    }

    return deletions
}

print(alternatingCharacters(s: "AAAA"))
print(alternatingCharacters(s: "BBBBB"))
print(alternatingCharacters(s: "ABABABAB"))
print(alternatingCharacters(s: "BABABA"))
print(alternatingCharacters(s: "AAABBB"))