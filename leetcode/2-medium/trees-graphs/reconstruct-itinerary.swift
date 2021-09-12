
// https://leetcode.com/problems/reconstruct-itinerary/
/**
You are given a list of airline tickets where tickets[i] = [fromi, toi] represent
the departure and the arrival airports of one flight. Reconstruct the itinerary in
order and return it.

All of the tickets belong to a man who departs from "JFK", thus, the itinerary
must begin with "JFK". If there are multiple valid itineraries, you should return
the itinerary that has the smallest lexical order when read as a single string.

For example, the itinerary ["JFK", "LGA"] has a smaller lexical order than ["JFK", "LGB"].
You may assume all tickets form at least one valid itinerary. You must use all the tickets
once and only once.
*/

// V1
// Time complexity: O(k^2) + O(k^n), k being the number of flights and n the airports
// Space complexity: O(v + e), v -> airports, e -> flights, ~O(k)
func findItinerary(_ tickets: [[String]]) -> [String] {
    let aiportOptions = getAirportOptions(tickets)
    var results = [String]()
    guard findItineraryRecursive(key: "JFK", aiportOptions, &results) else { return [String]() }
    return results
}


func findItineraryRecursive(key: String, _ airportOptions:  [String: [String]], _ result: inout [String]) -> Bool {
    result.append(key)
    if airportOptions.isEmpty  { return true }

    guard let options = airportOptions[key] else {
        result.removeLast()
        return false
    }

    var updatedAirportOptions = airportOptions
    for (i, option) in options.enumerated() {
            let updatedOption = Array(options[0..<i] + options[(i + 1)...])
            if updatedOption.isEmpty {
                updatedAirportOptions.removeValue(forKey: key)
            } else {
                updatedAirportOptions[key] = updatedOption
            }
        if findItineraryRecursive(key: option, updatedAirportOptions, &result) {
            return true
        }
    }

    result.removeLast()

    return false
}

func getAirportOptions(_ tickets: [[String]]) -> [String: [String]] {
    var airportOptions = [String: [String]]()

    for ticket in tickets {
        let origin = ticket[0]
        let destination = ticket[1]

        guard let currOptions = airportOptions[origin] else {
            airportOptions[origin] = [destination]
            continue
        }

        airportOptions[origin] = currOptions + [destination]
    }

    // sort lexicographically
    let sortedAirportOptions = airportOptions.mapValues { value in
        return value.sorted()
    }
    return sortedAirportOptions
}

// V2
func findItineraryAlt(_ tickets: [[String]]) -> [String] {
    let aiportOptions = getAirportOptions(tickets)
    return findItineraryRecursive(key: "JFK", aiportOptions) ?? [String]()
}


func findItineraryRecursiveAlt(key: String, _ airportOptions: [String: [String]], _ results: [String] = []) -> [String]? {
    var currResults = results
    currResults.append(key)

    if airportOptions.isEmpty  { return currResults }

    guard let options = airportOptions[key] else { return nil }

    for (i, option) in options.enumerated() {
        let updatedAirportOptions = getUpdatedOptions(key: key, valIndex: i, airportOptions)
        if let myResults = findItineraryRecursive(key: option, updatedAirportOptions, currResults) {
            return myResults
        }
    }

    return nil
}

func getUpdatedOptionsAlt(key: String, valIndex: Int, _ airportOptions: [String: [String]]) -> [String: [String]] {
    var result = airportOptions
    guard let options = airportOptions[key] else { return airportOptions }

    let updatedOption = Array(options[0..<valIndex] + options[(valIndex + 1)...])
    if updatedOption.isEmpty {
        result.removeValue(forKey: key)
    } else {
        result[key] = updatedOption
    }

    return result
}


print(findItinerary([["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]])) // ["JFK","ATL","JFK","SFO","ATL","SFO"]
print(findItinerary([["MUC","LHR"],["JFK","MUC"],["SFO","SJC"],["LHR","SFO"]])) // ["JFK","MUC","LHR","SFO","SJC"]
