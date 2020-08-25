///
/// Represents the direction the turnstile is used
///
enum Direction: Int {
    // Enter
    case enter = 0
    // Exit
    case exit = 1
}

///
/// Represents a person that wants to pass the turnstile
///
struct Person {
    // Time at which the person arrives at the turnstile
    let time: Int
    // Index of the person from the original array of times
    let index: Int
}

///
/// Represents a current moment where a person passes the turnstile at a given time and a given direction
///
struct Round {
    // Index of the person that passes through the turnstile from the original array of times
    var index: Int
    // Time at which the person passes the turnstile
    var time: Int
    // Direction of the person that passes the turnstile
    var direction: Direction
}

///
/// Structure to handle the people using the turnstile (entering and leaving the university).
/// This structure was chosen instead of a Queue because removing the first element of an array takes O(*n*) time,
/// while removing the last element takes O(*1*) time
///
struct Stack<T> {
    private var array = [T]()

    var hasItems: Bool {
        return !array.isEmpty
    }

    var peek: T? {
        return array.last // Complexity -> O(1)
    }

    mutating func push(_ element: T) {
        array.append(element) // Complexity -> O(*1*) on average over many calls to append(_:) on the same array
    }

    mutating func pop() -> T? {
        return array.popLast() // Complexity -> O(1)
    }
}

///
/// This method returns an array with the times people pass the turnstile
///
/// - Parameters
///     - time: array of n integers where the value at index _i_ is the time in seconds when the _ith_ person will come to the turnstile
///     - direction: array of n integers where the value at index _i_ is the direction of the _ith_ person
/// - Returns
///     An array of n integers where the value at index _i_ is the time the _ith_ person will pass the turnstile
///
/// - Complexity: O(*n*) where *n* is the length of the array
///
func getTimes(time: [Int], direction: [Int]) -> [Int] {

    var (enterStack, exitStack) = getStacks(time: time, direction: direction) // O(*n)
    var lastDirection: Direction = .exit
    var currentTime = 0
    var newTimes = Array(repeating: 0, count: time.count) // O(*n)

    while enterStack.hasItems || exitStack.hasItems { // O(*n*) worst case

        guard let round = getRound(personAtEnter: enterStack.peek, personAtExit: exitStack.peek, lastDirection: lastDirection, currentTime: currentTime) else {
            continue
        }

        if round.direction == .exit {
            exitStack.pop()
        } else {
            enterStack.pop()
        }

        lastDirection = round.direction
        currentTime = round.time + 1
        newTimes[round.index] = round.time // O(*1)

    }

    return newTimes
}

///
/// This method returns the current round where a person passes the turnstile at a given time and a given direction
///
/// - Parameters:
///     - personAtEnter: next person (if any) from the stack at the enter side
///     - personAtExit: next person (if any) from the stack at the exit side
///     - lastDirection: last direction the turnstile was used (does not mean it was in the previous second)
///     - currentTime: current time at which a person can pass the turnstile
///
/// - Returns:
///     The round for the current time
///
/// - Complexity: O(*1*)
///
///
func getRound(personAtEnter: Person?, personAtExit: Person?, lastDirection: Direction, currentTime: Int) -> Round? {

    if let personAtEnter = personAtEnter, let personAtExit = personAtExit { // Both sides have people waiting

        var currentDirection = lastDirection
        if personAtEnter.time > currentTime && personAtExit.time > currentTime {
            currentDirection = .exit // Reset entrance priority
        }

        let realEnterTime = getMovingTime(person: personAtEnter, currentTime: currentTime)
        let realExitTime = getMovingTime(person: personAtExit, currentTime: currentTime)

        let shouldPersonEnter = realEnterTime < realExitTime || (realEnterTime == realExitTime && currentDirection == .enter)
        if shouldPersonEnter {
            return Round(index: personAtEnter.index, time: realEnterTime, direction: .enter) // Person enters
        } else {
            return Round(index: personAtExit.index, time: realExitTime, direction: .exit) // Person exits
        }

    } else if let personAtEnter = personAtEnter { // Only people left in enter side
        let realEnterTime = getMovingTime(person: personAtEnter, currentTime: currentTime)
        return Round(index: personAtEnter.index, time: realEnterTime, direction: .enter)

    } else if  let personAtExit = personAtExit { // Only people left in exit side
        let realExitTime = getMovingTime(person: personAtExit, currentTime: currentTime)
        return Round(index: personAtExit.index, time: realExitTime, direction: .exit)
    }

    return nil
}

