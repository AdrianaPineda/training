// https://leetcode.com/problems/spiral-matrix/

func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    guard matrix.count > 0 && matrix[0].count > 0 else {
        return []
    }
    var rows = matrix.count
    var cols = matrix[0].count

    var rowLow = 0
    var rowUpp = rows

    var colLow = 0
    var colUpp = cols

    var result = [Int]()

    while rowLow < rowUpp && colLow < colUpp {

        for i in colLow..<colUpp {
            let val = matrix[rowLow][i]
            result.append(val)
        }

        guard rowUpp - rowLow > 1 else {
            break
        }

        for j in (rowLow + 1)..<rowUpp {
            let val = matrix[j][colUpp - 1]
            result.append(val)
        }

        var lowerBound = colLow
        var upperBound = colUpp - 1
        guard lowerBound < upperBound else {
            break
        }

        for z in (lowerBound..<upperBound).reversed() {
            let val = matrix[rowUpp - 1][z]
            result.append(val)
        }

        lowerBound = rowLow + 1
        upperBound = rowUpp - 1
        guard lowerBound < upperBound else {
            break
        }

        for w in (lowerBound..<upperBound).reversed() {
            let val = matrix[w][colLow]
            result.append(val)
        }

        rowLow += 1
        rowUpp -= 1
        colLow += 1
        colUpp -= 1
    }

    return result
}

// Alt
// Time complexity: O(n)
// Space complexity: O(1)
func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    guard matrix.count > 0 && matrix[0].count > 0 else {
        return []
    }

    var rowLow = 0
    var rowUpp = matrix.count - 1

    var colLow = 0
    var colUpp = matrix[0].count - 1

    var result = [Int]()

    while rowLow <= rowUpp && colLow <= colUpp {

        for i in colLow...colUpp {
            let val = matrix[rowLow][i]
            result.append(val)
        }

        guard rowLow < rowUpp else { break }

        for j in (rowLow + 1)...rowUpp {
            let val = matrix[j][colUpp]
            result.append(val)
        }

        guard colLow < colUpp else { break }

        for z in stride(from: colUpp - 1, to: colLow, by: -1) {
            let val = matrix[rowUpp][z]
            result.append(val)
        }

        for w in stride(from: rowUpp, to: rowLow, by: -1) {
            let val = matrix[w][colLow]
            result.append(val)
        }

        rowLow += 1
        rowUpp -= 1
        colLow += 1
        colUpp -= 1

    }

    return result
}

print(spiralOrder([[1,11],[2,12],[3,13],[4,14],[5,15],[6,16],[7,17],[8,18],[9,19],[10,20]])) // [1, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 10, 9, 8, 7, 6, 5, 4, 3, 2]
print(spiralOrder([[7],[9],[6]])) // [7,9,6]
print(spiralOrder([[1,2,3],[4,5,6],[7,8,9]])) // [1,2,3,6,9,8,7,4,5]
print(spiralOrder([[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]])) // [1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10]
print(spiralOrder([[1,2,3,4],[5,6,7,8],[9,10,11,12]])) // [1,2,3,4,8,12,11,10,9,5,6,7]