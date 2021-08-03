// https://leetcode.com/problems/robot-room-cleaner/

// mxn => grid
// obs => obstacles
// Time complexity: O(mxn - obs)
// Space complexity: O(mxn - obs) for the recursion stack + O(mxn - obs) for the Set
var visitedCells = Set<String>()
func cleanRoom(_ robot: Robot) {
    backtrack(x: 0, y: 0, direction: 0, robot)
}

func backtrack(x: Int, y: Int, direction: Int, _ robot: Robot) {
    let cell = "\(x) - \(y)"
    visitedCells.insert(cell)
    robot.clean()

    var turns = 0
    while turns < 4 {
        defer {
            turns += 1
            robot.turnRight()
        }

        let newDir = (direction + turns) % 4
        let (newX, newY) = getPosition(x: x, y: y, direction: newDir)
        let newCell = "\(newX) - \(newY)"

        if visitedCells.contains(newCell) { continue }

        if robot.move() {
            backtrack(x: newX, y: newY, direction: newDir, robot)
            robot.turnLeft()
            robot.turnLeft()
            robot.move()
            robot.turnRight()
            robot.turnRight()
        }
    }
}

func getPosition(x: Int, y: Int, direction: Int) -> (Int, Int) {
    if direction == 0 { // up
        return (x, y + 1)
    }

    if direction == 1 { // right
        return (x + 1, y)
    }

    if direction == 2 { // down
        return (x, y - 1)
    }

    return (x - 1, y) // left
}