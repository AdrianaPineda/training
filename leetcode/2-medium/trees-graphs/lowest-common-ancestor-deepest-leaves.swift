// https://leetcode.com/problems/lowest-common-ancestor-of-deepest-leaves/
// https://leetcode.com/problems/smallest-subtree-with-all-the-deepest-nodes/
/**
Given the root of a binary tree, return the lowest common ancestor of its deepest leaves.

Recall that:

The node of a binary tree is a leaf if and only if it has no children
The depth of the root of the tree is 0. if the depth of a node is d, the depth of each of its children is d + 1.
The lowest common ancestor of a set S of nodes, is the node A with the largest depth such that every node in S is in the subtree with root A.
Note: This question is the same as 865: https://leetcode.com/problems/smallest-subtree-with-all-the-deepest-nodes/
**/

// Which are the deepest leaves => highest depth
// LCA of all nodes
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

// Time complexity: O(n^2)
// Space complexity: O(n)
class Solution {
    func lcaDeepestLeaves(_ root: TreeNode?) -> TreeNode? {
        let deepestLevel = getDeepestLevel(root) // O(n), O(n)
        var nodes = [TreeNode]()
        getDeepestLeaves(root, deepestLevel, 1, &nodes) // O(n), O(n)
        nodes.map { print($0.val) }

        return getParent(root: root, deepestLeaves: nodes) // O(n^2)
    }

    func getParent(root: TreeNode?, deepestLeaves: [TreeNode]) -> TreeNode? {
        var parent = root
        var nodesToCheck = [root]
        while !nodesToCheck.isEmpty {
            let parentNode = nodesToCheck.removeLast() // O(1)
            let parentFound = isParentNode(parent: parentNode, nodes: deepestLeaves)
            guard parentFound else { continue }

            parent = parentNode

            if let leftNode = parentNode?.left {
                nodesToCheck.append(leftNode) // O(1)
            }

            if let rightNode = parentNode?.right {
                nodesToCheck.append(rightNode)
            }
        }

        return parent
    }

    func isParentNode(parent: TreeNode?, nodes: [TreeNode]) -> Bool {
        for node in nodes {
            guard isParent(node: parent, child: node) else {
                return false
            }
        }

        return true
    }

    func getDeepestLevel(_ node: TreeNode?) -> Int {
        guard let node = node else {
            return 0
        }

        let leftNodeLevel = getDeepestLevel(node.left)
        let rightNodeLevel = getDeepestLevel(node.right)

        return max(leftNodeLevel, rightNodeLevel) + 1
    }

    func getDeepestLeaves(_ node: TreeNode?, _ deepestLevel: Int, _ level: Int, _ nodes: inout [TreeNode]) {
        guard let node = node else { return }

        if level == deepestLevel {
            nodes.append(node)
            return
        }

        getDeepestLeaves(node.left, deepestLevel, level + 1, &nodes)
        getDeepestLeaves(node.right, deepestLevel, level + 1, &nodes)
    }

    func isParent(node: TreeNode?, child: TreeNode?) -> Bool {
        guard let node = node, let child = child else { return false }

        if node.val == child.val { return true }

        return isParent(node: node.left, child: child) || isParent(node: node.right, child: child)

    }
}

// Alt
// Time complexity: O(n)
// Space complexity: O(n)
class Solution {
    func lcaDeepestLeaves(_ root: TreeNode?) -> TreeNode? {
        let deepestLevel = getDeepestLevel(root) // O(n), O(n)
        return getCommonParent(root, 1, deepestLevel) // O(n), O(n)
    }

    func getDeepestLevel(_ node: TreeNode?) -> Int {
        guard let node = node else {
            return 0
        }

        let leftNodeLevel = getDeepestLevel(node.left)
        let rightNodeLevel = getDeepestLevel(node.right)

        return max(leftNodeLevel, rightNodeLevel) + 1
    }

    func getCommonParent(_ node: TreeNode?, _ level: Int, _ maxLevel: Int) -> TreeNode? {
        guard let node = node else { return nil }

        if level == maxLevel { return node }

        let rightParent = getCommonParent(node.right, level + 1, maxLevel)
        let leftParent = getCommonParent(node.left, level + 1, maxLevel)

        if rightParent != nil && leftParent != nil { return node }

        return rightParent ?? leftParent
    }
}


let root = TreeNode(3)
let five = TreeNode(5)
let one = TreeNode(1)
let six = TreeNode(6)
let two = TreeNode(2)
let zero = TreeNode(0)
let eight = TreeNode(8)
let seven = TreeNode(7)
let four = TreeNode(4)

root.left = five
root.right = one

five.left = six
five.right = two

one.left = zero
one.right = eight

// Comment the next 2 lines, result should be 3
two.left = seven
two.right = four

let solution = Solution()
print(solution.lcaDeepestLeaves(root)?.val) // 2