// https://leetcode.com/explore/interview/card/facebook/52/trees-and-graphs/277/
/**
Given a reference of a node in a connected undirected graph.

Return a deep copy (clone) of the graph.

Each node in the graph contains a value (int) and a list (List[Node]) of its neighbors.

class Node {
    public int val;
    public List<Node> neighbors;
}
 

Test case format:

For simplicity, each node's value is the same as the node's index (1-indexed). 
For example, the first node with val == 1, the second node with val == 2, and so on. 
The graph is represented in the test case using an adjacency list.

An adjacency list is a collection of unordered lists used to represent a finite graph. 
Each list describes the set of neighbors of a node in the graph.

The given node will always be the first node with val = 1. You must return the copy of 
the given node as a reference to the cloned graph.
*/

/**
hash table of nodes
1: Node <=
2: Node

visitedNodes
1
2
3
...

Node1 -> array

loop while array not empty
    node, check if in visited
    if is -> continue
    
    cloneNode -> hash table
    visited: node
    add neighbors to array, add to clone Node

return hashTable[Node1.val]
*/

public class Node {
    public var val: Int
    public var neighbors: [Node?]
    public init(_ val: Int) {
        self.val = val
        self.neighbors = []
    }
}

// Time complexity: O(n+e), n being the number of nodes and e the edges in the graph
// Space complexity: O(n)
func cloneGraph(_ node: Node?) -> Node? {
    guard let firstNode = node else {
        return nil
    }

    var cloneNodesDict = [Int: Node]()
    var visitedNodes = Set<Int>()
    var nodesStack = [firstNode]

    while !nodesStack.isEmpty {
        let nextNode = nodesStack.removeLast() // O(1)
        if visitedNodes.contains(nextNode.val) {
            continue
        }

        let clonedNode = getClonedNode(val: nextNode.val, cloneNodesDict: &cloneNodesDict)

        for neighbor in nextNode.neighbors {
            guard let neighbor = neighbor else { continue }
            let neighborClone = getClonedNode(val: neighbor.val, cloneNodesDict: &cloneNodesDict)
            clonedNode.neighbors.append(neighborClone)
            nodesStack.append(neighbor)
        }

        visitedNodes.insert(nextNode.val)
    }

    return cloneNodesDict[firstNode.val]
}

func getClonedNode(val: Int, cloneNodesDict: inout [Int: Node]) -> Node {
    if let clonedNode = cloneNodesDict[val] {
        return clonedNode
    }
    
    let clonedNode = Node(val)
    cloneNodesDict[val] = clonedNode

    return clonedNode
}

// Without visited set
func cloneGraphAlt(_ node: Node?) -> Node? {
    guard let firstNode = node else {
        return nil
    }

    var cloneNodesDict = [Int: Node]()
    var nodesStack = [firstNode]
    
    cloneNodesDict[firstNode.val] = Node(firstNode.val)

    while !nodesStack.isEmpty {
        let nextNode = nodesStack.removeLast()

        guard let clonedNode = cloneNodesDict[nextNode.val] else {
            continue
        }

        for neighbor in nextNode.neighbors {
            guard let neighbor = neighbor else { continue }

            if let neighborClone = cloneNodesDict[neighbor.val] {
                clonedNode.neighbors.append(neighborClone)
                continue
            }
            
            let neighborClone = Node(neighbor.val)
            nodesStack.append(neighbor)
            clonedNode.neighbors.append(neighborClone)
            cloneNodesDict[neighbor.val] = neighborClone
        }
    }

    return cloneNodesDict[firstNode.val]
}

// Recursive
// Time complexity: O(n+e), n being the number of nodes and e the edges in the graph
// Space complexity: O(n)
var nodesDic = [Int: Node]()
func cloneGraph(_ node: Node?) -> Node? {
    guard let node = node else {
        return nil
    }

    if let clonedNode = nodesDic[node.val] {
        return clonedNode
    }

    let clonedNode = Node(node.val)
    nodesDic[node.val] = clonedNode

    for neighbor in node.neighbors {
        guard let neighbor = neighbor else { continue }
        clonedNode.neighbors.append(cloneGraph(neighbor))
    }

    return clonedNode
}