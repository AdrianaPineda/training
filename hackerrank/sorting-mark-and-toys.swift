//
// Problem: https://www.hackerrank.com/challenges/mark-and-toys/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=sorting
// Big O:
// Time complexity: O(n)
// Space complexity: O(n)

// Problem
// Complete the maximumToys function below.
func maximumToys(prices: [Int], k: Int) -> Int {
    var toysToBuy = 0
    var availableMoney = k

    let sortedPrices = prices.sorted()

    for price in sortedPrices {
        if price < availableMoney {
            toysToBuy += 1
            availableMoney -= price
        } else {
            break
        }
    }

    return toysToBuy
}