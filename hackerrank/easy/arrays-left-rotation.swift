//
// Problem: https://www.hackerrank.com/challenges/ctci-array-left-rotation/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays
// Big O:
// Time complexity: O(n) where n is the array size
// Space complexity: O(n)

// Complete the rotLeft function below.
func rotLeft(a: [Int], d: Int) -> [Int] {

    let digits = a.count
    if d % digits == 0 {
        return a
    }

    var rotatedArray = a
    for i in 0..<digits {
        let digitIndex = (i + d) % digits
        rotatedArray[i] = a[digitIndex]
    }

    return rotatedArray

}
