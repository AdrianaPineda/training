// https://leetcode.com/problems/number-of-provinces/

/**
- loop half the matrix (upper half)

    a - b - c
     \     /
        f
    
    d - e

- visitedNodes hash table    
*/
// Time complexity: O(V^2)
// Space complexity: O(V)
func findCircleNum(_ isConnected: [[Int]]) -> Int {
    var provinces = 0
    var visited = Set<Int>()

    for i in 0..<isConnected.count {
        if visited.contains(i) {
            continue
        }

        var nodesToVisit = [Int]()
        nodesToVisit.append(i)

        while !nodesToVisit.isEmpty {
            let node = nodesToVisit.removeLast() // O(1)
            if visited.contains(node) {
                continue
            }

            for k in 0..<isConnected[node].count {
                let connected = isConnected[node][k]
                if connected == 1 {
                    nodesToVisit.append(k)
                }
            }

            visited.insert(node)
        }

        provinces += 1
    }

    return provinces
}

// Recursive
// Time complexity: O(V^2)
// Space complexity: O(V)
func findCircleNum(_ isConnected: [[Int]]) -> Int {
    var provinces = 0
    var visited = Set<Int>()

    for i in 0..<isConnected.count {
        if visited.contains(i) {
            continue
        }

        visitNodes(node: i, visited: &visited, nodes: isConnected)
        provinces += 1
    }

    return provinces
}

func visitNodes(node: Int, visited: inout Set<Int>, nodes: [[Int]]) {
    if visited.contains(node) {
        return
    }

    visited.insert(node)
    for j in 0..<nodes[node].count {
        let connected = nodes[node][j]
        if connected == 1 {
            visitNodes(node: j, visited: &visited, nodes: nodes)
        }
    }
}

print(findCircleNum([[1,1,0],[1,1,0],[0,0,1]])) // 2
print(findCircleNum([[1,0,0],[0,1,0],[0,0,1]])) // 3
print(findCircleNum([[1,1,0,0,0,1],[1,1,1,0,0,0],[0,0,1,0,0,1],[0,0,0,1,1,0],[0,0,0,0,1,0],[0,0,0,0,0,1]])) // 2
print(findCircleNum([[1,0,0,1],[0,1,1,0],[0,1,1,1],[1,0,1,1]])) // 1