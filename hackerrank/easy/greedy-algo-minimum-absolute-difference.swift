//
// Problem: https://www.hackerrank.com/challenges/minimum-absolute-difference-in-an-array/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=greedy-algorithms
// Big O:
// Time complexity: O(n)
// Space complexity: O(n)

// Problem
// Complete the minimumAbsoluteDifference function below.
func minimumAbsoluteDifference(arr: [Int]) -> Int {
    let sortedArray = arr.sorted()
    var minimumDifference = Int.max
    for i in 0..<(sortedArray.count - 1) {
        let difference = abs(sortedArray[i] - sortedArray[i+1])
        if difference < minimumDifference {
            minimumDifference = difference
        }
    }

    return minimumDifference
}

// The following solution yields timeout
// Time complexity: O(n^2/2) => O(n^2)
// Space complexity: O(1)
func minimumAbsoluteDifference_v1(arr: [Int]) -> Int {

    var minimumDifference = Int.max

    for i in 0..<arr.count {
        for j in (i+1)..<arr.count {
            let difference = abs(arr[i] - arr [j])
            if difference < minimumDifference {
                minimumDifference = difference
            }
        }
    }

    return minimumDifference
}

print(minimumAbsoluteDifference(arr: [3, -7, 0]))
print(minimumAbsoluteDifference(arr: [-59, -36, -13, 1, -53, -92, -2, -96, -54, 75]))
print(minimumAbsoluteDifference(arr: [1, -3, 71, 68, 17]))
