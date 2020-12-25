// Problem: https://www.hackerrank.com/challenges/greedy-florist/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=greedy-algorithms
// Big O:
// Time complexity: O(n)
// Space complexity: O(n)

// Complete the getMinimumCost function below.
func getMinimumCost(k: Int, c: [Int]) -> Int {
    let flowersToBuy = c.count

    if k == flowersToBuy { // Every friend buys one flower each
        return c.reduce(0, { x, y in x + y })
    }

    let orderedCosts = c.sorted(by: >) // Orders from highest to lowest cost
    return getAlteredCost(k: k, costs: orderedCosts)
}

func getAlteredCost(k: Int, costs: [Int]) -> Int {
    var totalCost = 0

    var purchases = [Int: Int]()
    for i in 0..<costs.count {
        let index = (i + 1) % k
        let previousPurchase = purchases[index] ?? 0

        totalCost += (previousPurchase + 1) * costs[i]
        purchases[index] = previousPurchase + 1
    }

    return totalCost
}

print(getMinimumCost(k: 3, c: [2, 5, 6]))
print(getMinimumCost(k: 2, c: [2, 5, 6]))
print(getMinimumCost(k: 3, c: [1, 3, 5, 7, 9]))
print(getMinimumCost(k: 3, c: [390225, 426456, 688267, 800389, 990107, 439248, 240638, 15991, 874479, 568754, 729927, 980985, 132244, 488186, 5037, 721765, 251885, 28458, 23710, 281490, 30935, 897665, 768945, 337228, 533277, 959855, 927447, 941485, 24242, 684459, 312855, 716170, 512600, 608266, 779912, 950103, 211756, 665028, 642996, 262173, 789020, 932421, 390745, 433434, 350262, 463568, 668809, 305781, 815771, 550800])) // 163578911