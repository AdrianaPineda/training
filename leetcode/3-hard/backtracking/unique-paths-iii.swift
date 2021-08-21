// https://leetcode.com/problems/unique-paths-iii/
/**
You are given an m x n integer array grid where grid[i][j] could be:

1 representing the starting square. There is exactly one starting square.
2 representing the ending square. There is exactly one ending square.
0 representing empty squares we can walk over.
-1 representing obstacles that we cannot walk over.
Return the number of 4-directional walks from the starting square to the ending square, that walk over every non-obstacle square exactly once.
*/
struct Position: Hashable {
    let posX: Int
    let posY: Int

    func isValid(_ grid: [[Int]]) -> Bool {
        return posX >= 0 && posX < grid.count && posY >= 0 && posY < grid[posX].count && grid[posX][posY] != -1
    }
}

struct GridInfo {
    let emptyCellsCount: Int
    let startCellPos: Position
    let endCellPos: Position
}

// Time complexity: 3^(m*n)*(m*n)
// Space complexity: m*n
func uniquePathsIII(_ grid: [[Int]]) -> Int {
    let gridInfo = getGridInfo(grid)
    let emptyCellsCount = gridInfo.emptyCellsCount

    let startPos = gridInfo.startCellPos
    let endPos = gridInfo.endCellPos
    return findPaths(pos: startPos, endPos: endPos, emptyCellsCount: emptyCellsCount, visitedCells: Set<Position>(), grid: grid)
}

func findPaths(pos: Position, endPos: Position, emptyCellsCount: Int, visitedCells: Set<Position>, grid: [[Int]]) -> Int {
    if visitedCells.contains(pos) {
        return 0
    }

    if endPos.posX == pos.posX && endPos.posY == pos.posY {
        return visitedCells.count == emptyCellsCount ? 1 : 0
    }

    var currVisitedCells = visitedCells
    currVisitedCells.insert(pos)
    var currCount = 0

    let rightPos = Position(posX: pos.posX, posY: pos.posY + 1)
    if rightPos.isValid(grid) {
        currCount += findPaths(pos: rightPos, endPos: endPos, emptyCellsCount: emptyCellsCount, visitedCells: currVisitedCells, grid: grid)
    }

    let leftPos = Position(posX: pos.posX, posY: pos.posY - 1)
    if leftPos.isValid(grid) {
        currCount += findPaths(pos: leftPos, endPos: endPos, emptyCellsCount: emptyCellsCount, visitedCells: currVisitedCells, grid: grid)
    }

    let upPos = Position(posX: pos.posX - 1, posY: pos.posY)
    if upPos.isValid(grid) {
        currCount += findPaths(pos: upPos, endPos: endPos, emptyCellsCount: emptyCellsCount, visitedCells: currVisitedCells, grid: grid)
    }

    let downPos = Position(posX: pos.posX + 1, posY: pos.posY)
    if downPos.isValid(grid) {
        currCount += findPaths(pos: downPos, endPos: endPos, emptyCellsCount: emptyCellsCount, visitedCells: currVisitedCells, grid: grid)
    }

    return currCount
}

func getGridInfo(_ grid: [[Int]]) -> GridInfo {
    var emptyCells = 0
    var startCellPos = Position(posX: 0, posY: 0)
    var endCellPos = Position(posX: 0, posY: 0)
    for x in 0..<grid.count {
        for y in 0..<grid[x].count {
            let cell = grid[x][y]
            if cell == -1 { continue }
            if cell == 1 {
                emptyCells += 1
                startCellPos = Position(posX: x, posY: y)
            }
            if cell == 2 {
                endCellPos = Position(posX: x, posY: y)
            }

            if cell == 0 {
                emptyCells += 1
            }
        }
    }

    return GridInfo(emptyCellsCount: emptyCells, startCellPos: startCellPos, endCellPos: endCellPos)
}

// Alt => backtracking
struct Position: Hashable {
    let posX: Int
    let posY: Int

    func isValid(_ grid: [[Int]]) -> Bool {
        return posX >= 0 && posX < grid.count && posY >= 0 && posY < grid[posX].count && grid[posX][posY] != -1
    }
}

struct GridInfo {
    let emptyCellsCount: Int
    let startCellPos: Position
    let endCellPos: Position
}

func uniquePathsIII(_ grid: [[Int]]) -> Int {
    let gridInfo = getGridInfo(grid)
    let emptyCellsCount = gridInfo.emptyCellsCount

    let startPos = gridInfo.startCellPos
    let endPos = gridInfo.endCellPos
    var grid = grid
    return findPaths(pos: startPos, endPos: endPos, emptyCellsCount: emptyCellsCount, grid: &grid)
}

