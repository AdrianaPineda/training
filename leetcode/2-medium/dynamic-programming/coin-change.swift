
// https://leetcode.com/problems/coin-change

// Time complexity: O(n*c), n being the amount and c the coins
// Space complexity: O(n)
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    var cachedCoins = [Int: Int]()
    let resul = coinChangeRecursive(coins, amount, &cachedCoins)
    return resul
}

func coinChangeRecursive(_ coins: [Int], _ amount: Int, _ cachedCoins: inout [Int: Int]) -> Int {
    if amount < 0 {
        return -1
    }

    if amount == 0 {
        return 0
    }

    if let prevCoins = cachedCoins[amount] {
        return prevCoins
    }

    var minCoins = Int.max
    for coin in coins {
        let tempCoins = coinChangeRecursive(coins, amount - coin, &cachedCoins)
        if tempCoins >= 0 && tempCoins < minCoins {
            minCoins = tempCoins + 1
        }
    }

    cachedCoins[amount] = minCoins == Int.max ? -1 : minCoins
    return cachedCoins[amount] ?? -1
}

// Returning coins
func coinChange(_ coins: [Int], _ amount: Int) -> [Int] {
    var cachedCoins = [Int: [Int]]()
    let resul = coinChangeRecursive(coins, amount, &cachedCoins)
    return resul ?? []
}

func coinChangeRecursive(_ coins: [Int], _ amount: Int, _ cachedCoins: inout [Int: [Int]]) -> [Int]? {
    if amount < 0 {
        return nil
    }

    if amount == 0 {
        return []
    }

    if let prevCoins = cachedCoins[amount] {
        return prevCoins
    }

    var minCoins = Int.max
    var minCoinsArr = [Int]()
    for coin in coins {
        guard var tempCoins = coinChangeRecursive(coins, amount - coin, &cachedCoins) else { continue }
        tempCoins.append(coin)

        if tempCoins.count < minCoins {
            minCoins = tempCoins.count
            minCoinsArr = tempCoins
        }
    }

    if minCoins == Int.max {
        return nil
    }
    cachedCoins[amount] = minCoinsArr
    return cachedCoins[amount]
}

// Time complexity: O(n*c) + O(c*log(c)), n being the amount and c the coins
// Space complexity: O(n)
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    if amount == 0 { return 0 }

    let currCoins = coins.sorted()
    var coinsCached = Array(repeating: -1, count: amount + 1)
    coinsCached[0] = 0

    for i in 1...amount {
        var index = 0
        var minCoins = Int.max

        while index < currCoins.count {
            defer { index += 1 }

            let coin = currCoins[index]
            guard coin <= i else { break }

            let remaining = i - coin
            let prevVal = coinsCached[remaining]
            if prevVal == -1 { continue }

            minCoins = min(minCoins, prevVal + 1)
        }

        coinsCached[i] = (minCoins == Int.max) ? -1 : minCoins
    }

    return coinsCached[amount]
}

// Timeout
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    guard let result = numOfCoins(coins.sorted(), amount) else { return -1 }
    return result
}

func numOfCoins(_ coins: [Int], _ amount: Int, _ usedCoins: Int = 0) -> Int? {
    if amount == 0 { return usedCoins }
    guard let highestCoinIndex = getHighestCoinValueIndex(coins, amount) else { return nil }
    for i in stride(from: highestCoinIndex, to: -1, by: -1) {
        let coin = coins[i]
        guard let currCoins = numOfCoins(coins, amount - coin, usedCoins + 1) else { continue }
        return currCoins
    }

    return nil
}

func getHighestCoinValueIndex(_ coins: [Int], _ amount: Int) -> Int? {
    for i in stride(from: coins.count - 1, to: -1, by: -1) {
        let coin = coins[i]
        if coin <= amount {
            return i
        }
    }
    return nil
}

// Timeout again
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    var minCoins = Int.max
    numOfCoins(coins.sorted(by: >), amount: amount, minCoins: &minCoins)
    return minCoins == Int.max ? -1 : minCoins
}

func numOfCoins(_ coins: [Int], index: Int = 0, amount: Int, usedCoins: Int = 0, minCoins: inout Int) {
    if usedCoins > minCoins { return }

    if amount == 0 {
        minCoins = min(minCoins, usedCoins)
        return
    }

    for i in index..<coins.count {
        let coin = coins[i]
        if coin > amount { continue }
        numOfCoins(coins, index: i, amount: (amount - coin), usedCoins: (usedCoins + 1), minCoins: &minCoins)
    }
}

// Return coins chosen
func coinChange(_ coins: [Int], _ amount: Int) -> [Int] {
    return numOfCoins(coins, amount: amount) ?? []
}

func numOfCoins(_ coins: [Int], amount: Int, currCoins: [Int] = []) -> [Int]? {
    if amount < 0 { return nil }
    if amount == 0 {
        return currCoins
    }

    var minCoins = Int.max
    var minCoinsArr = [Int]()
    for i in 0..<coins.count {
        let coin = coins[i]
        guard let result = numOfCoins(coins, amount: (amount - coin),currCoins: currCoins + [coin]) else { continue }
        if result.count < minCoins {
            minCoinsArr = result
            minCoins = result.count
        }
    }

    return minCoinsArr.isEmpty ? nil : minCoinsArr
}

print(coinChange([2,4,6,8,10,12,14,16,18,20,22,24], 9999)) // -1
print(coinChange([411,412,413,414,415,416,417,418,419,420,421,422], 9864)) // 24
print(coinChange([186,419,83,408], 6249)) // 20
print(coinChange([1, 2, 5], 11)) // 3
print(coinChange([2, 5], 11)) // 4
print(coinChange([2], 3)) // -1
print(coinChange([1], 0)) // 0
print(coinChange([1], 1)) // 1
print(coinChange([1], 2)) // 2