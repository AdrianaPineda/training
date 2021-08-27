// https://leetcode.com/problems/leftmost-column-with-at-least-a-one/
/**
A row-sorted binary matrix means that all elements are 0 or 1 and each 
row of the matrix is sorted in non-decreasing order.

Given a row-sorted binary matrix binaryMatrix, return the index (0-indexed) 
of the leftmost column with a 1 in it. If such an index does not exist, return -1.

You can't access the Binary Matrix directly. You may only access the matrix 
using a BinaryMatrix interface:

BinaryMatrix.get(row, col) returns the element of the matrix at index (row, col) (0-indexed).
BinaryMatrix.dimensions() returns the dimensions of the matrix as a list of 2 elements 
[rows, cols], which means the matrix is rows x cols.
Submissions making more than 1000 calls to BinaryMatrix.get will be judged Wrong Answer. 
Also, any solutions that attempt to circumvent the judge will result in disqualification.

For custom testing purposes, the input will be the entire binary matrix mat. You will not
have access to the binary matrix directly.
**/

public class BinaryMatrix {
    var matrix = [[0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
                  [0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1]]
    public func get(_ row: Int, _ col: Int) -> Int {
        return matrix[row][col]
    }
    public func dimensions() -> [Int] {
        return [matrix.count, matrix[0].count]
    }
};

// Recursive
// Time complexity: O(r*log(c))
// Space complexity: O(log(c))
func leftMostColumnWithOne(_ binaryMatrix: BinaryMatrix) -> Int {
    let dimensions = binaryMatrix.dimensions()
    guard dimensions.count == 2 else { return -1 }

    let rows = dimensions[0]
    let columns = dimensions[1]
    return findLeftMost(0, columns - 1, binaryMatrix, rows) ?? -1
}

func findLeftMost(_ start: Int, _ end: Int, _ binaryMatrix: BinaryMatrix, _ rows: Int) -> Int? {
    if start > end {
        return nil
    }

    let currColumn = (start + end) / 2
    for i in 0..<rows {
        let currElement = binaryMatrix.get(i, currColumn)
        guard currElement == 1 else { continue }

        if let currLeftMostColumn = findLeftMost(start, currColumn - 1, binaryMatrix, rows) {
            return currLeftMostColumn
        } else {
            return currColumn
        }
    }

    return findLeftMost(currColumn + 1, end, binaryMatrix, rows)
}

// Non-recursive
// Time complexity: O(r*log(c))
// Space complexity: O(1)
func leftMostColumnWithOne(_ binaryMatrix: BinaryMatrix) -> Int {
    let dimensions = binaryMatrix.dimensions()
    guard dimensions.count == 2 else { return -1 }

    let rows = dimensions[0]
    let columns = dimensions[1]
    var start = 0
    var end = columns - 1
    var leftMostCol = -1

    while start <= end {
        let currCol = (start + end) / 2

        var foundNum = false
        for i in 0..<rows {
            let element = binaryMatrix.get(i, currCol)
            guard element == 1 else { continue }
            leftMostCol = currCol
            end = currCol - 1
            foundNum = true
            break
        }

        if foundNum {
            continue
        }

        start = currCol + 1

    }

    return leftMostCol
}

// With pointer
// Time complexity: O(r + c)
// Space complexity: O(1)
func leftMostColumnWithOne(_ binaryMatrix: BinaryMatrix) -> Int {
    let dimensions = binaryMatrix.dimensions()
    guard dimensions.count == 2 else { return -1 }

    let rows = dimensions[0]
    let columns = dimensions[1]
    var currRow = 0
    var currCol = columns - 1
    var leftMost = -1
    while currRow < rows && currCol >= 0 {
        let element = binaryMatrix.get(currRow, currCol)
        if element == 0 {
            currRow += 1
            continue
        }

        leftMost = currCol
        currCol -= 1
    }

    return leftMost
}


let binaryMatrix = BinaryMatrix()
print(leftMostColumnWithOne(binaryMatrix))