// Given a sorted (increasing order) array with unique integer elements, write an algorithm to create
// a binary search tree with minimal height

// Time complexity: O(n)
// Space complexity: O(n)

class Node {
    let data: Int
    var leftNode: Node?
    var rightNode: Node?

    init(data: Int) {
        self.data = data
    }
}

func binaryTree(array: [Int]) -> Node? {
    if array.isEmpty {
        return nil
    }

    if array.count == 1 {
        let value = array[0]
        return Node(data: value)
    }

    let middleIndex: Int = (array.count - 1) / 2
    let value = array[middleIndex]
    let rootNode = Node(data: value)

    let leftArray = array[0..<middleIndex]
    if let leftNode = binaryTree(array: Array(leftArray)) {
        rootNode.leftNode = leftNode
    }

    let rightArray = array[middleIndex + 1..<array.count]
    if let rightNode = binaryTree(array: Array(rightArray)) {
        rootNode.rightNode = rightNode
    }

    return rootNode
}

func binaryTreeAlt(array: [Int]) -> Node? {
    if array.isEmpty {
        return nil
    }

    let middleIndex: Int = (array.count - 1) / 2
    let value = array[middleIndex]
    let rootNode = Node(data: value)

    let leftArray = array[0..<middleIndex]
    let leftNode = binaryTree(array: Array(leftArray))
    rootNode.leftNode = leftNode

    let rightArray = array[middleIndex + 1..<array.count]
    let rightNode = binaryTree(array: Array(rightArray))
    rootNode.rightNode = rightNode

    return rootNode
}

// Time complexity: O(log(n))
// Space complexity: O(log(n))
func binaryTreeAlt2(array: [Int], start: Int, end: Int) -> Node? {
    if start > end {
        return nil
    }

    let middleIndex: Int = (end + start) / 2 // start + (end - start) / 2
    let value = array[middleIndex]
    let rootNode = Node(data: value)

    if let leftNode = binaryTree(array: array, start: start, end: middleIndex - 1) {
        rootNode.leftNode = leftNode
    }

    if let rightNode = binaryTree(array: array, start: middleIndex + 1, end: end) {
        rootNode.rightNode = rightNode
    }

    return rootNode
}

//let rootNode = binaryTree(array: [0, 1, 2, 3, 4, 5, 6, 7, 8])
let rootNode = binaryTree(array: [0, 1, 2, 3, 4, 5, 6, 7])
print(rootNode?.data)
print(rootNode?.leftNode?.data)
print(rootNode?.leftNode?.leftNode?.data)
print(rootNode?.leftNode?.rightNode?.data)
print(rootNode?.leftNode?.rightNode?.rightNode?.data)
print(rootNode?.leftNode?.rightNode?.leftNode?.data)

print(rootNode?.rightNode?.data)
print(rootNode?.rightNode?.leftNode?.data)
print(rootNode?.rightNode?.rightNode?.data)
print(rootNode?.rightNode?.rightNode?.rightNode?.data)
print(rootNode?.rightNode?.rightNode?.leftNode?.data)