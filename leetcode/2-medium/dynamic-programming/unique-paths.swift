
// Timeout
// Time complexity: O(2^(m+n))
// Space complexity: O(m+n)
class Solution {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        return uniquePathsRecursive(m, n, i: 1, j: 1)
    }

    func uniquePathsRecursive(_ m: Int, _ n: Int, i: Int, j: Int) -> Int {
        if i == m && j == n {
            return 1
        }

        var paths = 0
        if i < m { // goes down
            paths += uniquePathsRecursive(m, n, i: i + 1, j: j)
        }

        if j < n { // goes right
            paths += uniquePathsRecursive(m, n, i: i, j: j + 1)
        }

        return paths
    }

}

// With cache
// Time complexity: O(m*n)
// Space complexity: O(m*n)
class Solution {
    struct Point: Hashable {
        let i: Int
        let j: Int
    }
    
    var cache = [Point: Int]()

    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        return uniquePathsRecursive(m, n, i: 1, j: 1)
    }

    func uniquePathsRecursive(_ m: Int, _ n: Int, i: Int, j: Int) -> Int {
        if i == m && j == n {
            return 1
        }

       if let cachedPaths = cache[Point(i: i, j: j)] {
	        return cachedPaths
       }

        var paths = 0
        if i < m { // goes down
            paths += uniquePathsRecursive(m, n, i: i + 1, j: j)
        }

        if j < n { // goes right
            paths += uniquePathsRecursive(m, n, i: i, j: j + 1)
        }

        cache[Point(i: i, j:j)] = paths
        return paths
    }

}

// Alt
class Solution {
    struct Point: Hashable {
        let i: Int
        let j: Int
    }
    
    var cache = [Point: Int]()

    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        return uniquePathsRecursive(m, n, i: 1, j: 1)
    }

    func uniquePathsRecursive(_ m: Int, _ n: Int, i: Int, j: Int) -> Int {
        if i == m || j == n {
            return 1
        }

       if let cachedPaths = cache[Point(i: i, j: j)] {
	        return cachedPaths
       }

        var paths = 0
       // goes down
        paths += uniquePathsRecursive(m, n, i: i + 1, j: j)

        // goes right
        paths += uniquePathsRecursive(m, n, i: i, j: j + 1)

        cache[Point(i: i, j:j)] = paths
        return paths
    }

}