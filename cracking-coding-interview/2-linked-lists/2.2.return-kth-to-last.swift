// Implement an algorithm to find the kth to last element of a singly linked list

// Without extra space
// Time complexity: O(n)
// Space complexity: O(1)
class Node {
    let data: Int
    var next: Node?

    init(data: Int) {
        self.data = data
    }
}

func getNodeCount(node: Node) -> Int {
    var counter = 0
    var currentNode: Node? = node
    while let uwNode = currentNode {
        counter += 1
        currentNode = uwNode.next
    }

    return counter
}

func kthToLast(kth: Int, node: Node) -> Node? {
    // Get total number of nodes
    let numberOfNodes = getNodeCount(node: node)

    // Find kth to last
    let indexToFind = numberOfNodes - kth
    var currentIndex = 1
    var currentNode: Node? = node
    while currentIndex < indexToFind {
        currentNode = currentNode?.next
        currentIndex += 1
    }

    return currentNode
}

// With recursion
// Time complexity: O(n)
// Space complexity: O(n)
class Node {
    let data: Int
    var next: Node?

    init(data: Int) {
        self.data = data
    }
}

func kthToLast(kth: Int, node: Node) -> Node? {
    var index = 0
    return kthToLastRecursively(kth: kth, node: node, index: &index)
}

func kthToLastRecursively(kth: Int, node: Node?, index: inout Int) -> Node? {
    guard let node = node else {
        return nil
    }

    let kthNode = kthToLastRecursively(kth: kth, node: node.next, index: &index)
    index += 1

    if index == kth {
        return node
    }

    return kthNode
}

let node_1 = Node(data: 1)
let node_2 = Node(data: 2)
let node_3 = Node(data: 3)
let node_4 = Node(data: 4)

node_1.next = node_2
node_2.next = node_3
node_3.next = node_4

print(kthToLast(kth: 1, node: node_1)?.data)
