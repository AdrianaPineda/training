// Problem: https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/879/
// Big O
// Time complexity: O(n)
// Space complexity: O(1)

// ["h","e","l","l","o"]
// ["o","l","l","e","h"]

// ["H","a","n","n","a","h"]
// ["h","a","n","n","a","H"]

// i = 0...n
// i=0, j=(n-1-i)
// i=1, j=(n-1-i)
// i=n/2

// hello (n=5)
// i in 0...(n/2) => 0..<2
// i=0, j=4 => switch
// i=1, j=3

func reverseString(_ s: inout [Character]) {
    let size = s.count
    let upperBound = size / 2

    for i in 0..<upperBound {
        let leftChar = s[i]
        let j = size - 1 - i
        let rightChar = s[j]
        s[i] = rightChar
        s[j] = leftChar
    }
}