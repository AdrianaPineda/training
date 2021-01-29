
// Write a method to replace all spacesin a string with '%20'. You may asssume that the
// string has sufficient space at ethe end to hold the additional character, and that you
// are given the "true" length of the string

// With additional data structure
// Time complexity: O(n)
// Space complexity: O(n)
struct Queue<T> {
    private var array = [T]()

    func isEmpty() -> Bool {
        return array.isEmpty
    }

    mutating func push(element: T) {
        array.append(element)
    }

    mutating func pop() -> T? {
        return isEmpty() ? nil : array.removeFirst()
    }
}

func urlify(s: inout [Character], length: Int) {
    var queue = Queue<Character>()

    var lengthCounter = 0
    for i in 0..<s.count {
        let currChar = s[i]
        lengthCounter += 1

        if lengthCounter <= length {
            if currChar == " " {
                queue.push(element: "%")
                queue.push(element: "2")
                queue.push(element: "0")
            } else {
                queue.push(element: currChar)
            }
        }

        guard let nextChar = queue.pop() else {
            continue
        }

        s[i] = nextChar

    }
}

func urlifyAlt(s: inout [Character], length: Int) {
    var queue = Queue<Character>()

    for var i in 0..<length {
        let currChar = s[i]

        if currChar == " " {
            queue.push(element: "%")
            queue.push(element: "2")
            queue.push(element: "0")
        } else {
            queue.push(element: currChar)
        }
    }

    var index = 0
    while (!queue.isEmpty()) {
        guard let char = queue.pop() else {
            continue
        }

        s[index] = char
        index += 1
    }
}

// Without additional data structure
// Time complexity: O(n^2)
// Space complexity: O(1)
func urlify(s: inout [Character], length: Int) {
    for i in 0..<s.count {
        let char = s[i]
        if char != " " || i >= length {
            continue
        }

        s[i] = "%"
        let index = i + 1

        moveChars(s: &s, startIndex: index, bound: length)
        moveChars(s: &s, startIndex: (index + 1), bound: length)

        s[index] = "2"
        s[index + 1] = "0"

        i += 3
    }
}

func moveChars(s: inout [Character], startIndex: Int, bound: Int) {
    var movingChar = s[startIndex]
    var movingIndex = startIndex + 2

    while movingIndex < s.count {
        let nextChar = s[movingIndex]
        s[movingIndex] = movingChar
        movingChar = nextChar

        if movingIndex >= bound {
            break
        }

        movingIndex += 2
    }
}

// From end to start
// Time complexity: O(n)
// Space complexity: O(1)
func urlify(s: inout [Character], length: Int) {
    var indexDifference = s.count - length
    var i = s.count - 1

    while i > 0 && indexDifference > 0 {
        let currChar = s[i - indexDifference]
        if currChar == " " {
            s[i] = "0"
            s[i - 1] = "2"
            s[i - 2] = "%"
            i -= 3
            indexDifference -= 2
        } else {
            s[i] = currChar
            i -= 1
        }
    }
}

// From end to start
// Time complexity: O(n)
// Space complexity: O(1)
func urlify(s: inout [Character], length: Int) {
    var i = s.count - 1
    for j in (0..<length).reversed() {
        let currChar = s[j]
        if currChar == " " {
            s[i] = "0"
            s[i - 1] = "2"
            s[i - 2] = "%"
            i -= 3
        } else {
            s[i] = currChar
            i -= 1
        }
    }
}

var chars: [Character] = ["M", "r", " ", "J", "o", "h", "n", " ", "S", "m", "i", "t", "h", " ", " ", " ", " "]
urlify(s: &chars, length: 13) // ["M", "r", "%", "2", "0", "J", "o", "h", "n", "%", "2", "0", "S", "m", "i", "t", "h"]