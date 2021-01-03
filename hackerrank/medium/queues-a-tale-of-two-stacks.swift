//
// Problem: https://www.hackerrank.com/challenges/ctci-queue-using-two-stacks/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=stacks-queues
// Big O:
// Time complexity: O(N*N)
// Space complexity: O(N)

struct Queue<T> {
    private var array = [T]()

    private func isQueueEmpty() -> Bool {
        return array.isEmpty
    }

    mutating func put(element: T) {
        array.append(element)
    }

    mutating func pop() -> T? {
        return isQueueEmpty() ? nil : array.removeFirst()
    }

    func peek() -> T? {
        return isQueueEmpty() ? nil: array[0]
    }
}

enum InputError: Error {
    case invalidLine
}

var queue = Queue<Int>()

guard let queriesAsString = readLine(strippingNewline: true) else { 
    print("invalid line")
    throw InputError.invalidLine
}
guard let queries = Int(queriesAsString) else {
    print("invalid line")
    throw InputError.invalidLine
}

var elementsToPrint = [Int]()

for _ in 0..<queries {
    guard let line = readLine(strippingNewline: true) else { 
        print("invalid line")
        throw InputError.invalidLine
    }
    let inputs = line.split {$0 == " "}.map (String.init)
    let queryType = Int(inputs[0]) // 1: enqueue, 2: dequeue, 3: peek
    switch queryType {
    case 1:
        guard let element = Int(inputs[1]) else { 
            print("invalid line")
            throw InputError.invalidLine
        }
        queue.put(element: element)
        break
    case 2:
        let _ = queue.pop()
        break
    default:
        guard let peekedElement = queue.peek() else { 
            print("invalid line")
            throw InputError.invalidLine
        }
        elementsToPrint.append(peekedElement)
    }
}

for element in elementsToPrint {
    print(element)
}
