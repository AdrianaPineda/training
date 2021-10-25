// https://leetcode.com/problems/all-paths-from-source-to-target/
/**
Given a directed acyclic graph (DAG) of n nodes labeled from 0 to n - 1,
find all possible paths from node 0 to node n - 1 and return them in any order.

The graph is given as follows: graph[i] is a list of all nodes you can visit
from node i (i.e., there is a directed edge from node i to node graph[i][j]).
*/
    
// Option 1
// Time complexity: O(2^n * n)
// Space complexity: O(2^n * n)
func allPathsSourceTarget(_ graph: [[Int]]) -> [[Int]] {
    var result = [[Int]]()
    allPathsRecursive(graph, 0, [0], &result, graph.count - 1)
    return result
}

func allPathsRecursive(_ graph: [[Int]], _ node: Int, _ nodes:[Int], _ result: inout [[Int]], _ target: Int) {
    if node == target {
        result.append(nodes)
        return
    }

    for child in graph[node] {
        allPathsRecursive(graph, child, nodes + [child], &result, target)
    }
}

// Option 2
// Time complexity: O(2^n * n)
// Space complexity: O(2^n * n)
func allPathsSourceTarget(_ graph: [[Int]]) -> [[Int]] {
    var result = [[Int]]()
    var nodes = [0]
    allPathsRecursive(graph, 0, &nodes, &result, graph.count - 1)
    return result
}

func allPathsRecursive(_ graph: [[Int]], _ node: Int, _ nodes: inout[Int], _ result: inout [[Int]], _ target: Int) {
    if node == target {
        result.append(nodes)
        return
    }

    for child in graph[node] {
        nodes.append(child)
        allPathsRecursive(graph, child, &nodes, &result, target)
        nodes.removeLast()
    }
}

// Option 3 - Memoization
// Time complexity: O(2^n * n)
// Space complexity: O(2^n * n)
func allPathsSourceTarget(_ graph: [[Int]]) -> [[Int]] {
    var cache = [Int: [[Int]]]()
    return allPathsRecursive(graph, 0, graph.count - 1, &cache)
}

func allPathsRecursive(_ graph: [[Int]], _ node: Int, _ target: Int, _ cache: inout [Int: [[Int]]]) -> [[Int]] {
    if let cachedResult = cache[node] {
        return cachedResult
    }

    if node == target {
        return [[node]]
    }

    var result = [[Int]]()
    for child in graph[node] {
        let tempResult = allPathsRecursive(graph, child, target, &cache)
        for temp in tempResult {
            result.append([node] + temp)
        }
    }

    cache[node] = result
    return result
}

print(allPathsSourceTarget([[1,2],[3],[3],[]])) // [[0,1,3],[0,2,3]]
print(allPathsSourceTarget([[4,3,1],[3,2,4],[3],[4],[]])) // [[0,4],[0,3,4],[0,1,3,4],[0,1,2,3,4],[0,1,4]]