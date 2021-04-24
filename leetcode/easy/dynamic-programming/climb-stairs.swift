// https://leetcode.com/explore/interview/card/top-interview-questions-easy/97/dynamic-programming/569/
// You are climbing a staircase. It takes n steps to reach the top.
// Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

// Time complexity: O(n)
// Space complexity: O(n)

func climbStairs(_ n: Int) -> Int {
    var cache = [Int: Int]()
    
    return climbStairsWithMemo(n: n, cache: &cache)
}

func climbStairsWithMemo(n: Int, cache: inout [Int: Int]) -> Int {
    if let cachedValue = cache[n] {
        return cachedValue
    }
    
    if n <= 2 {
        return n
    }
    
    let ways = climbStairsWithMemo(n: n - 1, cache: &cache) + climbStairsWithMemo(n: n - 2, cache: &cache)
    cache[n] = ways
    return ways
}

climbStairs(n: 5)