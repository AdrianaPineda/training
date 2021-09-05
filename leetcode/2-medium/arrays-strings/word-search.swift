struct Cell: Hashable {
    let row: Int
    let col: Int
}

func exist(_ board: [[Character]], _ word: String) -> Bool {
    let wordChar = Array(word)
    for row in 0..<board.count {
        for col in 0..<board[row].count {
            let cell = Cell(row: row, col: col)
            if findWordRecursive(board, cell, wordChar, 0) {
                return true
            }
        }
    }

    return false

}

let directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]

func findWordRecursive(_ board: [[Character]], _ cell: Cell, _ word: [Character], _ wordIndex: Int, _ visitedCells: Set<Cell> = Set<Cell>()) -> Bool {
    if wordIndex >= word.count { return true }

    if visitedCells.contains(cell) { return false }

    guard cell.row >= 0 && cell.row < board.count && cell.col >= 0 && cell.col < board[cell.row].count else { return false }

    let currChar = board[cell.row][cell.col]
    guard currChar == word[wordIndex] else { return false }

    var currVisitedCells = visitedCells
    currVisitedCells.insert(cell)

    for direction in directions {
        let nextRow = cell.row + direction[0]
        let nextCol = cell.col + direction[1]

        if findWordRecursive(board, Cell(row: nextRow, col: nextCol), word, wordIndex + 1, currVisitedCells) {
            return true
        }
    }

    return false
}

// Alt: backtracking
// Time complexity: O(r*c*min((3^(w)*w)), 3^(r*c)*r*c)
// Space complexity: O(r*c + w)
struct Cell: Hashable {
    let row: Int
    let col: Int

    func isValid(grid: [[Character]]) -> Bool {
        return row >= 0 && row < grid.count && col >= 0 && col < grid[row].count
    }
}

func exist(_ board: [[Character]], _ word: String) -> Bool {
    let wordChar = Array(word)
    var visitedCells = Set<Cell>()
    for row in 0..<board.count {
        for col in 0..<board[row].count {
            let cell = Cell(row: row, col: col)
            if findWordRecursive(board, cell, wordChar, 0, &visitedCells) {
                return true
            }
        }
    }

    return false

}

let directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]

func findWordRecursive(_ board: [[Character]], _ cell: Cell, _ word: [Character], _ wordIndex: Int, _ visitedCells: inout Set<Cell>) -> Bool {
    if wordIndex >= word.count { return true }

    if visitedCells.contains(cell) { return false }

    guard cell.isValid(grid: board) else { return false }

    let currChar = board[cell.row][cell.col]
    guard currChar == word[wordIndex] else { return false }

    visitedCells.insert(cell)

    for direction in directions {
        let nextRow = cell.row + direction[0]
        let nextCol = cell.col + direction[1]

        if findWordRecursive(board, Cell(row: nextRow, col: nextCol), word, wordIndex + 1, &visitedCells) {
            return true
        }
    }

    visitedCells.remove(cell)

    return false
}

print(exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "SEE")) // true
print(exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "SEEN")) // false
print(exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCCED")) // true
print(exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCB")) // false
