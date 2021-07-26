func getYearWithMorePeople(people: [[Int]]) -> Int {
    var peopleAliveInYears = Array(repeating: 0, count: 2022)
    for person in people {
        let birthYear = person[0]
        let deathYear = person[1]
        fillYears(start: birthYear, end: deathYear, peopleAliveInYears: &peopleAliveInYears)
    }

    var mostPeopleAlive = 0
    var year = 0
    for (i, peopleAlive) in peopleAliveInYears.enumerated() {

        if peopleAlive > mostPeopleAlive {
            mostPeopleAlive = peopleAlive
            year = i
        }
    }
    return year
}

func fillYears(start: Int, end: Int, peopleAliveInYears: inout [Int]) {
    for i in start...end {
        peopleAliveInYears[i] = peopleAliveInYears[i] + 1
    }
}

// Alt
// Time complexity: O(p*y)
// Space complexity: O(z)
func getYearWithMorePeople(people: [[Int]]) -> Int {
    var peopleAliveInYears = [Int: Int]()
    for person in people {
        let birthYear = person[0]
        let deathYear = person[1]
        fillYears(start: birthYear, end: deathYear, peopleAliveInYears: &peopleAliveInYears)
    }

    var mostPeopleAlive = 0
    var year = 0
    for currYear in peopleAliveInYears.keys {
        guard let peopleAlive = peopleAliveInYears[currYear] else { continue }

        if peopleAlive > mostPeopleAlive {
            mostPeopleAlive = peopleAlive
            year = currYear
        }
    }
    return year
}

func fillYears(start: Int, end: Int, peopleAliveInYears: inout [Int: Int]) {
    for i in start...end {
        guard let peopleAlive = peopleAliveInYears[i] else {
            peopleAliveInYears[i] = 1
            continue
        }
        peopleAliveInYears[i] = peopleAlive + 1
    }
}

// Alt 
func getYearWithMorePeople(people: [[Int]]) -> Int {
    let sortedPeople = people.sorted{ $0[0] < $1[0] }
    var deathYears = [Int]()
    var mostPeopleAlive = 0
    var year = 0
    var currentPeopleAlive = 0
    for person in sortedPeople {
        let birthYear = person[0]
        let deathYear = person[1]

        currentPeopleAlive += 1

        let prevDeathYearsCount = deathYears.count
        deathYears.filter { $0 > birthYear }
        let currDeathYearsCount = deathYears.count

        currentPeopleAlive -= (prevDeathYearsCount - currDeathYearsCount)
        if currentPeopleAlive > mostPeopleAlive {
            year = birthYear
            mostPeopleAlive = currentPeopleAlive
        }

        deathYears.append(deathYear)
    }
    return year
}

// Alt
// Time complexity: O(n^2), being n the number of people
// Space complexity: O(1)
func getYearWithMorePeople(people: [[Int]]) -> Int {
    var mostPeopleAlive = 0
    var year = 0

    for person in people {
        let birthYear = person[0]
        let peopleAlive = getPeopleAlive(inYear: birthYear, people: people)
        if peopleAlive > mostPeopleAlive {
            mostPeopleAlive = peopleAlive
            year = birthYear
        }
    }

    return year
}

func getPeopleAlive(inYear year: Int, people: [[Int]]) -> Int {
    var counter = 0

    for person in people {
        let birthYear = person[0]
        let deathYear = person[1]
        if year >= birthYear && year <= deathYear {
            counter += 1
        }
    }

    return counter
}

// Alt
// Time complexity: O(n*log(n))
// Space complexity: O(n)
func getYearWithMorePeople(people: [[Int]]) -> Int {
    let sortedBirthYears = people.map { $0[0] }.sorted { $0 < $1 }
    let sortedDeathYears = people.map { $0[1] }.sorted { $0 < $1 }

    var maxPeopleAlive = 0
    var year = 0
    var currentPeopleAlive = 0
    var birthYearIndex = 0
    var deathYearIndex = 0

    while birthYearIndex < people.count {
        let birthYear = sortedBirthYears[birthYearIndex]
        let deathYear = sortedDeathYears[deathYearIndex]

        if birthYear <= deathYear {
            currentPeopleAlive += 1
            birthYearIndex += 1
        }

        if birthYear > deathYear {
            currentPeopleAlive -= 1
            deathYearIndex += 1
        }

        if currentPeopleAlive > maxPeopleAlive {
            maxPeopleAlive = currentPeopleAlive
            year = birthYear
        }

    }

    return year
}

// Alt
// Time complexity: O(n*log(n))
// Space complexity: O(n)
func getYearWithMorePeople(people: [[Int]]) -> Int {
    var peopleDeltas = [Int: Int]()

    for person in people {
        let birthYear = person[0]
        let deathYear = person[1]

        let birthDelta = peopleDeltas[birthYear] ?? 0
        peopleDeltas[birthYear] = birthDelta + 1

        let deathDelta = peopleDeltas[deathYear + 1] ?? 0
        peopleDeltas[deathYear + 1] = deathDelta - 1
    }

    var maxPeopleAlive = 0
    var year = 0
    var currentPeopleAlive = 0
    for currYear in peopleDeltas.keys.sorted() {
        guard let delta = peopleDeltas[currYear] else { continue }
        currentPeopleAlive += delta

        if currentPeopleAlive > maxPeopleAlive {
            maxPeopleAlive = currentPeopleAlive
            year = currYear
        }
    }

    return year
}

print(getYearWithMorePeople(people: [[1970, 2020], [1980, 2021], [1980, 2001], [1950, 1990], [1985, 2000]])) // 1985
print(getYearWithMorePeople(people: [[2000, 2010], [1975, 2005], [1975, 2003], [1803, 1809], [1750, 1869]])) // 2000