//
// Problem: https://www.hackerrank.com/challenges/count-triplets-1/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dictionaries-hashmaps
// Big O:
// Time complexity: O(n)
// Space complexity: O(n)

// Complete the countTriplets function below.

func countTriplets(arr: [Int], r: Int) -> Int {

    var frequenciesAtRight = [Int: Int]()
    for elem in arr {
        guard let frequency = frequenciesAtRight[elem] else {
            frequenciesAtRight[elem] = 1
            continue
        }

        frequenciesAtRight[elem] = (frequency + 1)
    }

    var frequenciesAtLeft = [Int: Int]()

    var triplets = 0
    for elem in arr {
        if let frequencyAtRight = frequenciesAtRight[elem] {
            frequenciesAtRight[elem] = (frequencyAtRight - 1)
        }

        defer {
            if let frequencyAtLeft = frequenciesAtLeft[elem] {
                frequenciesAtLeft[elem] = (frequencyAtLeft + 1)
            } else {
                frequenciesAtLeft[elem] = 1
            }
        }

        let firstElement = elem / r
        guard let firstElementFrequency = frequenciesAtLeft[firstElement], firstElementFrequency > 0 else {
            continue
        }

        let thirdElem = elem * r
        guard let thirdElemFrequency = frequenciesAtRight[thirdElem], thirdElemFrequency > 0 else {
            continue
        }

        triplets += (firstElementFrequency * thirdElemFrequency)
    }

    return triplets

}

print(countTriplets(arr: [1, 4, 16, 64], r: 4)) // 2
print(countTriplets(arr: [1, 2, 2, 4], r: 2)) // 2
print(countTriplets(arr: [1, 5, 25, 5, 125, 25], r: 5)) // 4
print(countTriplets(arr: [1, 3, 9, 9, 27, 81], r: 3)) // 6
print(countTriplets(arr: [1, 5, 5, 25, 125], r: 5)) // 4
print(countTriplets(arr: [1, 2, 1, 2, 4], r: 2)) // 3
print(countTriplets(arr: [1, 1, 1, 1, 1], r: 1)) // 10