func shortestPaths(graph: [Int: [Int: Int]], start: Int) {
    var costs = [start: 0]
    var visited = Set<Int>()
    var parents = [Int: Int]()

    while let nextNode = nextNode(costs: costs, visited: visited) {
        defer {
            visited.insert(nextNode)
        }

        guard let edges = graph[nextNode] else {
            continue
        }

        for (node, weight) in edges {
            let currCost = costs[node] ?? Int.max
            let updatedCost = (costs[nextNode] ?? 0) + weight
            if updatedCost < currCost {
                costs[node] = updatedCost
                parents[node] = nextNode
            }
        }

    }

    print("parents:")
    print(parents.map({ (key: Int, value: Int) in
        "\(key) <- \(value)"
    }))
    print("costs:")
    print(costs.map({ (key: Int, value: Int) in
        "\(key): \(value)"
    }))
}

func nextNode(costs: [Int: Int], visited: Set<Int>) -> Int? {
    var currCost = Int.max
    var currNode: Int?
    for (node, cost) in costs {
        if visited.contains(node) { continue }
        if cost < currCost {
            currCost = cost
            currNode = node
        }
    }

    return currNode
}

// If start is not given
func initCosts(graph: [Int: [Int: Int]]) -> [Int: Int] {
    var starts = Set(graph.keys)

    for possibleStart in starts {
        guard let edges = graph[possibleStart] else { continue }
        for edge in edges.keys {
            starts.remove(edge)
        }
    }

    var costs = [Int: Int]()
    while starts.count > 0 {
        costs[starts.removeFirst()] = 0
    }
    return costs
}

shortestPaths(graph: [1: [2:4, 3:4], 2: [3:2], 3: [4:3, 6:6, 5:1], 4: [6:2], 5: [6:3]], start: 1)



class Edge: Hashable {
    static func == (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.from == rhs.from && lhs.to == rhs.to
    }

    let to: Node
    let from: Node
    let weight: Int

    init(to: Node, from: Node, weight: Int) {
        self.to = to
        self.from = from
        self.weight = weight
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(to)
        hasher.combine(from)
    }
}

class Node: Hashable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    var visited: Bool
    let identifier: Int
    var edges: [Edge]

    init(visited: Bool, identifier: Int, edges: [Edge]) {
        self.visited = visited
        self.identifier = identifier
        self.edges = edges
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

class Graph {
    var nodes: [Node] = []

    init(nodes: [Node] = []) {
        self.nodes = nodes
    }
}

var costs = [Node: Int]()
var parents = [Node: Node]()

func shortestPath (source: Int, destination: Int, graph: Graph) -> Int {
    guard let sourceNode = findSourceNode(source, graph) else { return  0 }
    if sourceNode.identifier == destination { return 0 }
    sourceNode.visited = true
    initCosts(sourceNode: sourceNode, source: source, graph: graph)

    var nextNode = findNextNode()
    while let uwNextNode = nextNode {
        if uwNextNode.identifier == destination {
            return costs[uwNextNode] ?? 0
        }
        uwNextNode.visited = true
        updateCosts(node: uwNextNode)
        nextNode = findNextNode()
    }

    return 0
}

func updateCosts(node: Node) {
    for edge in node.edges {
        let toNode = edge.to
        let weight = edge.weight
        let cost = costs[toNode] ?? Int.max
        let currCost = (costs[node] ?? 0 ) + weight
        if currCost < cost {
            costs[toNode] = currCost
            parents[toNode] = node
        }
    }
}

func initCosts(sourceNode: Node, source: Int, graph: Graph) {
    costs[sourceNode] = 0

    for edge in sourceNode.edges {
        let node = edge.to
        costs[node] = edge.weight
        parents[node] = sourceNode
    }
}

func findSourceNode(_ source: Int, _ graph: Graph) -> Node? {
    for node in graph.nodes {
        if node.identifier == source { return node }
    }

    return nil
}

func findNextNode() -> Node? {
    var node: Node?
    var cost = Int.max
    for currNode in costs.keys {
        guard let currCost = costs[currNode] else { continue }
        if currNode.visited { continue }
        if currCost < cost {
            cost = currCost
            node = currNode
        }
    }

    return node
}



// Complete the quickestWayUp function below.
func setupGraphwith(edges: [[Int]]) -> Graph {
    let graph = Graph()

    // create all the nodes
    // The first and last node need to be included, so need nodes from "to" and "from"
    let nodeNames = Set ( edges.map{ $0[0] } + edges.map{ $0[1]} )
    for node in nodeNames {
        let newNode = Node(visited: false, identifier: node, edges: [])
        graph.nodes.append(newNode)
    }

    // create all the edges to link the nodes
    for edge in edges {
        if let fromNode = graph.nodes.first(where: { $0.identifier == edge[0] }) {
            if let toNode = graph.nodes.first(where: { $0.identifier == edge[1] }) {
                let forwardEdge = Edge(to: toNode, from: fromNode, weight: edge[2])
                fromNode.edges.append(forwardEdge)
            }
        }
    }
    return graph
}

let simpleGraph = setupGraphwith(edges: [[1,2,4], [1,3,4], [3,4,3], [2,3,2], [3,5,1], [4,6,2], [5,6,3], [3,6,6] ])
let moreComplexGraph = setupGraphwith(edges: [[0,1,4],[0,2,4],[1,2,2],[1,4,7],[2,3,3],[2,4,1],[2,5,6],[3,5,2],[4,5,3]])
let graphWithBug = setupGraphwith(edges: [[1,2,10],[1,3,1],[3,2,1]])
let graphAllNodes = setupGraphwith(edges: [[1,4,20],[3,1,3],[4,3,12]])

//print(shortestPath(source: 1, destination: 6, graph: simpleGraph)) // 8
print(shortestPath(source: 0, destination: 5, graph: moreComplexGraph)) // 8
print(shortestPath(source: 1, destination: 2, graph: graphWithBug)) // 2
