//
// Problem: https://www.hackerrank.com/challenges/two-strings/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dictionaries-hashmaps
// Big O:
// Time complexity: O(s1+s2) = O(max(s1, s2))
// Space complexity: O(s1)

// Problem
// Complete the twoStrings function below.
func twoStrings(s1: String, s2: String) -> String {

    var charDict1: [Character: Bool] = [:]
    for char1 in s1 {
        charDict1[char1] = true
    }

    for char2 in s2 {
        if let _ = charDict1[char2] {
            return "YES"
        }
    }

    return "NO"

}

print(twoStrings(s1: "hello", s2: "world"))
print(twoStrings(s1: "hi", s2: "world"))
