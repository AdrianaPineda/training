// https://leetcode.com/problems/n-queens/

// Time complexity: O(n! * n^2)
// Space complexity: O(n^2)
func solveNQueens(_ n: Int) -> [[String]] {
    var result = [[String]]()
    let grid = buildInitialGrid(n) // O(n*n)
    findSolutions(grid: grid, row: 0, result: &result)
    return result
}

func buildInitialGrid(_ n: Int) -> [[Int]] {
    var grid  = [[Int]]()

    var counter = 0
    while counter < n {
        let currRow = Array(repeating: 0, count: n)
        grid.append(currRow)
        counter += 1
    }

    return grid
}

func findSolutions(grid: [[Int]], row: Int, result: inout [[String]]) {
    if row == grid.count {
        result.append(buildSolution(grid: grid)) // O(n*n)
        return
    }

    for j in 0..<grid[row].count {
        let currCell = grid[row][j]
        if currCell == -1 { continue }

        let updatedGrid = getUpdatedGrid(grid: grid, row: row, col: j) // O(n+n)
        findSolutions(grid: updatedGrid, row: row + 1, result: &result)
    }
}

func getUpdatedGrid(grid: [[Int]], row: Int, col: Int) -> [[Int]] {
    var result = grid
    for i in row..<grid.count {
        result[i][col] = -1
    }

    var counter = 1
    while (row + counter) < grid.count  && (col + counter) < grid[row].count {
        result[row + counter][col + counter] = -1
        counter += 1
    }

    counter = 1
    while (row + counter) < grid.count  && (col - counter) >= 0 {
        result[row + counter][col - counter] = -1
        counter += 1
    }

    result[row][col] = 1

    return result
}

func buildSolution(grid: [[Int]]) -> [String] {
    var solution = [String]()
    for i in 0..<grid.count {
        var rowString = ""
        for j in 0..<grid[i].count {
            if grid[i][j] == 1 {
                rowString = "\(rowString)Q"
            } else {
                rowString = "\(rowString)."
            }
        }
        solution.append(rowString)
    }

    return solution
}

print(solveNQueens(1)) // [["Q"]]
print(solveNQueens(4)) // [[".Q..","...Q","Q...","..Q."],["..Q.","Q...","...Q",".Q.."]]