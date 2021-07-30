
struct Point {
    let x: Int
    let y: Int
    let currMoves: Int
}

// Time limit
func minKnightMoves(_ x: Int, _ y: Int) -> Int {
    var pointsToVisit = [Point]()
    var visitedPoints = Set<String>()

    // Add (0,0) to points to visit
    pointsToVisit.append(Point(x: 0, y: 0, currMoves: 0))

    while !pointsToVisit.isEmpty {
        let point = pointsToVisit.removeFirst()
        if point.x == x && point.y == y {
            return point.currMoves
        }

        visitedPoints.insert("\(point.x)\(point.y)")

        // Add neighbors
        addNeighbor(point.x + 1, point.y + 2, point.currMoves, &pointsToVisit, visitedPoints)
        addNeighbor(point.x + 2, point.y + 1, point.currMoves, &pointsToVisit, visitedPoints)
        addNeighbor(point.x + 2, point.y - 1, point.currMoves, &pointsToVisit, visitedPoints)
        addNeighbor(point.x + 1, point.y - 2, point.currMoves, &pointsToVisit, visitedPoints)
        addNeighbor(point.x - 1, point.y - 2, point.currMoves, &pointsToVisit, visitedPoints)
        addNeighbor(point.x - 2, point.y - 1, point.currMoves, &pointsToVisit, visitedPoints)
        addNeighbor(point.x - 2, point.y + 1, point.currMoves, &pointsToVisit, visitedPoints)
        addNeighbor(point.x - 1, point.y + 2, point.currMoves, &pointsToVisit, visitedPoints)
    }

    return -1
}

func addNeighbor(_ x: Int, _ y: Int, _ moves: Int, _ pointsToVisit: inout [Point], _ visitedPoints: Set<String>) {
    if visitedPoints.contains("\(x)\(y)") {
        return
    }

    pointsToVisit.append(Point(x: x, y: y, currMoves: moves + 1))
}


struct Point {
    let x: Int
    let y: Int
    let currMoves: Int
}

class Node {
    let point: Point
    var next: Node?

    init(point: Point) {
        self.point = point
    }
}

class LinkedList {
    var head: Node?
    var tail: Node?

    func add(point: Point) {
        let node = Node(point: point)

        guard let _ = head else {
            head = node
            tail = node
            return
        }

        tail?.next = node
        tail = node
    }

    func removeFirst() -> Node? {
        let currHead = head
        head = currHead?.next
        return currHead
    }

    func peek() -> Bool {
        return head != nil
    }
}

func minKnightMoves(_ x: Int, _ y: Int) -> Int {
    var pointsToVisit = LinkedList()
    var visitedPoints = Set<String>()

    // Add (0,0) to points to visit
    pointsToVisit.add(point: Point(x: 0, y: 0, currMoves: 0))
    visitedPoints.insert("0,0")

    while pointsToVisit.peek() {
        guard let node = pointsToVisit.removeFirst() else { continue }

        let foundTarget = addNeighbors(x, y, point: node.point, &pointsToVisit, &visitedPoints)
        if foundTarget {
            return node.point.currMoves + 1
        }
    }

    return -1
}

func addNeighbors(_ x: Int, _ y: Int, point: Point, _ pointsToVisit: inout LinkedList, _ visitedPoints: inout Set<String>) -> Bool {
    return addNeighbor(x, y, point.x + 1, point.y + 2, point.currMoves, &pointsToVisit, &visitedPoints) || addNeighbor(x, y, point.x + 2, point.y + 1, point.currMoves, &pointsToVisit, &visitedPoints) || addNeighbor(x, y, point.x + 2, point.y - 1, point.currMoves, &pointsToVisit, &visitedPoints) || addNeighbor(x, y, point.x + 1, point.y - 2, point.currMoves, &pointsToVisit, &visitedPoints) || addNeighbor(x, y, point.x - 1, point.y - 2, point.currMoves, &pointsToVisit, &visitedPoints) || addNeighbor(x, y, point.x - 2, point.y - 1, point.currMoves, &pointsToVisit, &visitedPoints) || addNeighbor(x, y, point.x - 2, point.y + 1, point.currMoves, &pointsToVisit, &visitedPoints) || addNeighbor(x, y, point.x - 1, point.y + 2, point.currMoves, &pointsToVisit, &visitedPoints)
}

