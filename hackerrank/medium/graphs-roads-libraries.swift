// https://www.hackerrank.com/challenges/torque-and-development/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=graphs
// Big O:
// Time complexity:
// Space complexity:
// Complete the roadsAndLibraries function below.
typealias LandGraph = [Int: [Int]]
typealias CitiesCost = [Int: Int]

struct RepairCost {
    var previous: Int
    var updated: Int
}

struct RepairCityInfo {
    var city: Int
    var citiesCost: CitiesCost
    var landGraph: LandGraph
    var libraryCost: Int
    var roadCost: Int
}

func roadsAndLibraries(n: Int, c_lib: Int, c_road: Int, cities: [[Int]]) -> Int {
    let graph = getLandGraph(cities: cities)
    return getRepairCost(totalCities: n, libraryCost: c_lib, roadCost: c_road, landGraph: graph)
}

func getRepairCost(totalCities: Int, libraryCost: Int, roadCost: Int, landGraph: LandGraph) -> Int {
    var citiesCost = [Int: Int]()
    var cost = 0
    var currentCity = 1

    while currentCity <= totalCities {

        let repairCityInfo = RepairCityInfo(city: currentCity, citiesCost: citiesCost, landGraph: landGraph, libraryCost: libraryCost, roadCost: roadCost)
        let (cityCost, citiesCostUpdated) = repairCity(info: repairCityInfo)
        cost += cityCost
        citiesCost = citiesCostUpdated

        currentCity += 1
    }

    return cost
}

func repairCity(info: RepairCityInfo) -> (Int, CitiesCost) {
    var citiesCostUpdated = info.citiesCost
    var currentCost = 0

    if info.citiesCost[info.city] == nil {
        citiesCostUpdated[info.city] = info.libraryCost
        currentCost += info.libraryCost
    }

    let updatedInfo = RepairCityInfo(city: info.city, citiesCost: citiesCostUpdated, landGraph: info.landGraph, libraryCost: info.libraryCost, roadCost: info.roadCost)
    return getCityNodesRepairCost(info: updatedInfo)
}

func getCityNodesRepairCost(info: RepairCityInfo) -> (Int, CitiesCost) {
    var citiesCostUpdated = info.citiesCost
    var currentCost = 0

    guard let nodes = info.landGraph[info.city] else {
        return (currentCost, citiesCostUpdated)
    }

    for node in nodes {
        let cityRepairCost = getCityRepairCost(currentCity: node, citiesCost: info.citiesCost, libraryCost: info.libraryCost, roadCost: info.roadCost)
        citiesCostUpdated[node] = cityRepairCost.updated
        currentCost += (cityRepairCost.updated - cityRepairCost.previous)
    }

    return (currentCost, citiesCostUpdated)
}

func getCityRepairCost(currentCity: Int, citiesCost: CitiesCost, libraryCost: Int, roadCost: Int) -> RepairCost {
    let currentCost = min(libraryCost, roadCost)
    let previousCost = citiesCost[currentCity] ?? 0
    let newCost = previousCost > 0 ? min(currentCost, previousCost) : currentCost
    return RepairCost(previous: previousCost, updated: newCost)
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
