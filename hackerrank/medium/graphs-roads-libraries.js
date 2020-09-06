// Complete the roadsAndLibraries function below.
function roadsAndLibraries(n, c_lib, c_road, cities) {
    if (c_lib < c_road) {
        return n * c_lib
    }

    const landGraph = getLandGraph(cities)

    var visitedCities = {}
    var isles = 0
    var roads = 0
    for (let currentCity = 1; currentCity <= n; currentCity++) {
        if (visitedCities[currentCity]) {
            continue
        }

        isles += 1
        let counter = dfs(visitedCities, landGraph, currentCity)
        roads += (counter - 1)
    }

    return isles * c_lib + roads * c_road
}

function getLandGraph(cities) {
    var graph = {}

    for (let i = 0; i < cities.length; i++) {
        let citiesPair = cities[i]
        let firstCity = citiesPair[0]
        let secondCity = citiesPair[1]
        graph[firstCity] = getAdjancentCities(firstCity, secondCity, graph)
        graph[secondCity] = getAdjancentCities(secondCity, firstCity, graph)
    }
    return graph
}

function getAdjancentCities(city, adjacentCity, graph) {
    let adjacentCities = graph[city] || []
    adjacentCities.push(adjacentCity)
    return adjacentCities
}

function dfs(visitedCities, landGraph, city) {
    visitedCities[city] = true
    let counter = 1
    const accessibleCities = landGraph[city]
    if (!accessibleCities) {
        return counter
    }

    for (let i = 0; i < accessibleCities.length; i++) {
        let adjacentCity = accessibleCities[i]
        if (!!visitedCities[adjacentCity]) {
            continue
        }
        counter += dfs(visitedCities, landGraph, adjacentCity)
    }

    return counter
}


console.log(roadsAndLibraries(3, 2, 1, [[1, 2], [3, 1], [2, 3]])) // 4
console.log(roadsAndLibraries(6, 2, 5, [[1, 3], [3, 4], [2, 4], [1, 2], [2, 3], [5, 6]])) // 12
console.log(roadsAndLibraries(5, 6, 1, [[1, 2], [1, 3], [1, 4], [2, 4]])) // 15
console.log(roadsAndLibraries(4, 6, 1, [[1, 4], [2, 3], [3, 4]])) // 9