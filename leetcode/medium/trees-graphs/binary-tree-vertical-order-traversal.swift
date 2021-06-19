// https://leetcode.com/explore/interview/card/facebook/52/trees-and-graphs/298/
// Given the root of a binary tree, return the vertical order traversal of its 
// nodes' values. (i.e., from top to bottom, column by column).
// If two nodes are in the same row and column, the order should be from left to right.

/**
                3
            /         \
        9             8
      /       \     /    \
    4           0  1       7
              /  \
        2              9

    -2  -1  -1   1   0     1   2


    [[4],[9],[3,0,1],[8],[7]]


    column number hash table
        0    =>  [3, 0, 1]
        -1   =>  [9]
        -2   =>  [4]
        1    =>  [8]
        2    =>  [7]

    min column = -2
    max column = 2

    -2 ... 2
*/


// Definition for a binary tree node.
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

// Time complexity: 2^depth + n*log(n) (sort) =>  O(n) + O(n*log(n)) =>  O(n*log(n))
// Space complexity: O(n)
func verticalOrder(_ root: TreeNode?) -> [[Int]] {
    var results = [[Int]]()
    guard let root = root else {
        return results
    }

    var nodesAtColumn = [Int: [Int]]()
    var queue = [(TreeNode, Int)]()
    queue.append((root, 0))

    while !queue.isEmpty {
        let (node, column) = queue.removeFirst() // O(k), k the current number of elements at the queue
        updatedNodesAtColumn(node: node, columnNum: column, nodesAtColumn: &nodesAtColumn)

        if let leftNode = node.left {
            queue.append((leftNode, column - 1)) // O(1)
        }

        if let rightNode = node.right {
            queue.append((rightNode, column + 1)) // O(1)
        }
    }

    let sortedKeys = nodesAtColumn.keys.sorted()
    for key in sortedKeys {
        if let nodes = nodesAtColumn[key] {
            results.append(nodes)
        }
    }

    return results
}

func updatedNodesAtColumn(node: TreeNode?, columnNum: Int, nodesAtColumn: inout [Int:[Int]]) {
    guard let node = node else {
        return
    }

    var currentNodes = [Int]()
    if let nodesAtCurrentColumn = nodesAtColumn[columnNum] {
        currentNodes = nodesAtCurrentColumn
    }

    currentNodes.append(node.val) // O(m), m the current number of nodes at column => n^2?
    nodesAtColumn[columnNum] = currentNodes
}

func updatedNodesAtColumn(node: TreeNode?, columnNum: Int, nodesAtColumn: inout [Int:[Int]]) {
    guard let node = node else {
        return
    }

    if let _ = nodesAtColumn[columnNum] {
        nodesAtColumn[columnNum]?.append(node.val)
    } else {
        nodesAtColumn[columnNum] = [node.val]
    }
}

// Alt
// Time complexity: 2^depth =>  O(n)
// Space complexity: O(n)
func verticalOrder(_ root: TreeNode?) -> [[Int]] {
    var results = [[Int]]()
    guard let root = root else {
        return results
    }

    var nodesAtColumn = [Int: [Int]]()
    var queue = [(TreeNode, Int)]()
    queue.append((root, 0))

    var minColumn = 0
    var maxColumn = 0

    while !queue.isEmpty {
        let (node, column) = queue.removeFirst() // O(k), k the current number of elements at the queue
        updatedNodesAtColumn(node: node, columnNum: column, nodesAtColumn: &nodesAtColumn)

        minColumn = min(column, minColumn)
        maxColumn = max(column, maxColumn)

        if let leftNode = node.left {
            queue.append((leftNode, column - 1)) // O(1)
        }

        if let rightNode = node.right {
            queue.append((rightNode, column + 1)) // O(1)
        }
    }

    for i in minColumn...maxColumn {
        if let nodes = nodesAtColumn[i] {
            results.append(nodes)
        }
    }

    return results
}

func updatedNodesAtColumn(node: TreeNode, columnNum: Int, nodesAtColumn: inout [Int:[Int]]) {
    if let _ = nodesAtColumn[columnNum] {
        nodesAtColumn[columnNum]?.append(node.val) // O(1) on average
    } else {
        nodesAtColumn[columnNum] = [node.val]
    }
}

let three = TreeNode(3)
let nine = TreeNode(9)
let four = TreeNode(4)
let zero = TreeNode(0)
let one = TreeNode(1)
let eight = TreeNode(8)
let seven = TreeNode(7)

three.left = nine
three.right = eight
nine.left = four
nine.right = zero
eight.left = one
eight.right = seven

print(verticalOrder(three)) // [[4],[9],[3,0,1],[8],[7]]


let three = TreeNode(3)
let nine = TreeNode(9)
let four = TreeNode(4)
let zero = TreeNode(0)
let one = TreeNode(1)
let eight = TreeNode(8)
let seven = TreeNode(7)
let five = TreeNode(5)
let two = TreeNode(2)

three.left = nine
three.right = eight
nine.left = four
nine.right = zero
eight.left = one
eight.right = seven
zero.right = two
one.left = five

print(verticalOrder(three)) // [[4],[9,5],[3,0,1],[8,2],[7]]