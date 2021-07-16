// https://leetcode.com/explore/interview/card/facebook/52/trees-and-graphs/291/
/**
Given the root of a binary tree, return the length of the diameter of the tree.

The diameter of a binary tree is the length of the longest path between any two
nodes in a tree. This path may or may not pass through the root.

The length of a path between two nodes is represented by the number of edges between them.

Example 1:
Input: root = [1,2,3,4,5]
    Output: 3
    Explanation: 3is the length of the path [4,2,1,3] or [5,2,1,3].

Example 2:
    Input: root = [1,2]
    Output: 1
*/
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

// Time complexity: O(n), n the number of nodes
// Space complexity: O(k), k the longest path in the tree => n
func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
    var diameter = 0
    let _ = depth(node: root, diameter: &diameter)
    return diameter
}

func depth(node: TreeNode?, diameter: inout Int) -> Int {
    guard let node = node else {
        return 0
    }

    let leftSide = depth(node: node.left, diameter: &diameter)
    let rightSide = depth(node: node.right, diameter: &diameter)
    diameter = max(diameter, leftSide + rightSide)
    return max(leftSide, rightSide) + 1
}

// Print the path
// Extra space needed
func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
    var diameter = 0
    var diameterPath = [Int]()
    let _ = depth(node: root, diameter: &diameter, diameterPath: &diameterPath)
    return diameter
}

func depth(node: TreeNode?, diameter: inout Int, diameterPath: inout [Int]) -> (Int, [Int]) {
    guard let node = node else {
        return (0, [])
    }

    let (leftSide, leftArray) = depth(node: node.left, diameter: &diameter, diameterPath: &diameterPath)
    let (rightSide, rightArray) = depth(node: node.right, diameter: &diameter, diameterPath: &diameterPath)

    let currDiameter = leftSide + rightSide

    if currDiameter > diameter {
        diameter = currDiameter
        diameterPath = leftArray + rightArray + [node.val]
    }

    let path = leftSide > rightSide ? leftArray : rightArray
    return (max(leftSide, rightSide) + 1, path)
}
