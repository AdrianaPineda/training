// https://leetcode.com/problems/knight-probability-in-chessboard/

/**
On an n x n chessboard, a knight starts at the cell (row, column) and attempts
to make exactly k moves. The rows and columns are 0-indexed, so the top-left
cell is (0, 0), and the bottom-right cell is (n - 1, n - 1).

A chess knight has eight possible moves it can make, as illustrated below.
Each move is two cells in a cardinal direction, then one cell in an orthogonal direction.

Each time the knight is to move, it chooses one of eight possible moves uniformly at
random (even if the piece would go off the chessboard) and moves there.

The knight continues moving until it has made exactly k moves or has moved off the chessboard.
Return the probability that the knight remains on the board after it has stopped moving.
*/

/**
1) Calculate probability of staying on the board
2) Decrease k
*/

// Time limit exceeded
// Time complexity: O(8^k)
// Space complexity: O(k)
var moves = [[1, -2], [2, -1], [2, 1], [1, 2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
func knightProbability(_ n: Int, _ k: Int, _ row: Int, _ column: Int) -> Double {
    if k == 0 {
        return 1
    }

    var accProbability: Double = 0
    for move in moves {
        let nextRow = row + move[0]
        let nextCol = column + move[1]
        guard isValid(row: nextRow, col: nextCol, n: n) else {
            continue
        }

        accProbability += (1/8) * knightProbability(n, k - 1, nextRow, nextCol)
    }

    return accProbability
}

func isValid(row: Int, col: Int, n: Int) -> Bool {
    return row >= 0 && row < n && col >= 0 && col < n
}

// Accepted
// Time complexity: = O(k*n^2)
// Space complexity: O(n) + O(n*n*k) = O(k*n^2)
struct Point: Hashable {
    let row: Int
    let col: Int
    let k: Int
}

var probabilityCache = [Point: Double]()
var moves = [[1, -2], [2, -1], [2, 1], [1, 2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
func knightProbability(_ n: Int, _ k: Int, _ row: Int, _ column: Int) -> Double {
    if let prob = probabilityCache[Point(row: row, col: column, k: k)] {
        return prob
    }

    if k == 0 {
        return 1
    }

    var accProbability: Double = 0
    for move in moves {
        let nextRow = row + move[0]
        let nextCol = column + move[1]
        guard isValid(row: nextRow, col: nextCol, n: n) else {
            continue
        }

        accProbability += (1/8) * knightProbability(n, k - 1, nextRow, nextCol)
    }

    probabilityCache[Point(row: row, col: column, k: k)] = accProbability
    return accProbability
}

func isValid(row: Int, col: Int, n: Int) -> Bool {
    return row >= 0 && row < n && col >= 0 && col < n
}

print(knightProbability(3, 2, 0, 0)) // 0.0625
print(knightProbability(8, 30, 6, 4)) // 0.00019