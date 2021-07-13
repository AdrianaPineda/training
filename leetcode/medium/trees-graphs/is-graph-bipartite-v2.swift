/**

hash table: 
    0 -> A
    1 -> B

node -> A/B
    connected_nodes => B/A

*/

// DFS loop
func isBipartite(_ graph: [[Int]]) -> Bool {
    var groups = [Int: String]()
    var visited = Set<Int>()

    for i in 0..<graph.count {
        setNodeGroup(i: i, nodeGroup: &groups)
        var nextNodes = [i]

        while !nextNodes.isEmpty {
            let nextNode = nextNodes.removeLast()

            if visited.contains(nextNode) {
                continue
            }

            let currentGroup = groups[nextNode]
            let connectNodesGroup = currentGroup == "B" ? "A" : "B"

            for connectedNode in graph[nextNode] {

                defer {
                    nextNodes.append(connectedNode)
                }

                guard let connectedGroup = groups[connectedNode] else {
                    groups[connectedNode] = connectNodesGroup
                    continue
                }

                if connectedGroup != connectNodesGroup {
                    return false
                }
            }

            visited.insert(nextNode)
        }

    }

    return true
}


func setNodeGroup(i: Int, nodeGroup: inout [Int: String]) {
    if let _ = nodeGroup[i] {
        return
    }

    nodeGroup[i] = "A"
}

func isBipartite(_ graph: [[Int]]) -> Bool {
    var groups = [Int: String]()

    for i in 0..<graph.count {
        if let _ = groups[i] { continue }
        groups[i] = "A"

        var nextNodes = [i]

        while !nextNodes.isEmpty {
            let nextNode = nextNodes.removeLast()
            let currentGroup = groups[nextNode]
            let connectNodesGroup = currentGroup == "B" ? "A" : "B"

            for connectedNode in graph[nextNode] {
                guard let connectedGroup = groups[connectedNode] else {
                    groups[connectedNode] = connectNodesGroup
                    nextNodes.append(connectedNode)
                    continue
                }

                if connectedGroup != connectNodesGroup {
                    return false
                }
            }
        }

    }

    return true
}

func isBipartite(_ graph: [[Int]]) -> Bool {
    var groups = [Int: String]()

    for i in 0..<graph.count {
        if let _ = groups[i] { continue }
        let result = isBipartiteRecursive(i: i, graph: graph, groups: &groups, expectedGroup: "A")
        if !result { return false }
    }

    return true
}

func isBipartiteRecursive(i: Int, graph: [[Int]], groups: inout [Int: String], expectedGroup: String) -> Bool {
    if let currGroup = groups[i] { return currGroup == expectedGroup }

    groups[i] = expectedGroup

    let neighborsGroup = expectedGroup == "A" ? "B" : "A"
    for node in graph[i] {
        let result = isBipartiteRecursive(i: node, graph: graph, groups: &groups, expectedGroup: neighborsGroup)
        if !result { return false }
    }

    return true
}

print(isBipartite([[1,2,3],[0,2],[0,1,3],[0,2]])) // false
print(isBipartite([[1,3],[0,2],[1,3],[0,2]])) // true
print(isBipartite([[1],[0,3],[3],[1,2]])) // true