func findPaths(pos: Position, endPos: Position, emptyCellsCount: Int, grid: inout [[Int]]) -> Int {
    if grid[pos.posX][pos.posY] == -2 {
        return 0
    }

    if endPos.posX == pos.posX && endPos.posY == pos.posY {
        return emptyCellsCount == 0 ? 1 : 0
    }

    grid[pos.posX][pos.posY] = -2
    var currCount = 0

    let rightPos = Position(posX: pos.posX, posY: pos.posY + 1)
    if rightPos.isValid(grid) {
        currCount += findPaths(pos: rightPos, endPos: endPos, emptyCellsCount: emptyCellsCount - 1, grid: &grid)
    }

    let leftPos = Position(posX: pos.posX, posY: pos.posY - 1)
    if leftPos.isValid(grid) {
        currCount += findPaths(pos: leftPos, endPos: endPos, emptyCellsCount: emptyCellsCount - 1, grid: &grid)
    }

    let upPos = Position(posX: pos.posX - 1, posY: pos.posY)
    if upPos.isValid(grid) {
        currCount += findPaths(pos: upPos, endPos: endPos, emptyCellsCount: emptyCellsCount - 1, grid: &grid)
    }

    let downPos = Position(posX: pos.posX + 1, posY: pos.posY)
    if downPos.isValid(grid) {
        currCount += findPaths(pos: downPos, endPos: endPos, emptyCellsCount: emptyCellsCount - 1, grid: &grid)
    }

    grid[pos.posX][pos.posY] = 0

    return currCount
}

func getGridInfo(_ grid: [[Int]]) -> GridInfo {
    var emptyCells = 0
    var startCellPos = Position(posX: 0, posY: 0)
    var endCellPos = Position(posX: 0, posY: 0)
    for x in 0..<grid.count {
        for y in 0..<grid[x].count {
            let cell = grid[x][y]
            if cell == -1 { continue }
            if cell == 1 {
                emptyCells += 1
                startCellPos = Position(posX: x, posY: y)
            }
            if cell == 2 {
                endCellPos = Position(posX: x, posY: y)
            }

            if cell == 0 {
                emptyCells += 1
            }
        }
    }

    return GridInfo(emptyCellsCount: emptyCells, startCellPos: startCellPos, endCellPos: endCellPos)
}

// Alt => with offset
struct Position: Hashable {
    let posX: Int
    let posY: Int

    func isValid(_ grid: [[Int]]) -> Bool {
        return posX >= 0 && posX < grid.count && posY >= 0 && posY < grid[posX].count && grid[posX][posY] != -1
    }
}

struct GridInfo {
    let emptyCellsCount: Int
    let startCellPos: Position
    let endCellPos: Position
}

let rowOffset = [0, 0, 1, -1]
let colOffset = [1, -1, 0, 0]
func uniquePathsIII(_ grid: [[Int]]) -> Int {
    let gridInfo = getGridInfo(grid)
    let emptyCellsCount = gridInfo.emptyCellsCount

    let startPos = gridInfo.startCellPos
    let endPos = gridInfo.endCellPos
    var grid = grid
    return findPaths(pos: startPos, endPos: endPos, emptyCellsCount: emptyCellsCount, grid: &grid)
}

func findPaths(pos: Position, endPos: Position, emptyCellsCount: Int, grid: inout [[Int]]) -> Int {
    if grid[pos.posX][pos.posY] == -2 {
        return 0
    }

    if endPos.posX == pos.posX && endPos.posY == pos.posY {
        return emptyCellsCount == 0 ? 1 : 0
    }

    grid[pos.posX][pos.posY] = -2
    var currCount = 0

    for i in 0..<4 {
        let posX = rowOffset[i]
        let posY = colOffset[i]
        let currPos = Position(posX: pos.posX + posX , posY: pos.posY + posY)
        if currPos.isValid(grid) {
            currCount += findPaths(pos: currPos, endPos: endPos, emptyCellsCount: emptyCellsCount - 1, grid: &grid)
        }
    }

    grid[pos.posX][pos.posY] = 0

    return currCount
}

func getGridInfo(_ grid: [[Int]]) -> GridInfo {
    var emptyCells = 0
    var startCellPos = Position(posX: 0, posY: 0)
    var endCellPos = Position(posX: 0, posY: 0)
    for x in 0..<grid.count {
        for y in 0..<grid[x].count {
            let cell = grid[x][y]
            if cell == -1 { continue }
            if cell == 1 {
                emptyCells += 1
                startCellPos = Position(posX: x, posY: y)
            }
            if cell == 2 {
                endCellPos = Position(posX: x, posY: y)
            }

            if cell == 0 {
                emptyCells += 1
            }
        }
    }

    return GridInfo(emptyCellsCount: emptyCells, startCellPos: startCellPos, endCellPos: endCellPos)
}

print(uniquePathsIII([[1,0,0,0],[0,0,0,0],[0,0,0,2]])) // 4
print(uniquePathsIII([[0,1],[2,0]])) // 0
print(uniquePathsIII([[1,0,0,0],[0,0,0,0],[0,0,2,-1]])) // 2