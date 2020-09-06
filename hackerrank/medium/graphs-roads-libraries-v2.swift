// https://www.hackerrank.com/challenges/torque-and-development/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=graphs
// Big O:
// Time complexity: O(n)
// Space complexity: O(n)
// Complete the roadsAndLibraries function below.
struct LandInfo {
    var roads: Int
    var startPoints: Int
}

func roadsAndLibraries(n: Int, c_lib: Int, c_road: Int, cities: [[Int]]) -> Int {
    if c_lib < c_road { // If library cost is cheaper, we should build libraries in each city
        return n * c_lib
    }

    let accessibleCities = getAccessibleCities(cities: cities) // O(n)
    let landInfo = getLandInfo(totalCities: n, accessibleCities: accessibleCities) // O(n)
    return landInfo.roads * c_road + landInfo.startPoints * c_lib
}

func getLandInfo(totalCities: Int, accessibleCities: [Int: Int]) -> LandInfo {
    var roads = 0
    var startPoints = 0
    var currentCity = 1

    while currentCity <= totalCities { // O(n)

        if let _ = accessibleCities[currentCity] {
            roads += 1
        } else {
            startPoints += 1 // If the city is not accessible, a new library needs to be built

        }

        currentCity += 1
    }

    return LandInfo(roads: roads, startPoints: startPoints)
}

func getAccessibleCities(cities: [[Int]]) -> [Int: Int] {
    var accessibleCities = [Int: Int]()
    for citiesPair in cities {
        let firstCity = citiesPair[0]
        let secondCity = citiesPair[1]
        let greaterCity = max(firstCity, secondCity)
        accessibleCities[greaterCity] = 1
    }

    return accessibleCities
}



print(roadsAndLibraries(n: 3, c_lib: 2, c_road: 1, cities: [[1, 2], [3, 1], [2, 3]])) // 4
print(roadsAndLibraries(n: 6, c_lib: 2, c_road: 5, cities: [[1, 3], [3, 4], [2, 4], [1, 2], [2, 3], [5, 6]])) // 12
