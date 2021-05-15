// Check Balanced: Implement a function to check if a binary tree is balanced. For the purposes of
// this question, a balanced tree is defined to be a tree such that the heights of the two subtrees of any
// node never differ by more than one.

struct Node {
    var left: Node?
    var right: Node?
}

// Option 1: get height
// Time complexity: O(n)
// Space complexity: O(H), being H the largest depth of the tree
func isBalanced(node: Node?) -> Bool {
    let leftHeight = getHeight(node?.left)
    let rightHeight = getHeight(node?.right)

    return abs(leftHeight - rightHeight) <= 1
}

func getHeight(node: Node?) -> Int {
    guard let node = node else { return 0 }

    let leftHeight = getHeight(node: node.left)
    let rightHeight = getHeight(node: node.right)

    return max(leftHeight, rightHeight) + 1
}

// Option 2: break on height pivot
// Time complexity: O(n)
// Space complexity: O(H), being H the largest depth of the tree
func isBalanced(node: Node?) -> Bool {
    return isBalanced(node: node, depth: 0)
}

var maxHeight = Int.max
func isBalanced(node: Node?, depth: Int) -> Bool {
    if depth - maxHeight > 1 {
        return false
    }

    guard let node = node else {
        maxHeight = min(maxHeight, depth)
        return true
    }

    let leftHeight = isBalanced(node: node.left, depth: depth + 1)
    let rightHeight = isBalanced(node: node.right, depth: depth + 1)

    return leftHeight && rightHeight
}

var node_1 = Node()
var node_2 = Node()
var node_3 = Node()
var node_4 = Node()
var node_5 = Node()
var node_6 = Node()
var node_7 = Node()
var node_8 = Node()
var node_9 = Node()
var node_10 = Node()
var node_11 = Node()
var node_12 = Node()
var node_13 = Node()

// Not balanced:
//node_1.left = node_2
//node_1.right = node_3
//node_3.right = node_4
//node_4.right = node_5
//node_5.right = node_6

// Balanced:
node_1.left = node_2
node_1.right = node_7
node_2.left = node_3
node_2.right = node_6
node_3.left = node_4
node_3.right = node_5
node_7.left = node_8
node_7.right = node_9

print(isBalanced(node: node_1)