///
/// This method returns the time a person can pass the turnstile
///
/// - Parameters:
///     - person: the person that wants to pass the turnstile
///     - currentTime: the current time at which a person can pass the turnstile
///
/// - Returns:
///     - The time at which the person can pass the turnstile
///
/// - Complexity:O(*1*)
///
func getMovingTime(person: Person, currentTime: Int) -> Int {
    return person.time < currentTime ? currentTime : person.time
}

///
/// This method returns the stacks for enter and exit side.
///
/// - Parameters:
///     - time:array of n integers where the value at index _i_ is the time in seconds when the _ith_ person will come to the turnstile
///     - direction: array of n integers where the value at index _i_ is the direction of the _ith_ person
///
/// - Returns:
///     - Tuple containing the enter stack and the exit stack in that order.
///     - Each stack is represented as an array of n integers where the value at index _i_ is the time in seconds when the _ith_ person will come to the turnstile
///
/// - Complexity: O(*n*) where *n* is the length of the array
///
func getStacks(time:[Int], direction:[Int]) -> (Stack<Person>, Stack<Person>) {
    var enterStack = Stack<Person>()
    var exitStack = Stack<Person>()
    for i in (0..<time.count).reversed() {
        let direction = direction[i]
        let person = Person(time: time[i], index: i)
        if direction == 1 {
            exitStack.push(person) // O(*1*) on average
        } else {
            enterStack.push(person) // O(*1*) on average
        }
    }

    return (enterStack, exitStack)
}

print(getTimes(time: [0, 0, 1, 5], direction: [0, 1, 1, 0]))
// [2, 0, 1, 5]

print(getTimes(time: [0, 1, 1, 3, 3], direction: [0, 1, 0, 0, 1]))
// [0, 2, 1, 4, 3]

print(getTimes(time: [0, 51, 51, 52, 52, 90], direction: [0, 1, 0, 0, 0, 1]))
// [0, 54, 51, 52, 53, 90]

print(getTimes(time: [0, 51, 51, 52, 52, 54], direction: [0, 1, 1, 0, 0, 1]))
// [0, 51, 52, 53, 54, 55]

print(getTimes(time: [28, 28, 29, 29, 29, 29, 30, 30, 31, 32], direction: [0, 0, 1, 1, 0, 0, 1, 0, 1, 0]))
// [28, 29, 34, 35, 30, 31, 36, 32, 37, 33]

print(getTimes(time: [3, 3, 3, 4, 4, 5, 6, 6, 7, 8], direction: [1, 1, 0, 1, 0, 0, 0, 1, 0, 0]))
// [3, 4, 7, 5, 8, 9, 10, 6, 11, 12]

print(getTimes(time: [0, 1, 1, 3, 3], direction: [0, 1, 0, 0, 1]))
// [0, 2, 1, 4, 3]

print(getTimes(time: [20, 21, 22, 22, 23, 24, 24, 25, 27, 28], direction: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))
// [20, 21, 22, 23, 24, 25, 26, 27, 28, 29]

print(getTimes(time: [20, 21, 22, 22, 23, 24, 24, 25, 27, 28], direction: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]))
// [20, 21, 22, 23, 24, 25, 26, 27, 28, 29]

print(getTimes(time: [0, 20, 21, 22, 23], direction: [0, 1, 0, 1, 1]))
// [0, 20, 21, 22, 23]

print(getTimes(time: [10, 10, 10, 10, 11, 11, 12, 13, 14], direction: [1,  0,  1,  1,  0,  1,  0,  1,  0]))
// [10, 15, 11, 12, 16, 13, 17, 14, 18]
