//
// Problem: https://www.hackerrank.com/challenges/count-triplets-1/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dictionaries-hashmaps
// Big O:
// Time complexity:
// Space complexity:

// Complete the countTriplets function below.
func countTriplets(arr: [Int], r: Int) -> Int {

    var triplets = 0
    let numbersIndexes = getNumbersIndexes(arr: arr)
    
    for key in numbersIndexes.keys {
        let secondNumber = key * r
        let thirdNumber = secondNumber * r

        guard let firstNumberIndexes = numbersIndexes[key], let secondNumberIndexes = numbersIndexes[secondNumber], let thirdNumberIndexes = numbersIndexes[thirdNumber] else {
            continue
        }

        for i in firstNumberIndexes {
            for j in secondNumberIndexes {
                for k in thirdNumberIndexes {
                    if i < j && j < k {
                        triplets += 1
                    }
                }
            }
        }
    }

    return triplets

}

func getNumbersIndexes(arr: [Int]) -> [Int: [Int]] {
    var numbersIndexes = [Int: [Int]]()

    for (i, number) in arr.enumerated() {
        guard var indexes = numbersIndexes[number] else {
            numbersIndexes[number] = [i]
            continue
        }

        indexes.append(i)
        numbersIndexes[number] = indexes

    }

    return numbersIndexes
}


print(countTriplets(arr: [1, 4, 16, 64], r: 4)) // 2
print(countTriplets(arr: [1, 2, 2, 4], r: 2)) // 2
print(countTriplets(arr: [1, 3, 9, 9, 27, 81], r: 3)) // 6
print(countTriplets(arr: [1, 5, 5, 25, 125], r: 5)) // 4

