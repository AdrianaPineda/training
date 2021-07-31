// https://leetcode.com/explore/interview/card/top-interview-questions-easy/94/trees/625/
// Given the root of a binary tree, determine if it is a valid binary search tree (BST).
// A valid BST is defined as follows:

// The left subtree of a node contains only nodes with keys less than the node's key.
// The right subtree of a node contains only nodes with keys greater than the node's key.
//Both the left and right subtrees must also be binary search trees.

// Time complexity: O(n)
// Space complexity: O(k), k being the largest depth of the tree, worst case O(n)

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

func isValidBST(_ root: TreeNode?) -> Bool {
    return isValidBSTRecursive(node: root, lowerBound: -Int.max, upperBound: Int.max)
}

func isValidBSTRecursive(node: TreeNode?, lowerBound: Int, upperBound: Int) -> Bool {
    guard let node = node else { return true }

    guard lowerBound < node.val, node.val < upperBound else { return false }

    let isValidLeftTree = isValidBSTRecursive(node: node.left, lowerBound: lowerBound, upperBound: node.val)
    guard isValidLeftTree else { return false }

    let isValidRightTree = isValidBSTRecursive(node: node.right, lowerBound: node.val, upperBound: upperBound)
    guard isValidRightTree else { return false }

    return true
}

func isValidBSTRecursiveAlt(node: TreeNode?, lowerBound: Int, upperBound: Int) -> Bool {
    guard let node = node else { return true }

     guard lowerBound < node.val, node.val < upperBound else { return false }

    let isValidLeftTree = isValidBSTRecursive(node: node.left, lowerBound: lowerBound, upperBound: node.val)
    let isValidRightTree = isValidBSTRecursive(node: node.right, lowerBound: node.val, upperBound: upperBound)

    return isValidLeftTree && isValidRightTree
}

let rootNode = TreeNode(5)
rootNode.left = TreeNode(4)
rootNode.right = TreeNode(7)
rootNode.right?.left = TreeNode(2)
rootNode.right?.right = TreeNode(8)

print(isValidBST(rootNode))