// https://leetcode.com/explore/interview/card/facebook/52/trees-and-graphs/3022/
/**
A path in a binary tree is a sequence of nodes where each pair of adjacent nodes in the sequence has an edge
connecting them. A node can only appear in the sequence at most once. Note that the path does not need to pass through the root.

The path sum of a path is the sum of the node's values in the path.
Given the root of a binary tree, return the maximum path sum of any non-empty path.
**/

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

    func isLeaf() -> Bool {
        return self.left == nil && self.right == nil
    }
}

class Solution {
    func maxPathSum(_ root: TreeNode?) -> Int {
        let (path, tempPath) = maxPathSumRecursive(root)
        return max(path, tempPath ?? Int.min)
    }

    func maxPathSumRecursive(_ node: TreeNode?) -> (fullPath: Int, tempPath: Int?) {
        guard let node = node else { return (Int.min, nil) }
        if node.isLeaf() { return (node.val, node.val) }

        let (leftFull, leftTemp) = maxPathSumRecursive(node.left)
        let (rightFull, rightTemp) = maxPathSumRecursive(node.right)

        let leftTempMin = (leftTemp ?? Int.min)
        let rightTempMin = (rightTemp ?? Int.min)

        let leftTempZero = (leftTemp ?? 0)
        let rightTempZero = (rightTemp ?? 0)

        let fullPath = [leftFull, rightFull, leftTempZero + node.val + rightTempZero, node.val, leftTempMin, rightTempMin].max() ?? 0
        let tempPath = [max(leftTempMin, rightTempMin) + node.val, node.val].max() ?? 0

        return (fullPath, tempPath)
    }
}