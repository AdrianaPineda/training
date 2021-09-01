// https://leetcode.com/problems/unique-paths-ii/

// Time complexity: O(rows+cols)
// Space complexity: O(m*n + m + n) => O(m*n)
struct Point: Hashable {
    let row: Int
    let col: Int
    func isValid(rows: Int, cols: Int) -> Bool {
        return self.row >= 0 && self.row < rows && self.col >= 0 && self.col < cols
    }

    func isBottomRight(rows: Int, cols: Int) -> Bool {
        return self.row == (rows - 1) && self.col == (cols - 1)
    }
}

func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
    if obstacleGrid.isEmpty || obstacleGrid[0].isEmpty { return 0 }
    var pathsCache = [Point: Int]()
    return getPaths(point: Point(row: 0, col: 0), obstacleGrid, &pathsCache)
}

func getPaths(point: Point, _ grid: [[Int]], _ pathsCache: inout [Point: Int]) -> Int {
    if let cachedPaths = pathsCache[point] { return cachedPaths } // previously visited point

    guard point.isValid(rows: grid.count, cols: grid[0].count) else { return 0 }

    if grid[point.row][point.col] == 1 { return 0 } // obstacle

    if point.isBottomRight(rows: grid.count, cols: grid[0].count) {
        return 1
    }

    let downPaths = getPaths(point: Point(row: point.row + 1, col: point.col), grid, &pathsCache)
    let rightPaths = getPaths(point: Point(row: point.row, col: point.col + 1), grid, &pathsCache)
    let currPaths = downPaths + rightPaths
    pathsCache[point] = currPaths
    return currPaths
}

print(uniquePathsWithObstacles([[0,0,0],[0,0,0],[0,0,0]])) // 6
print(uniquePathsWithObstacles([[0,0,0],[0,1,0],[0,0,0]])) // 2
print(uniquePathsWithObstacles([[0,1],[0,0]])) // 1
