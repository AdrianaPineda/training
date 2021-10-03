// https://leetcode.com/problems/knight-dialer/
/**
The chess knight has a unique movement, it may move two squares vertically and one
square horizontally, or two squares horizontally and one square vertically (with both
forming the shape of an L). The possible movements of chess knight are shown in this diagaram:
A chess knight can move as indicated in the chess diagram below:
We have a chess knight and a phone pad as shown below, the knight can only stand on a numeric cell (i.e. blue cell).

Given an integer n, return how many distinct phone numbers of length n we can dial.

You are allowed to place the knight on any numeric cell initially and then you should
perform n - 1 jumps to dial a number of length n. All jumps should be valid knight jumps.

As the answer may be very large, return the answer modulo 109 + 7.
*/
// https://alexgolec.dev/google-interview-questions-deconstructed-the-knights-dialer/
struct Cache: Hashable {
    let n: Int
    let pos: Position
}

struct Position: Hashable {
    let x: Int
    let y: Int
    func isValid() -> Bool {
        let isRedCell = (x == 3 && y == 0) || (x == 3 && y == 2)
        return x >= 0 && x < 4 && y >= 0 && y < 3 && !isRedCell
    }
}

// Time complexity: O(3^n * n) upper bound, O(n)
// Space complexity: O(n)

var movements = [[-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1]]
let max = Int(pow(Double(10), Double(9)) + Double(7))
func knightDialer(_ n: Int) -> Int {
    var cache = [Cache: Int]()
    var result = 0
    for i in 0...3 {
        for j in 0...2 {
            let position = Position(x: i, y: j)
            result = (result + knightDialerRecursive(n, position, &cache)) % max
        }
    }
    return result
}

func knightDialerRecursive(_ n: Int, _ pos: Position, _ cache: inout [Cache: Int]) -> Int {
    let currCache = Cache(n: n, pos: pos)
    if let cachedResult = cache[currCache] { return cachedResult }

    guard pos.isValid() else { return 0 }
    if n == 1 { return 1 }

    var result = 0
    for movement in movements {
        let nextPos = Position(x: pos.x + movement[0], y: pos.y + movement[1])
        result += knightDialerRecursive(n - 1, nextPos, &cache)
    }

    result = result % max

    cache[currCache] = result

    return result
}

// Time complexity: O(n)
// Space complexity: O(1)
let max = Int(pow(Double(10), Double(9)) + Double(7))
var jumpIndexes = [[4, 6], [6, 8], [7, 9], [4, 8], [3, 9, 0], [], [1, 7, 0], [6, 2], [1, 3], [4, 2]]
let possibleJumps = [2, 2, 2, 2, 3, 0, 3, 2, 2, 2]
                //   0  1  2  3  4  5  6  7  8  9
func knightDialer(_ n: Int) -> Int {
    var result = 0

    for i in 0...9 {
        let currVal = knighDialerAtPos(position: i, n) % max
        result += currVal
    }

    return result % max
}

func knighDialerAtPos(position: Int, _ n: Int) -> Int {
    var prior = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

    var jumps = 1
    while jumps < n {
        var current = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        for i in 0...9 {
            let jumpIndexes = jumpIndexes[i]
            for j in jumpIndexes {
                let currVal = (prior[j] % max)
                current[i] += currVal
            }
        }

        jumps += 1
        prior = current
    }

    return prior[position]
}

print(knightDialer(1)) // 10
print(knightDialer(2)) // 20
print(knightDialer(3)) // 46
print(knightDialer(4)) // 104
print(knightDialer(3131)) // 136006598