func addNeighbor(_ targetX: Int, _ targetY: Int, _ x: Int, _ y: Int, _ moves: Int, _ pointsToVisit: inout LinkedList, _ visitedPoints: inout Set<String>) -> Bool {

    if targetX == x && targetY == y {
        return true
    }

    if visitedPoints.contains("\(x)\(y)") {
        return false
    }

    visitedPoints.insert("\(x),\(y)")
    pointsToVisit.add(point: Point(x: x, y: y, currMoves: moves + 1))
    return false
}

// Alt time limit
struct Point {
    let x: Int
    let y: Int
    let currMoves: Int
}

class Node {
    let point: Point
    var next: Node?

    init(point: Point) {
        self.point = point
    }
}

class LinkedList {
    var head: Node?
    var tail: Node?

    func add(point: Point) {
        let node = Node(point: point)

        guard let _ = head else {
            head = node
            tail = node
            return
        }

        tail?.next = node
        tail = node
    }

    func removeFirst() -> Node? {
        let currHead = head
        head = currHead?.next
        return currHead
    }

    func peek() -> Bool {
        return head != nil
    }
}

var pointsToVisit = LinkedList()
var visitedPoints = Set<String>()

func minKnightMoves(_ x: Int, _ y: Int) -> Int {
    if x == 0 && y == 0 { return 0 }

    // Add (0,0) to points to visit
    pointsToVisit.add(point: Point(x: 0, y: 0, currMoves: 0))
    visitedPoints.insert("0,0")

    while pointsToVisit.peek() {
        guard let node = pointsToVisit.removeFirst() else { continue }

        let foundTarget = addNeighbors(x, y, point: node.point)
        if foundTarget {
            return node.point.currMoves + 1
        }
    }

    return -1
}

func addNeighbors(_ x: Int, _ y: Int, point: Point) -> Bool {
    let (x1, y1) = (point.x + 1, point.y + 2)
    let (x2, y2) = (point.x + 2, point.y + 1)
    let (x3, y3) = (point.x + 2, point.y - 1)
    let (x4, y4) = (point.x + 1, point.y - 2)
    let (x5, y5) = (point.x - 1, point.y - 2)
    let (x6, y6) = (point.x - 2, point.y - 1)
    let (x7, y7) = (point.x - 2, point.y + 1)
    let (x8, y8) = (point.x - 1, point.y + 2)

    if x > point.x {
        return addNeighbor(x, y, x1, y1, point.currMoves) || addNeighbor(x, y, x2, y2, point.currMoves) ||  addNeighbor(x, y, x3, y3, point.currMoves) || addNeighbor(x, y, x4, y4, point.currMoves)
    } else {
        return addNeighbor(x, y, x7, y7, point.currMoves) || addNeighbor(x, y, x8, y8, point.currMoves) ||  addNeighbor(x, y, x5, y5, point.currMoves) || addNeighbor(x, y, x6, y6, point.currMoves)
    }
}

func addNeighbor(_ targetX: Int, _ targetY: Int, _ x: Int, _ y: Int, _ moves: Int) -> Bool {

    if targetX == x && targetY == y {
        return true
    }

    if visitedPoints.contains("\(x)\(y)") {
        return false
    }

    visitedPoints.insert("\(x),\(y)")
    pointsToVisit.add(point: Point(x: x, y: y, currMoves: moves + 1))
    return false
}

// Alt
struct Point {
    let x: Int
    let y: Int
    let currMoves: Int
}

class Node {
    let point: Point
    var next: Node?

    init(point: Point) {
        self.point = point
    }
}

class LinkedList {
    var head: Node?
    var tail: Node?

    func add(point: Point) {
        let node = Node(point: point)

        guard let _ = head else {
            head = node
            tail = node
            return
        }

        tail?.next = node
        tail = node
    }

    func removeFirst() -> Node? {
        let currHead = head
        head = currHead?.next
        return currHead
    }

    func peek() -> Bool {
        return head != nil
    }
}

var pointsToVisit = LinkedList()
var visitedPoints = Set<String>()

func minKnightMoves(_ x: Int, _ y: Int) -> Int {
    if x == 0 && y == 0 { return 0 }

    // Add (0,0) to points to visit
    pointsToVisit.add(point: Point(x: 0, y: 0, currMoves: 0))
    visitedPoints.insert("0,0")

    while pointsToVisit.peek() {
        guard let node = pointsToVisit.removeFirst() else { continue }

        visitedPoints.insert("\(node.point.x),\(node.point.y)")

        if node.point.x == x && node.point.y == y {
            return node.point.currMoves
        }

        addNeighbors(x, point: node.point)
    }

    return -1
}

