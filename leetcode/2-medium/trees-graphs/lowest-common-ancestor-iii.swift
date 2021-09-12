/**
https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree-iii/

Given two nodes of a binary tree p and q, return their lowest common ancestor (LCA).
Each node will have a reference to its parent node. The definition for Node is below:
class Node {
    public int val;
    public Node left;
    public Node right;
    public Node parent;
}

According to the definition of LCA on Wikipedia: "The lowest common ancestor of two
nodes p and q in a tree T is the lowest node that has both p and q as descendants
(where we allow a node to be a descendant of itself)."
*/

class Node {
    var val: Int = 0
    var left: Node?
    var right: Node?
    var parent: Node?
}

// Time complexity: O(n^2)
// Space complexity: O(n)
func lowestCommonAncestor(_ p: Node?,_ q: Node?) -> Node? {
    let pParents = getParents(p)
    for parent in pParents {
        guard isParent(q, parent) else { continue }
        return parent
    }

    return nil
}

func getParents(_ node: Node?) -> [Node] {
    var parents = [Node]()
    var currNode = node
    while let nodeUW = currNode {
        parents.append(nodeUW)
        currNode = nodeUW.parent
    }

    return parents
}

func isParent(_ node: Node?, _ parent: Node) -> Bool {
    guard let node = node else { return false }
    if node.val == parent.val { return true }
    return isParent(node.parent, parent)
}

// Alt
// Time complexity: O(n)
// Space complexity: O(n)
func lowestCommonAncestor(_ p: Node?,_ q: Node?) -> Node? {
    let pParents = getParents(p)
    var currNode = q
    while let qUW = currNode {
        guard pParents.contains(qUW.val) else {
            currNode = qUW.parent
            continue
        }
        return qUW
    }

    return nil
}

func getParents(_ node: Node?) -> Set<Int> {
    var parents = Set<Int>()
    var currNode = node
    while let nodeUW = currNode {
        parents.insert(nodeUW.val)
        currNode = nodeUW.parent
    }

    return parents
}