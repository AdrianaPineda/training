// https://leetcode.com/problems/robot-bounded-in-circle/

/**

point

direction

    N =>
        L: W
        R: E
    
    S => 
        L: E
        R: W

    E => 
        L: N
        R: S

    W => 
        L: S
        R: N

G => 
    N y++
    S y--
    E x++
    W x--

distanceToOrigin = Int.max
currDistance > distanceToOrigin => false

Direction:
    N: 0
    S: 1
    E: 2
    W: 3
*/

// Time complexity: O(n), n the number of instructions
// Space complexity: O(1)
func isRobotBounded(_ instructions: String) -> Bool {
    var positionInX = 0
    var positionInY = 0
    var direction = 0

    for _ in 0..<4 {
        print(positionInX)
        print(positionInY)
        executeInstructions(instructions, updatedDirection: &direction, updatedPositionX: &positionInX, updatedPositionY: &positionInY)

        if positionInX == 0 && positionInY == 0 {
            break
        }
    }

    return positionInX == 0 && positionInY == 0
}

func executeInstructions(_ instructions: String, updatedDirection: inout Int, updatedPositionX: inout Int, updatedPositionY: inout Int) {
    for inst in instructions {
        if inst == "G" {
            switch updatedDirection {
                case 0:
                    updatedPositionY += 1
                    break
                case 1:
                    updatedPositionY -= 1
                    break
                case 2:
                    updatedPositionX += 1
                    break
                default:
                    updatedPositionX -= 1
                    break

            }
        }

        if inst == "L" {
            switch updatedDirection {
                case 0:
                    updatedDirection = 3
                    break
                case 1:
                    updatedDirection = 2
                    break
                case 2:
                    updatedDirection = 0
                    break
                default:
                    updatedDirection = 1
                    break

            }
        }

        if inst == "R" {
            switch updatedDirection {
                case 0:
                    updatedDirection = 2
                    break
                case 1:
                    updatedDirection = 3
                    break
                case 2:
                    updatedDirection = 1
                    break
                default:
                    updatedDirection = 0
                    break

            }
        }

        print(" instr \(inst) direction => \(updatedDirection) \(updatedPositionX) \(updatedPositionY)")
    }
}

print(isRobotBounded("GL")) // true
print(isRobotBounded("GGLLGG")) // true
