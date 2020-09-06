// https://www.hackerrank.com/challenges/torque-and-development/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=graphs
// Big O:
// Time complexity: O(n^2)
// Space complexity: O(n)
// Complete the roadsAndLibraries function below.
typealias LandGraph = [Int: [Int]]
typealias CitiesCost = [Int: Int]

struct RepairCost {
    var previous: Int
    var updated: Int
}

struct CityInfo {
    var city: Int
    var citiesCost: CitiesCost
    var landGraph: LandGraph
    var libraryCost: Int
    var roadCost: Int
}

func roadsAndLibraries(n: Int, c_lib: Int, c_road: Int, cities: [[Int]]) -> Int {
    if c_lib < c_road { // If library cost is cheaper, we should build libraries in each city
        return n * c_lib
    }
    let graph = getLandGraph(cities: cities) // O(n)
    return getRepairCost(totalCities: n, libraryCost: c_lib, roadCost: c_road, landGraph: graph)
}

func getRepairCost(totalCities: Int, libraryCost: Int, roadCost: Int, landGraph: LandGraph) -> Int {
    var citiesCost = [Int: Int]()
    var cost = 0
    var currentCity = 1

    while currentCity <= totalCities { // O(n)

        if citiesCost[currentCity] == nil { // If there are no smaller nodes reaching the current city, a new library needs to be built
            citiesCost[currentCity] = libraryCost
            cost += libraryCost
        }

        let cityInfo = CityInfo(city: currentCity, citiesCost: citiesCost, landGraph: landGraph, libraryCost: libraryCost, roadCost: roadCost)
        let (cityCost, citiesCostUpdated) = getCityNodesRepairCost(info: cityInfo)

        cost += cityCost
        citiesCost = citiesCostUpdated

        currentCity += 1
    }

    return cost
}

func getCityNodesRepairCost(info: CityInfo) -> (Int, CitiesCost) {
    var citiesCostUpdated = info.citiesCost
    var currentCost = 0

    guard let nodes = info.landGraph[info.city] else {
        return (currentCost, citiesCostUpdated)
    }

    for node in nodes { // O(n-1)
        guard let citiesCostUpdated[node] else { // If the node is reachable by another city, we ignore it
            citiesCostUpdated[node] = min(info.libraryCost, info.roadCost)
            currentCost += citiesCostUpdated[node]
            continue
        }
    }

    return (currentCost, citiesCostUpdated)
}

func getLandGraph(cities: [[Int]]) -> LandGraph {
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

print(roadsAndLibraries(n: 3, c_lib: 2, c_road: 1, cities: [[1, 2], [3, 1], [2, 3]]))
print(roadsAndLibraries(n: 6, c_lib: 2, c_road: 5, cities: [[1, 3], [3, 4], [2, 4], [1, 2], [2, 3], [5, 6]]))
