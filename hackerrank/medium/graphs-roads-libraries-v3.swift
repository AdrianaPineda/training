// https://www.hackerrank.com/challenges/torque-and-development/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=graphs
// Big O:
// Time complexity:
// Space complexity:
// Complete the roadsAndLibraries function below.
func roadsAndLibraries(n: Int, c_lib: Int, c_road: Int, cities: [[Int]]) -> Int {
    if c_lib < c_road { // If library cost is cheaper, we should build libraries in each city
        return n * c_lib
    }

    let landGraph = getLandGraph(cities: cities)

    var visitedCities = Set<Int>()
    var isles = 0
    var roads = 0
    for currentCity in 1...n {
        if visitedCities.contains(currentCity) {
            continue
        }

        isles += 1
        let counter = dfs(visitedCities: &visitedCities, landGraph: landGraph, city: currentCity)
        roads += (counter - 1)
    }

    return isles * c_lib + roads * c_road
}

func dfs(visitedCities: inout Set<Int>, landGraph: [Int: Set<Int>], city: Int) -> Int {
    visitedCities.insert(city)
    var counter = 1
    guard let accessibleCities = landGraph[city] else {
        return counter
    }

    for adjacentCity in accessibleCities {
        if visitedCities.contains(adjacentCity) {
            continue
        }
        counter += dfs(visitedCities: &visitedCities, landGraph: landGraph, city: adjacentCity)
    }

    return counter
}

func getLandGraph(cities: [[Int]]) -> [Int: Set<Int>] {
    var graph = [Int: Set<Int>]()

    for citiesPair in cities {
        let firstCity = citiesPair[0]
        let secondCity = citiesPair[1]
        var firstCityAdjacentCities = graph[firstCity] ?? Set<Int>()
        firstCityAdjacentCities.insert(secondCity)
        graph[firstCity] = firstCityAdjacentCities

        var secondCityAdjacentCities = graph[secondCity] ?? Set<Int>()
        secondCityAdjacentCities.insert(firstCity)
        graph[secondCity] = secondCityAdjacentCities
    }
    return graph
}

print(roadsAndLibraries(n: 3, c_lib: 2, c_road: 1, cities: [[1, 2], [3, 1], [2, 3]])) // 4
print(roadsAndLibraries(n: 6, c_lib: 2, c_road: 5, cities: [[1, 3], [3, 4], [2, 4], [1, 2], [2, 3], [5, 6]])) // 12
print(roadsAndLibraries(n: 5, c_lib: 6, c_road: 1, cities: [[1, 2], [1, 3], [1, 4], [2, 4]])) // 15
print(roadsAndLibraries(n: 4, c_lib: 6, c_road: 1, cities: [[1, 4], [2, 3], [3, 4]])) // 9
