//
// Problem: https://www.hackerrank.com/challenges/minimum-swaps-2/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays
// Big O:
// Time complexity: O(n)
// Space complexity: O(n)

// Complete the minimumSwaps function below.
func minimumSwaps(arr: [Int]) -> Int {
    var swaps = 0

    var updatedArray = Array(arr)
    var elementsIndexes = getElementsIndexes(arr: arr)

    for i in 0..<updatedArray.count {
        let currItem = updatedArray[i]
        let expectedItem = (i + 1)
        if currItem == expectedItem {
            continue
        }
        
        // Swap items
        guard let currItemNewPos = elementsIndexes[expectedItem] else { continue }
        
        updatedArray[i] = expectedItem
        elementsIndexes[expectedItem] = i
        
        updatedArray[currItemNewPos] = currItem
        elementsIndexes[currItem] = currItemNewPos

        swaps += 1
    }

    return swaps
}

func getElementsIndexes(arr: [Int]) -> [Int: Int] {
    var elementsIndexes = [Int: Int]()
    for (i, element) in arr.enumerated() {
        elementsIndexes[element] = i
    }

    return elementsIndexes
}

print(minimumSwaps(arr: [1, 3, 5, 2, 4, 6, 7]))
print(minimumSwaps(arr: [4, 3, 1, 2]))
print(minimumSwaps(arr: [2, 3, 4, 1, 5]))
print(minimumSwaps(arr: [3, 2, 5, 4, 1]))