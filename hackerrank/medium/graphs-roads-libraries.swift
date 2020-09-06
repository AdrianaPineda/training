// https://www.hackerrank.com/challenges/torque-and-development/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=graphs
// Big O:
// Time complexity:
// Space complexity:
// Complete the roadsAndLibraries function below.
func roadsAndLibraries(n: Int, c_lib: Int, c_road: Int, cities: [[Int]]) -> Int {
    let graph = getCitiesGraph(cities: cities)

    var citiesCost = [Int: Int]()
    var cost = 0
    var currentCity = 1
    while currentCity <= n {

        defer {
            currentCity += 1
        }

        if citiesCost[currentCity] == nil {
            citiesCost[currentCity] = c_lib
            cost += c_lib
        }

        guard let nodes = graph[currentCity] else {
            continue
        }

        for node in nodes {
            let currentCost = min(c_lib, c_road)
            let previousCost = citiesCost[node] ?? 0
            let newCost = previousCost > 0 ? min(currentCost, previousCost) : currentCost
            citiesCost[node] = newCost
            cost += (newCost - previousCost)
        }

    }

    return cost
}

func getCitiesGraph(cities: [[Int]]) -> [Int: [Int]] {
    var graph = [Int: [Int]]()
    for citiesPair in cities {
        let firstCity = citiesPair[0]
        let secondCity = citiesPair[1]
        let smallerCity = min(firstCity, secondCity)
        let greaterCity = max(firstCity, secondCity)
        var currentConnectedNodes = graph[smallerCity] ?? []
        currentConnectedNodes.append(greaterCity)
        graph[smallerCity] = currentConnectedNodes
    }
    return graph
}
