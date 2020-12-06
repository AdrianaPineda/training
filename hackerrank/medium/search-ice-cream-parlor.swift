// Problem: https://www.hackerrank.com/challenges/ctci-ice-cream-parlor/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=search
// Big O:
// Time complexity: O(n)
// Space complexity: O(n)

// Complete the whatFlavors function below.
func whatFlavors(cost: [Int], money: Int) -> Void {
    guard let (i, j) = getFlavorsIndexes(cost: cost, money: money) else {
        return
    }

    print("\(i + 1) \(j + 1)")
}

func getFlavorsIndexes(cost: [Int], money: Int) -> (Int, Int)? {
    var costIndexes = [Int: Int]()

    for (i, flavorCost) in cost.enumerated() {
        if flavorCost >= money {
            continue
        }

        let remainingMoney = money - flavorCost
        guard let j = costIndexes[remainingMoney] else {
            costIndexes[flavorCost] = i
            continue
        }

        return (j, i)
    }

    return nil
}

whatFlavors(cost:[2, 1, 3, 5, 6], money: 5) // 1, 3
whatFlavors(cost:[1, 4, 5, 3, 2], money: 4) // 1, 4
whatFlavors(cost:[2, 2, 4, 3], money: 4) // 1, 2
