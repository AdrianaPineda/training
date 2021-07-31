// https://leetcode.com/explore/interview/card/facebook/55/dynamic-programming-3/3037/
// Given a 2D matrix matrix, handle multiple queries of the following type:
// Calculate the sum of the elements of matrix inside the rectangle defined by its 
// upper left corner (row1, col1) and lower right corner (row2, col2).
//
// Implement the NumMatrix class:
// NumMatrix(int[][] matrix) Initializes the object with the integer matrix matrix.
// int sumRegion(int row1, int col1, int row2, int col2) Returns the sum of the elements 
// of matrix inside the rectangle defined by its upper left corner (row1, col1) and lower right corner (row2, col2).

// Time complexity: O(m*m*row1*row2), m being the number of columns
// Space complexity: O(m*m*(row2 - row1 + 1))
class NumMatrix {

    let matrix: [[Int]]
    var rowsMatrices = [Int: [[Int]]]()
    var columns: Int = 0

    init(_ matrix: [[Int]]) {
        self.matrix = matrix
        columns = matrix[0].count
    }

    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        var results = 0
        for z in row1...row2 {
            let rowMatrix = getRowMatrix(row: z)
            results += rowMatrix[col1][col2]
        }

        return results
    }

    func getRowMatrix(row: Int) -> [[Int]] {
        if let rowMatrix = rowsMatrices[row] {
            return rowMatrix
        }

        var rowMatrix = [[Int]]()
        for i in 0..<columns {
            for j in i..<columns {
                if i == j {
                    rowMatrix.append(Array(repeating: 0, count: columns))
                    rowMatrix[i][j] = matrix[row][j]
                    continue
                }

                let previousValAtCol = rowMatrix[i][j - 1]
                rowMatrix[i][j] = previousValAtCol + matrix[row][j]
            }
        }

        rowsMatrices[row] = rowMatrix
        return rowMatrix
    }
}

// Alt
// Time complexity: O(m*n) + O(row2 - row1 + 1) => O(m*n), m rows & n columns
// Space complexity: O(m*n)
class NumMatrix {

    let matrix: [[Int]]
    var accumMatrix = [[Int]]()
    var columns: Int = 0

    init(_ matrix: [[Int]]) {
        self.matrix = matrix
        columns = matrix[0].count
        accumMatrix = buildAccumRowMatrix()
    }

    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        var results = 0
        for z in row1...row2 {
            let rowMatrix = accumMatrix[z]
            let leftAccum = col1 > 0 ? rowMatrix[col1 - 1] : 0
            results += rowMatrix[col2] - leftAccum
        }

        return results
    }

    func buildAccumRowMatrix() -> [[Int]] {
        var rowMatrix = [[Int]]()
        for i in 0..<matrix.count {
            rowMatrix.append(Array(repeating: 0, count: columns))
            for j in 0..<columns {
                let previousValAtCol = j > 0 ? rowMatrix[i][j - 1] : 0
                rowMatrix[i][j] = previousValAtCol + matrix[i][j]
            }
        }
        return rowMatrix
    }
}

// Alt
// Time complexity: O(m*n) + O(1)
// Space complexity: O(m*n)
class NumMatrix {

    let matrix: [[Int]]
    var accumMatrix = [[Int]]()
    var columns: Int = 0

    init(_ matrix: [[Int]]) {
        self.matrix = matrix
        columns = matrix[0].count
        accumMatrix = buildAccumRowMatrix()
    }

    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        let row2ToCol1 = col1 > 0 ? accumMatrix[row2][col1 - 1] : 0
        let row1ToCol2 = row1 > 0 ? accumMatrix[row1 - 1][col2] : 0
        let row1Tocol1 = (row1 > 0 && col1 > 0) ? accumMatrix[row1 - 1][col1 - 1] : 0
        return accumMatrix[row2][col2] - row2ToCol1 - row1ToCol2 + row1Tocol1
    }

    func buildAccumRowMatrix() -> [[Int]] {
        var rowMatrix = [[Int]]()
        for i in 0..<matrix.count {
            rowMatrix.append(Array(repeating: 0, count: columns))
            for j in 0..<columns {
                let previousValAtCol = j > 0 ? rowMatrix[i][j - 1] : 0
                let previousValAtRow = i > 0 ? rowMatrix[i - 1][j] : 0
                let prevAcc = (i > 0 && j > 0) ? rowMatrix[i - 1][j - 1] : 0
                rowMatrix[i][j] = previousValAtCol + previousValAtRow + matrix[i][j] - prevAcc
            }
        }
        return rowMatrix
    }
}


/**
 * Your NumMatrix object will be instantiated and called as such:
 * let obj = NumMatrix(matrix)
 * let ret_1: Int = obj.sumRegion(row1, col1, row2, col2)
 */