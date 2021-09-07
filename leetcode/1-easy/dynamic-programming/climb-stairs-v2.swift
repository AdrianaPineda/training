// https://leetcode.com/problems/climbing-stairs/submissions/

// Time complexity: O(n) with memoization, O(2^n) with no memoization
// Space complexity: O(n)
var cachedClimbs = [Int: Int]()
func climbStairs(_ n: Int) -> Int {
    if let cachedClimb = cachedClimbs[n] { return cachedClimb }

    if n == 0 { return 1 }
    if n < 0 { return 0 }

    let result = climbStairs(n - 1) + climbStairs (n - 2)
    cachedClimbs[n] = result
    return result
}

// Time complexity: O(n)
// Space complexity: O(n)
func climbStairs(_ n: Int) -> Int {
    var climbs = [Int: Int]()
    climbs[1] = 1
    climbs[2] = 2

    for i in stride(from: 3, to: n + 1, by: 1) {
        climbs[i] = (climbs[i - 1] ?? 0) + (climbs[i - 2] ?? 0)
    }

    return climbs[n] ?? 0
}

// Time complexity: O(n)
// Space complexity: O(1)
func climbStairs(_ n: Int) -> Int {
    if n == 1 { return 1 }
    var twoStepPrevious = 1
    var oneStepPrevious = 2

    for _ in stride(from: 3, to: n + 1, by: 1) {
        let currStep = twoStepPrevious + oneStepPrevious
        twoStepPrevious = oneStepPrevious
        oneStepPrevious = currStep
    }

    return oneStepPrevious
}
