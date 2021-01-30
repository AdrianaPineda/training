// Write code to remove duplicates from an unsorted linked list
// Follow up: How would you solve this problem if a temporary buffer is not allowed?

// Using a hash table
// Time complexity: O(n)
// Space complexity: O(n)

class Node {
    let data: Int
    var next: Node?

    init(data: Int) {
        self.data = data
    }
}

func removeDuplicates(node: Node) {
    var dataOcurrences = [Int: Bool]()
    var previousNode: Node? = nil
    var currentNode: Node? = node

    while let uwCurrentNode = currentNode {
        defer {
            currentNode = uwCurrentNode.next
        }

        guard let _ = dataOcurrences[uwCurrentNode.data] else {
            dataOcurrences[uwCurrentNode.data] = true
            previousNode = currentNode
            continue
        }

        previousNode?.next = uwCurrentNode.next
    }
}

// Without extra space
// Time complexity: O(n^2)
// Space complexity: O(1)
func removeDuplicates(node: Node) {
    var currentNode: Node? = node

    while let uwCurrentNode = currentNode {
        var runnerNode = currentNode
        while let uwNextNode = runnerNode?.next {
            if uwNextNode.data == uwCurrentNode.data {
                runnerNode?.next = uwNextNode.next
            } else {
                runnerNode = uwNextNode
            }
        }

        currentNode = uwCurrentNode.next
    }
}


let node_1 = Node(data: 1)
let node_2 = Node(data: 3)
let node_3 = Node(data: 1)
let node_4 = Node(data: 3)

node_1.next = node_2
node_2.next = node_3
node_3.next = node_4

print("\(node_1.data) - \(node_1.next?.data) - \(node_1.next?.next?.data) - \(node_1.next?.next?.next?.data)")
removeDuplicates(node: node_1)
print("\(node_1.data) - \(node_1.next?.data) - \(node_1.next?.next?.data)")