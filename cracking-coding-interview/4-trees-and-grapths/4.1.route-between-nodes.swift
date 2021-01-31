// Given a directed graph and two nodes (S and E), design and algorith to find out
// whether there is a route from S to E

// With BFS
// Time complexity: O()
// Space complexity: O()
struct Queue<T> {
    private var array = [T]()

    var isEmpty: Bool {
        get {
            return array.isEmpty
        }
    }

    mutating func enqueue(element: T) {
        array.append(element)
    }

    mutating func dequeue() -> T? {
        return isEmpty ? nil : array.removeFirst()
    }
}

class Node {
    let data: Int
    var visited = false
    var neighbors: [Node] = [Node]()

    init(data: Int) {
        self.data = data
    }

    func visit() {
        self.visited = true
    }
}

func isThereRoute(from startNode: Node, to endNode: Node) -> Bool {
    var queue = Queue<Node>()
    queue.enqueue(element: startNode)
    startNode.visit()

    while !queue.isEmpty {
        guard let currentNode = queue.dequeue() else { continue }

        for neighbor in currentNode.neighbors {
            if neighbor.visited { continue }

            if neighbor.data == endNode.data {
                return true
            }

            queue.enqueue(element: neighbor)
            neighbor.visit()
        }
    }

    return false
}

// With DFS
func isThereRoute(from node: Node, to endNode: Node) -> Bool {
    if node.data == endNode.data {
        return true
    }

    for neighbor in node.neighbors {
        if neighbor.visited { continue }
        neighbor.visit()

        let isRoute = isThereRoute(from: neighbor, to: endNode)
        if isRoute {
            return true
        }
    }

    return false
}


var node_1 = Node(data: 1)
var node_2 = Node(data: 2)
var node_3 = Node(data: 3)
var node_4 = Node(data: 4)
var node_5 = Node(data: 5)
var node_6 = Node(data: 6)
var node_7 = Node(data: 7)

node_1.neighbors = [node_2, node_3]
node_2.neighbors = [node_4]
node_3.neighbors = [node_4, node_5]
node_4.neighbors = [node_5, node_6]
node_5.neighbors = [node_4]

print(isThereRoute(from: node_1, to: node_7))