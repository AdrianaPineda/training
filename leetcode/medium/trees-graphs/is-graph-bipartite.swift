// https://leetcode.com/explore/interview/card/facebook/52/trees-and-graphs/3028/
/**
There is an undirected graph with n nodes, where each node is numbered 
between 0 and n - 1. You are given a 2D array graph, where graph[u] 
is an array of nodes that node u is adjacent to. More formally, for 
each v in graph[u], there is an undirected edge between node u and 
node v. The graph has the following properties:

There are no self-edges (graph[u] does not contain u).
There are no parallel edges (graph[u] does not contain duplicate values).
If v is in graph[u], then u is in graph[v] (the graph is undirected).
The graph may not be connected, meaning there may be two nodes u and v 
such that there is no path between them.
A graph is bipartite if the nodes can be partitioned into two independent 
sets A and B such that every edge in the graph connects a node in set A 
and a node in set B.

Return true if and only if it is bipartite

Input: graph = [[1,2,3],[0,2],[0,1,3],[0,2]]
Output: false
Explanation: There is no way to partition the nodes into two
independent sets such that every edge connects a node in one and a node in the other.

Input: graph = [[1,3],[0,2],[1,3],[0,2]]
Output: true
Explanation: We can partition the nodes into two sets: {0, 2} and {1, 3}.

graphMatrix

2 sets

row
    check if row is in any set ()
    loop through columns, check columns are part of the same set (skip if not in any set)

*/

// Time complexity: O(v+e)
// Space complexity: O(n)
// DFS
func isBipartite(_ graph: [[Int]]) -> Bool {
    var nodesSets = [Int: Int]()
    for i in 0..<graph.count {
        if let _ = nodesSets[i] {
            continue
        }

        nodesSets[i] = 1
        var nodes = [i]

        while !nodes.isEmpty {
            let currNode = nodes.removeLast()
            let currentSet = nodesSets[currNode]!
            
            let neighbors = graph[currNode]
            for neighbor in neighbors {
                guard let neighborSet = nodesSets[neighbor] else {
                    nodesSets[neighbor] = currentSet == 1 ? 2 : 1
                    nodes.append(neighbor)
                    continue
                }

                if neighborSet == currentSet {
                    return false
                }
            }
        }

    }

    return true
}