// https://www.hackerrank.com/challenges/sock-merchant/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=warmup
// Problem
// Big O:
// Time complexity: O(n)
// Space complexity: O(n)

// Problem
func sockMerchant(socks: [Int]) -> Int {
    var sockDict: [Int: Int] = [:]
    var numberOfPairs = 0

    for sock in socks {
        let currentSocks = (sockDict[sock] ?? 0) + 1
        sockDict[sock] = currentSocks
        if currentSocks % 2 == 0 {
            numberOfPairs += 1
        }
    }

    return numberOfPairs
}


// Case 0 socks
print(sockMerchant(socks: []))

// Case All odd socks
print(sockMerchant(socks: [-1, 2, 3, 0, 5, -6, 7, 8, 9]))

// Case All pairs
print(sockMerchant(socks: [1, 1, 2, 3, 2, 3, 4, 4]))

// Other cases
print(sockMerchant(socks: [10, 20, 20, 10, 10, 30, 50, 10, 20]))

