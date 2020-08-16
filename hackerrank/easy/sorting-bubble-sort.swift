//
// Problem: https://www.hackerrank.com/challenges/ctci-bubble-sort/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=sorting
// Big O:
// Time complexity: O(n) + O(n*(n-1)) => O(n2)
// Space complexity: O(n)

// Problem
// Complete the countSwaps function below.
func countSwaps(a: [Int]) -> Void {
    var sortedArray: [Int] = a
    let n = a.count
    var swaps = 0

    for _ in 0..<n {
        for  j in 0..<(n-1) {
            // Swap adjacent elements if they are in decreasing order
            if (sortedArray[j] > sortedArray[j + 1]) {
                let ajValue = sortedArray[j]
                sortedArray[j] = sortedArray[j + 1]
                sortedArray[j + 1] = ajValue
                swaps += 1
            }
        }

    }

    print("Array is sorted in \(swaps) swaps.")
    print("First Element: \(sortedArray[0])")
    print("Last Element: \(sortedArray[n-1])")
}

countSwaps(a: [6, 4, 1])
print("====")
countSwaps(a: [1, 2, 3])
print("====")
countSwaps(a: [3, 2, 1])
