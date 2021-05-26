// https://leetcode.com/explore/interview/card/facebook/55/dynamic-programming-3/304/
/**
You are given an array prices where prices[i] is the price of a given stock on the ith day.

You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.

Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.
*/

/**
prices = [7,1,5,3,6,4]
output = 5

max_profit = 0 => 4 => 5
min_value = 1
max_value = 6

prices = [7,6,4,3,1]
output = 0

max_profit = 0
min_value = 1
max_value = 1

i = 1..<count

*/

// Time complexity: O(n)
// Space complexity: O(1)
func maxProfit(_ prices: [Int]) -> Int {
    var maxProfit = 0
    var minVal = prices[0]
    var maxVal = prices[0]

    for i in 1..<prices.count {
        let currPrice = prices[i]
        if currPrice < minVal {
            minVal = currPrice
            maxVal = currPrice
        }

        if currPrice > maxVal {
            maxVal = currPrice
            maxProfit = max(maxProfit, maxVal - minVal)
        }
    }

    return maxProfit
}

print(maxProfit([7,1,5,3,6,4])) // 5
print(maxProfit([7,6,4,3,1])) // 0