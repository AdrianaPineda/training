// Imagine a robot sitting on the upper left corner of grid with r rows and c columns.
// The robot can only move in two directions, right and down, but certain cells are "off limits" such that
// the robot cannot step on them. Design an algorithm to find a path for the robot from the top left to
// the bottom right.

struct Cell {
    let row: Int
    let column: Int
}

extension Cell: Hashable {
    
}

// Printing results
// Time complexity: O(r*c)
// Space complexity: O(r*c)
func findPathInit(grid: [[Int]]) -> Bool {
    var cache = [Cell: Bool]()
    let startCell = Cell(row: 0, column: 0)
    let endCell = Cell(row: grid.count - 1, column: grid[0].count - 1)
    return findPath(grid: grid, currentCell: startCell, endCell: endCell, cache: &cache)
}

func findPath(grid: [[Int]], currentCell: Cell, endCell: Cell, cache: inout [Cell: Bool]) -> Bool {
    if let cachedValue = cache[currentCell] {
        return cachedValue
    }

    let isCellOutOfBounds = currentCell.row >= grid.count || currentCell.column >= grid[0].count
    if isCellOutOfBounds || grid[currentCell.row][currentCell.column] == 0 {
        return false
    }

    let isAtFinishCell = currentCell.row == endCell.row && currentCell.column == endCell.column
    let cellRight = Cell(row: currentCell.row, column: currentCell.column + 1)
    let cellDown = Cell(row: currentCell.row + 1, column: currentCell.column)
    
    if isAtFinishCell
        || findPath(grid: grid, currentCell: cellRight, endCell: endCell, cache: &cache)
        || findPath(grid: grid, currentCell: cellDown, endCell: endCell, cache: &cache) {
        print("\(currentCell.row) - \(currentCell.column)")
        cache[currentCell] = true
        return true
    }
    
    return false
}

// Returning points
// Time complexity: O(r*c)
// Space complexity: O(r*c)
func findPathInit(grid: [[Int]]) {
    var cache = [Cell: Bool]()
    let startCell = Cell(row: 0, column: 0)
    let endCell = Cell(row: grid.count - 1, column: grid[0].count - 1)
    var path = [Cell]()
    findPath(grid, endCell, currentCell: startCell, cache: &cache, path: &path)

    path.forEach() { print("\($0.row) - \($0.column)") }
}

func findPath(_ grid: [[Int]], _ endCell: Cell, currentCell: Cell, cache: inout [Cell: Bool], path: inout [Cell]) -> Bool {
    if let cachedValue = cache[currentCell] {
        return cachedValue
    }

    let isCellOutOfBounds = currentCell.row >= grid.count || currentCell.column >= grid[0].count
    if isCellOutOfBounds || grid[currentCell.row][currentCell.column] == 0 {
        return false
    }

    let isAtFinishCell = currentCell.row == endCell.row && currentCell.column == endCell.column
    let cellRight = Cell(row: currentCell.row, column: currentCell.column + 1)
    let cellDown = Cell(row: currentCell.row + 1, column: currentCell.column)
    
    if isAtFinishCell
        || findPath(grid, endCell, currentCell: cellRight, cache: &cache, path: &path)
        || findPath(grid, endCell, currentCell: cellDown, cache: &cache, path: &path) {
        cache[currentCell] = true
        path.append(currentCell)
        return true
    }
    
    return false
}

let grid = [[1, 1, 0, 1, 1], [1, 1, 1, 1, 0], [1, 1, 0, 1, 1], [0, 0, 1, 1, 1], [0, 1, 1, 1, 1]]
findPathInit(grid: grid)