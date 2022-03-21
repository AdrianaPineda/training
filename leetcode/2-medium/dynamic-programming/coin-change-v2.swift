// Opt 2
// Time complexity: O(n*c)
// Space complexity: O(n), n the amount
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    var cache = [Int: Int]()
    return coinChangeRecursive(coins, amount, &cache) ?? -1
}

func coinChangeRecursive(_ coins: [Int], _ amount: Int, _ cache: inout [Int: Int]) -> Int? {
    if let current = cache[amount] {
        return current
    }

    if amount == 0 { return 0 }

    var minCoins = Int.max
    for coin in coins {
        guard coin <= amount else { continue }
        guard let nextCoins = coinChangeRecursive(coins, amount - coin, &cache), nextCoins >= 0 else { continue }
        minCoins = min(minCoins, nextCoins + 1)
    }

    if minCoins == Int.max {
        cache[amount] = -1
        return nil
    }

    cache[amount] = minCoins
    return minCoins
}

// Opt 1
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    var cache = [Int: Int]()
    return coinChangeRecursive(coins, amount, &cache)
}

func coinChangeRecursive(_ coins: [Int], _ amount: Int, _ cache: inout [Int: Int]) -> Int {
    if let current = cache[amount] {
        return current
    }

    if amount == 0 { return 0 }

    var minCoins = Int.max
    for coin in coins {
        guard coin <= amount else { continue }
        let nextCoins = coinChangeRecursive(coins, amount - coin, &cache)
        if nextCoins >= 0 {
            minCoins = min(minCoins, nextCoins + 1)
        }
    }

    if minCoins == Int.max {
        minCoins = -1
    }

    cache[amount] = minCoins
    return minCoins
}

print(coinChange([6,7], 13)) // 2
print(coinChange([1,2,5], 11)) // 3
print(coinChange([2], 3)) // -1
print(coinChange([1], 0)) // 0
print(coinChange([186,419,83,408], 6249)) // 20
