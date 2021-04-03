// A child is running up a staircase with n steps and can hope either
// 1 step, 2 steps, or 3 steps at a time. Implement a method to count 
// how many  possible ways the child can run up the stairs

//                           1
//            2              3               4
//     3      4     5    4   5    6     5    6    7
//               6  7  8


// Time complexity: O(3^n * n)
// Space complexity: O(n)
func countWays(n: Int) -> Int {
    if (n <= 3) {
        return n
    }

    return countWays(n: n - 1) + countWays(n: n - 2) + countWays(n: n - 3)
}

// Time complexity: O(n) { (n-3)*3 => 3n - 9 => n}
// Space complexity: O(n)
func countWays(n: Int) -> Int {
    var cache = [Int: Int]()
    return countWaysMemo(n: 5, cache: &cache)
}

func countWaysMemo(n: Int, cache: inout [Int: Int]) -> Int {
    if let cachedValue = cache[n] {
        return cachedValue
    }

    if (n <= 3) {
        cache[n] = n
        return n
    }

    let numberOfWays = countWaysMemo(n: n - 1, cache: &cache) + countWaysMemo(n: n - 2, cache: &cache) + countWaysMemo(n: n - 3, cache: &cache)
    cache[n] = numberOfWays
    return numberOfWays
}

countWays(n: 5)
