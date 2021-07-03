// Number of Visible Nodes
/**
There is a binary tree with N nodes. You are viewing the tree from 
its left side and can see only the leftmost nodes at each level. 
Return the number of visible nodes.

Note: You can see only the leftmost nodes, but that doesn't mean 
they have to be left nodes. The leftmost node at a level could be a right node.

Signature
int visibleNodes(Node root) {

Input
The root node of a tree, where the number of nodes is between 1 and 1000, 
and the value of each node is between 0 and 1,000,000,000

Output
An int representing the number of visible nodes.

DFS
-> left - right

*/

class Node {
  let data: Int
  let left: Node?
  let right: Node?
    
  init(_ data: Int, left: Node? = nil, right: Node? = nil) {
    self.data = data
    self.left = left
    self.right = right
  }
}

// Time complexity: O(n), n being the number of nodes
// Space complexity: O(k), k the largest path, worst case is n
private extension Node {
  // Add any helper functions you may need here
  func visibleNodesRecursive(node: Node?, level: Int, depth: inout Int) {
    guard let node = node else {
      return
    }
    
    depth = max(level, depth)
    
    visibleNodesRecursive(node: node.left, level: (level + 1), depth: &depth)
    visibleNodesRecursive(node: node.right, level: (level + 1), depth: &depth)
  }

  var visibleNodes: Int {
    // Write your code here
    var depth = 0
    visibleNodesRecursive(node: self, level: 1, depth: &depth)
    return depth
  }
}

// Alt
// Time complexity: O(n), n being the number of nodes
// Space complexity: O(k), k the largest path, worst case is n
private extension Node {
  // Add any helper functions you may need here
  func visibleNodesRecursive(node: Node?, level: Int, levelNodes: inout [Int: Int]) {
    guard let node = node else {
      return
    }
    
    if levelNodes[level] == nil {
      levelNodes[level] = node.data
    }
    
    visibleNodesRecursive(node: node.left, level: (level + 1), levelNodes: &levelNodes)
    visibleNodesRecursive(node: node.right, level: (level + 1), levelNodes: &levelNodes)
  }

  // no need to check nil, if we go to the right node first
  func visibleNodesRecursiveAlt(node: Node?, level: Int, levelNodes: inout [Int: Int]) {
    guard let node = node else {
      return
    }
    
    levelNodes[level] = node.data
    
    visibleNodesRecursive(node: node.right, level: (level + 1), levelNodes: &levelNodes)
    visibleNodesRecursive(node: node.left, level: (level + 1), levelNodes: &levelNodes)
  }

  var visibleNodes: Int {
    // Write your code here
    var levelNodes = [Int: Int]()
    visibleNodesRecursive(node: self, level: 1, levelNodes: &levelNodes)
    return levelNodes.keys.count
  }
}
