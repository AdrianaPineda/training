// https://leetcode.com/explore/interview/card/facebook/54/sorting-and-searching-3/272/
// You are a product manager and currently leading a team to develop a new product. 
// Unfortunately, the latest version of your product fails the quality check. Since each 
// version is developed based on the previous version, all the versions after a bad version are also bad.
// Suppose you have n versions [1, 2, ..., n] and you want to find out the first bad one, which causes all the following ones to be bad.
// You are given an API bool isBadVersion(version) which returns whether version is bad. Implement a 
// function to find the first bad version. You should minimize the number of calls to the API.

/**
n = 5
mid = 3
    0 - 2

1 2 3 4 5
  x x x x

  midPoint = 3
  isBad

    prevBadVer    1 - 2
    midPoint = 1
        2 - 2
        midPoint = 2
        prev = 2 1

*/

// Time complexity: O(log(n))
// Space complexity: O(log(n))
func firstBadVersion(_ n: Int) -> Int {
    return firstBadVersionRecursive(start: 1, end: n)
}

func firstBadVersionRecursive(start: Int, end: Int) -> Int {
    if start > end {
        return -1
    }

    let midPoint = (start + end) / 2
    guard isBadVersion(midPoint) else {
        return firstBadVersionRecursive(start: midPoint + 1, end: end)
    }

    let prevBadVersion = firstBadVersionRecursive(start: start, end: midPoint - 1)

    return prevBadVersion == -1 ? midPoint : prevBadVersion
}

// Time complexity: O(log(n))
// Space complexity: O(1)
func firstBadVersion(_ n: Int) -> Int {
    var start = 1
    var end = n

    var result = -1

    while start <= end {
        let midPoint = (start + end) / 2
        guard isBadVersion(midPoint) else {
            start = midPoint + 1
            continue
        }

        result = midPoint
        end = midPoint - 1
    }

    return result
}