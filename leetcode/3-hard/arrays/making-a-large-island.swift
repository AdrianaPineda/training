// https://leetcode.com/problems/making-a-large-island/
/**
You are given an n x n binary matrix grid. You are allowed to change at most one 0 to be 1.
Return the size of the largest island in grid after applying this operation.
An island is a 4-directionally connected group of 1s.
**/

// Accepted
// Time complexity: O(n*m)
// Space complexity: O(n*m)
struct Point: Hashable {
    let row: Int
    let column: Int

    func isValid(rows: Int, cols: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < cols
    }
}

func largestIsland(_ grid: [[Int]]) -> Int {
    let cachedSize = getCachedPoints(grid) // O(n*m)
    return getLargestIsland(grid, cachedSize) // O(n*m)
}

func getLargestIsland(_ grid: [[Int]], _ cachedSize: [Point: (Int, Int)]) -> Int {
    var largestIsland = 0
    var zerosPresent = false
    for (i, rowArr) in grid.enumerated() {
        for (j, val) in rowArr.enumerated() {
            guard val == 0 else { continue }
            zerosPresent = true

            let currIslandSize = getCurrentIslandSize(i, j, cachedSize)
            largestIsland = max(largestIsland, currIslandSize)
        }
    }

    return zerosPresent ? largestIsland : grid.count * grid[0].count
}

func getCurrentIslandSize(_ i: Int, _ j: Int, _ cachedSize: [Point: (Int, Int)]) -> Int {
    var ids = Set<Int>()
    let point = Point(row: i, column: j)
    let neighbors = getPoints(point)
    var currIslandSize = 1
    for neighborPoint in neighbors {
        guard let cachedPoint = cachedSize[neighborPoint] else { continue }
        let id = cachedPoint.1
        if ids.contains(id) { continue }
        currIslandSize += cachedPoint.0
        ids.insert(id)
    }

    return currIslandSize
}

func getCachedPoints(_ grid: [[Int]]) -> [Point: (Int, Int)] {
    var id = 0
    var cachedPoints = [Point: (Int, Int)]()
    var visitedPoints = Set<Point>()

    for (i, rowArr) in grid.enumerated() {
        for (j, val) in rowArr.enumerated() {
            let point = Point(row: i, column: j)
            guard val == 1 && !visitedPoints.contains(point) else { continue }

            id += 1

            let currPoints = getIslandPoints(grid, point, &visitedPoints, id)
            for visitedPoint in currPoints {
                cachedPoints[visitedPoint] = (currPoints.count, id)
            }

        }
    }

    return cachedPoints
}

func getIslandPoints(_ grid: [[Int]], _ point: Point, _ visitedPoints: inout Set<Point>, _ id: Int) -> [Point] {
    var currPoints = [Point]()

    var queue = [Point]()
    queue.append(point)
    while !queue.isEmpty {
        let nextPoint = queue.removeLast()
        if visitedPoints.contains(nextPoint) { continue }

        guard nextPoint.isValid(rows: grid.count, cols: grid[0].count) else { continue }
        guard grid[nextPoint.row][nextPoint.column] == 1 else { continue}

        visitedPoints.insert(nextPoint)
        queue.append(contentsOf: getPoints(nextPoint))
        currPoints.append(nextPoint)
    }

    return currPoints
}

func getPoints(_ nextPoint: Point) -> [Point] {
    return [
        Point(row: nextPoint.row, column: nextPoint.column + 1),
        Point(row: nextPoint.row, column: nextPoint.column - 1),
        Point(row: nextPoint.row + 1, column: nextPoint.column),
        Point(row: nextPoint.row - 1, column: nextPoint.column)]
}

// Time limit
// Time complexity: O(n*m*n*m) upper bound
// Space complexity: O(n*m)
struct Point: Hashable {
    let row: Int
    let column: Int

    func isValid(rows: Int, cols: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < cols
    }
}

func largestIsland(_ grid: [[Int]]) -> Int {
    var largestIsland = 0
    var zerosPresent = false

    for (i, rowArr) in grid.enumerated() {
        for (j, val) in rowArr.enumerated() {
            guard val == 0 else { continue }

            zerosPresent = true
            let point = Point(row: i, column: j)
            let currIslandSize = getIslandSize(point, grid)
            largestIsland = max(largestIsland, currIslandSize)
        }
    }

    return zerosPresent ? largestIsland : grid.count * grid[0].count
}

func getIslandSize(_ point: Point, _ grid: [[Int]]) -> Int {
    var queue = [Point]()
    var visitedPoints = Set<Point>()
    queue.append(contentsOf: getPoints(point))
    while !queue.isEmpty {
        let nextPoint = queue.removeLast()

        if visitedPoints.contains(nextPoint) { continue }
        guard nextPoint.isValid(rows: grid.count, cols: grid[0].count) else { continue }
        guard grid[nextPoint.row][nextPoint.column] == 1 else { continue}
        visitedPoints.insert(nextPoint)

        queue.append(contentsOf: getPoints(nextPoint))
    }

    return visitedPoints.count
}

func getPoints(_ nextPoint: Point) -> [Point] {
    return [
        Point(row: nextPoint.row, column: nextPoint.column + 1),
        Point(row: nextPoint.row, column: nextPoint.column - 1),
        Point(row: nextPoint.row + 1, column: nextPoint.column),
        Point(row: nextPoint.row - 1, column: nextPoint.column)]
}


print(largestIsland([[1,0], [0,1]])) // 3
print(largestIsland([[1,1],[1,0]])) // 4
print(largestIsland([[1,1],[1,1]])) // 4
