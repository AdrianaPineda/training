//
// Problem: https://www.hackerrank.com/challenges/new-year-chaos/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays
// Big O:
// Time complexity: O(n^2)
// Space complexity: O(n)

// Complete the minimumBribes function below.
func minimumBribes(q: [Int]) -> Void {
    var newQ = q
    var bribes = 0
    var bribesDict = [Int: Int]()
    var bribesInQueue = true
    var passes = 0
    var caotic = false

    while(bribesInQueue) {

        guard let iterationWithBribes = swapPeopleInQueue(q: &newQ, passes: passes, bribes: &bribes, bribesDict: &bribesDict) else {
            caotic = true
            break
        }

        // If last iteration didn't have any bribes, we can finish the while loop
        if !iterationWithBribes {
            bribesInQueue = false
        }

        passes += 1
    }

    if caotic {
        print("Too chaotic")
    } else {
        print(bribes)
    }

}

// In order to avoid increasing complexity, I'm using `inout` params
func swapPeopleInQueue(q: inout [Int], passes: Int, bribes: inout Int, bribesDict: inout [Int: Int]) -> Bool? {
    var iterationWithBribes = false

    for i in 0..<(q.count - 1) {

        let peopleSwapSuccessful = swapPeopleAtPosIfNeeded(q: &q, pos: i, passes: passes, bribes: &bribes, bribesDict: &bribesDict)
        if !peopleSwapSuccessful {
             return nil
        }

        if isCurrentOrNextValueInWrongOrder(q: q, pos: i) {
            iterationWithBribes = true
        }
    }

    return iterationWithBribes
}

func swapPeopleAtPosIfNeeded(q: inout [Int], pos: Int, passes: Int, bribes: inout Int, bribesDict: inout [Int: Int]) -> Bool {
    let shouldSwitch = shouldSwitchCurrentAndNextPositions(q: q, i: pos, passes: passes)

    if shouldSwitch {
        // Check for previous bribes
        let currentVal = q[pos]
        let currentBribes = bribesDict[currentVal] ?? 0
        if currentBribes >= 2 { // Maximum number of bribes per person reached
            return false
        }

        // Switch positions
        q[pos] = q[pos + 1]
        q[pos + 1] = currentVal
        bribes += 1
        bribesDict[currentVal] = currentBribes + 1
    }

    return true
}

func shouldSwitchCurrentAndNextPositions(q: [Int], i: Int, passes: Int) -> Bool {
    let currentVal = q[i]
    let nextVal = q[i + 1]

    let currentValInWrongPos = currentVal > (i + 1)
    let nextValInWrongPos = nextVal < (i + 2)
    // The first pass we switch positions only if both current and next values are wrong.
    // The subsequent passes we only care about next value.
    let shouldSwitch = (currentValInWrongPos && nextValInWrongPos) || (passes > 0 && nextValInWrongPos)
    return shouldSwitch
}

func isCurrentOrNextValueInWrongOrder(q: [Int], pos: Int) -> Bool {
    let updatedCurrentValInWrongPos = q[pos] > (pos + 1)
    let updatedNextValInWrongPos = q[pos + 1] < (pos + 2)
    return updatedCurrentValInWrongPos || updatedNextValInWrongPos
}


minimumBribes(q: [2, 1, 5, 3, 4])
minimumBribes(q: [2, 5, 1, 3, 4])
minimumBribes(q: [1, 2, 5, 3, 4, 7, 8, 6])
minimumBribes(q: [5, 1, 2, 3, 7, 8, 6, 4])
minimumBribes(q: [1, 2, 5, 3, 7, 8, 6, 4])

