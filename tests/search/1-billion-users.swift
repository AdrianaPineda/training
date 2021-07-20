/**
We have N different apps with different user growth rates. At a given time t, measured
in days, the number of users using an app is g^t (for simplicity we'll allow fractional
users), where g is the growth rate for that app. These apps will all be launched at the
same time and no user ever uses more than one of the apps. We want to know how many
total users there are when you add together the number of users from each app.
After how many full days will we have 1 billion total users across the N apps?

Signature
    int getBillionUsersDay(float[] growthRates)

Input
    1.0 < growthRate < 2.0 for all growth rates
    1 <= N <= 1,000

Output
    Return the number of full days it will take before we have a total of 1 billion users across all N apps.

Example 1
    growthRates = [1.5]
    output = 52

Example 2
    growthRates = [1.1, 1.2, 1.3]
    output = 79

Example 3
    growthRates = [1.01, 1.02]
    output = 1047
*/
import Foundation

struct GrowthRates {
  let rates: [Double]
}

// Time complexity: O(t*r)
// Space complexity: O(1)
private extension GrowthRates {
  func daysUntilBillionUsers() -> Int {
      let targetUsers: Double = 1000000000
      var days = 1
      var accGrowth: Double = 0
      while accGrowth < targetUsers {
      for rate in rates {
          accGrowth = pow(rate, Double(days))
      }
      days += 1
    }
    return days - 1
  }

// Time complexity: O(t*r)
// Space complexity: O(r)
  func daysUntilBillionUsers() -> Int {
      let targetUsers: Double = 1000000000
      var days = 0
      var growth = 0.0
      var prevRatesGrowth = Array(repeating: 1.0, count: rates.count)
      while growth < targetUsers {
          growth = 0
          for (i, rate) in rates.enumerated() {
              prevRatesGrowth[i] = prevRatesGrowth[i] * rate
              growth += prevRatesGrowth[i]
          }
          days += 1
        }
      return days
    }
}

//let growthRates = GrowthRates(rates: [1.5]) // 52
//let growthRates = GrowthRates(rates: [1.01, 1.02]) // 1047
let growthRates = GrowthRates(rates: [1.1, 1.2, 1.3]) // 79
print(growthRates.daysUntilBillionUsers())
