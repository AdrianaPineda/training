// https://leetcode.com/problems/number-of-islands/
/**
Given an m x n 2D binary grid grid which represents a map of
'1's (land) and '0's (water), return the number of islands.

An island is surrounded by water and is formed by connecting
adjacent lands horizontally or vertically. You may assume all
four edges of the grid are all surrounded by water.
*/

class Solution {
    func numIslands(_ grid: [[Character]]) -> Int {
        var islands = 0
        var mutableGrid = grid
        for i in 0..<mutableGrid.count {
            for j in 0..<mutableGrid[i].count {
                let currentPoint = mutableGrid[i][j]
                guard currentPoint == "1" else { continue }
                // markIsland(i: i, j: j, grid: &mutableGrid)
                markIslandRecursive(point: Point(x: i, y: j), grid: &mutableGrid)
                islands += 1
            }
        }

        return islands
    }

    struct Point {
        let x: Int
        let y: Int

        func isValid(rows: Int, cols: Int) -> Bool {
            return x >= 0 && x < rows && y >= 0 && y < cols
        }
    }

    // Alt
   func markIsland(i: Int, j: Int, grid: inout [[Character]]) {
       var nextPoints = [Point]()
       nextPoints.append(Point(x: i, y: j))

       while !nextPoints.isEmpty {
           let nextPoint = nextPoints.removeLast()
           guard nextPoint.isValid(rows: grid.count, cols: grid[i].count), grid[nextPoint.x][nextPoint.y] == "1" else {
               continue
           }

           grid[nextPoint.x][nextPoint.y] = "0"
           nextPoints.append(Point(x: nextPoint.x, y: nextPoint.y + 1))
           nextPoints.append(Point(x: nextPoint.x + 1, y: nextPoint.y))
           nextPoints.append(Point(x: nextPoint.x, y: nextPoint.y - 1))
           nextPoints.append(Point(x: nextPoint.x - 1, y: nextPoint.y))
       }
   }

    func markIslandRecursive(point: Point, grid: inout [[Character]]) {
        guard point.isValid(rows: grid.count, cols: grid[0].count) else { return }
        guard grid[point.x][point.y] == "1" else { return }

        grid[point.x][point.y] = "0"
        markIslandRecursive(point: Point(x: point.x, y: point.y + 1), grid: &grid)
        markIslandRecursive(point: Point(x: point.x + 1, y: point.y), grid: &grid)
        markIslandRecursive(point: Point(x: point.x, y: point.y - 1), grid: &grid)
        markIslandRecursive(point: Point(x: point.x - 1, y: point.y), grid: &grid)
    }
}

//let grid: [[Character]] = [
//    ["1","1","1","1","0"],
//    ["1","1","0","1","0"],
//    ["1","1","0","0","0"],
//    ["0","0","0","0","0"]
//  ]

let grid: [[Character]] = [
  ["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
]
print(Solution().numIslands(grid))