func addNeighbors(_ x: Int, point: Point) {
    let (x1, y1) = (point.x + 1, point.y + 2)
    let (x2, y2) = (point.x + 2, point.y + 1)
    let (x3, y3) = (point.x + 2, point.y - 1)
    let (x4, y4) = (point.x + 1, point.y - 2)
    let (x5, y5) = (point.x - 1, point.y - 2)
    let (x6, y6) = (point.x - 2, point.y - 1)
    let (x7, y7) = (point.x - 2, point.y + 1)
    let (x8, y8) = (point.x - 1, point.y + 2)

    if x > point.x {
        addNeighbor(x1, y1, point.currMoves)
        addNeighbor(x2, y2, point.currMoves)
        addNeighbor(x3, y3, point.currMoves)
        addNeighbor(x4, y4, point.currMoves)
    } else {
        addNeighbor(x7, y7, point.currMoves)
        addNeighbor(x8, y8, point.currMoves)
        addNeighbor(x5, y5, point.currMoves)
        addNeighbor(x6, y6, point.currMoves)
    }
}

func addNeighbor(_ x: Int, _ y: Int, _ moves: Int) {
    if visitedPoints.contains("\(x)\(y)") {
        return
    }

    pointsToVisit.add(point: Point(x: x, y: y, currMoves: moves + 1))
}

// Successful
// Time complexity: O(abs(x)*abs(y))
// Space complexity: O(abs(x)*abs(y))
struct Point {
    let x: Int
    let y: Int
    let currMoves: Int
}

class Node {
    let point: Point
    var next: Node?

    init(point: Point) {
        self.point = point
    }
}

class LinkedList {
    var head: Node?
    var tail: Node?

    func add(point: Point) {
        let node = Node(point: point)

        guard let _ = head else {
            head = node
            tail = node
            return
        }

        tail?.next = node
        tail = node
    }

    func removeFirst() -> Node? {
        let currHead = head
        head = currHead?.next
        return currHead
    }

    func peek() -> Bool {
        return head != nil
    }
}

func minKnightMoves(_ x: Int, _ y: Int) -> Int {
    if x == 0 && y == 0 { return 0 }

    let pointsToVisit = LinkedList()
    var visitedPoints = Set<String>()
    let targetX = abs(x)
    let targetY = abs(y)

    pointsToVisit.add(point: Point(x: 0, y: 0, currMoves: 0))
    visitedPoints.insert("0,0")

    while pointsToVisit.peek() {
        guard let node = pointsToVisit.removeFirst() else { continue }

        for neighbor in neighbors(point: node.point) {
            let absX = neighbor.x
            let absY = neighbor.y

            if targetX == absX && targetY == absY {
                return neighbor.currMoves
            }

            let pointToVisit = "\(absX),\(absY)"
            if visitedPoints.contains(pointToVisit) {
                continue
            }

            pointsToVisit.add(point: neighbor)
            visitedPoints.insert(pointToVisit)
        }
    }

    return -1
}

func neighbors(point: Point) -> [Point] {
    let (x1, y1) = (abs(point.x + 1), abs(point.y + 2))
    let (x2, y2) = (abs(point.x + 2), abs(point.y + 1))
    let (x3, y3) = (abs(point.x + 2), abs(point.y - 1))
    let (x4, y4) = (abs(point.x + 1), abs(point.y - 2))
    let (x5, y5) = (abs(point.x - 1), abs(point.y - 2))
    let (x6, y6) = (abs(point.x - 2), abs(point.y - 1))
    let (x7, y7) = (abs(point.x - 2), abs(point.y + 1))
    let (x8, y8) = (abs(point.x - 1), abs(point.y + 2))

    let nextMoves = point.currMoves + 1

    return [
        Point(x: x1, y: y1, currMoves: nextMoves),
        Point(x: x2, y: y2, currMoves: nextMoves),
        Point(x: x3, y: y3, currMoves: nextMoves),
        Point(x: x4, y: y4, currMoves: nextMoves),
        Point(x: x5, y: y5, currMoves: nextMoves),
        Point(x: x6, y: y6, currMoves: nextMoves),
        Point(x: x7, y: y7, currMoves: nextMoves),
        Point(x: x8, y: y8, currMoves: nextMoves)
    ]

}

print(minKnightMoves(1, 1)) // 2
print(minKnightMoves(2, 1)) // 1
print(minKnightMoves(5, 5)) // 4