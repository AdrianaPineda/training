// Problem: https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/564/
// Big O:
// Time complexity: O(n)
// Space complexity: O(1)

// [7,1,5,3,6,4] => 7
// [1,2,3,4,5]   => 4
// [7,6,4,3,1]   => 0
// [2,3,4,5,1]   => 3

func maxProfit(_ prices: [Int]) -> Int {
    var profit = 0
    if prices.count <= 1 {
        return profit
    }

    var buyPrice = prices[0]
    var sellPrice = prices[0]

    for i in 1..<prices.count {
        let currPrice = prices[i]

        if currPrice < buyPrice || currPrice < sellPrice {
            profit += (sellPrice - buyPrice)
            buyPrice = currPrice
        }

        sellPrice = currPrice
    }

    profit += (sellPrice - buyPrice)
    return profit
}

func maxProfit(_ prices: [Int]) -> Int {
    var profit = 0
    if prices.count <= 1 {
        return profit
    }
    
    for i in 1..<prices.count {
        let currPrice = prices[i]
        let previousPrice = prices[i - 1]

        if previousPrice < currPrice {
            profit += (currPrice - previousPrice)
        }
    }

    return profit
}


print(maxProfit([7, 1, 5, 3, 6, 4])) // 7
print(maxProfit([1, 2, 3, 4, 5])) // 4
print(maxProfit([7, 6, 4, 3, 1])) // 0
print(maxProfit([2, 3, 4, 5, 1])) // 3
print(maxProfit([])) // 0
print(maxProfit([1, 2])) // 1
