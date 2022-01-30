// https://leetcode.com/explore/interview/card/facebook/52/trees-and-graphs/291/
// Time complexity: O(n), n being the nodes
// Space complexity: O(k), k being the largest depth, n in the worst case
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

class Solution {
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        let (depth, diam) = diameterAndDepth(root)
        return max(depth - 1, diam)
    }

    func diameterAndDepth(_ node: TreeNode?) -> (depth: Int, diam: Int) {
        guard let node = node else { return (0, 0) }

        let (leftNodeDepth, leftNodeDiam) = diameterAndDepth(node.left)
        let (rightNodeDepth, rightNodeDiam) = diameterAndDepth(node.right)

        let nodesDiam = max(leftNodeDiam, rightNodeDiam)
        let depth = max(leftNodeDepth, rightNodeDepth) + 1
        let diam = max(leftNodeDepth + rightNodeDepth, nodesDiam)

        return (depth, diam)
    }
}
