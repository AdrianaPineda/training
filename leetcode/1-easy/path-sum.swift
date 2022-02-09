// https://leetcode.com/problems/path-sum/
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

// accumulator -> leaf
// if leaf => if acc == target,return true
//
/**
                5  // 5
        4  // 9
    11 // 20
7 // 27          2

 */
class Solution {
    // Time complexity: O(n)
    // Space complexity: O(k), k the longest path from root to leaf. Best case => O(log(n)). Worst case => O(n)
    // Option 2
    func hasPathSum(_ node: TreeNode?, _ targetSum: Int) -> Bool {
        guard let node = node else { return false }

        let nextSum = targetSum - node.val
        if node.isLeaf() { return nextSum == 0 }

        return hasPathSum(node.left, nextSum) || hasPathSum(node.right, nextSum)
    }

    // Option 1
    func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        return hasPathSumRecursive(root, targetSum, 0)
    }

    func hasPathSumRecursive(_ node: TreeNode?, _ targetSum: Int, _ acc: Int) -> Bool {
        guard let node = node else { return false }

        let nextAcc = acc + node.val

        if node.isLeaf() { return targetSum == nextAcc }

        return hasPathSumRecursive(node.left, targetSum, nextAcc) || hasPathSumRecursive(node.right, targetSum, nextAcc)
    }
}
