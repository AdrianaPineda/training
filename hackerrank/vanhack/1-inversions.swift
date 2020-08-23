/*
 * Complete the 'maxInversions' function below.
 *
 * The function is expected to return a LONG_INTEGER.
 * The function accepts INTEGER_ARRAY arr as parameter.
 */

// TIMEOUT -> Complexity O(n^3)
func maxInversions_v1(arr: [Int]) -> Int {
    print("counter \(arr.count)")
    var counter = 0

    for i in 0..<(arr.count - 2) {
        let firstValue = arr[i]
        for j in (i+1)..<(arr.count - 1) {
            let secondValue = arr[j]
            for k in (j+1)..<arr.count {
                let thirdValue = arr[k]
                if firstValue > secondValue && secondValue > thirdValue {
                    counter += 1
                }
            }
        }
    }
    return counter
}

// SUCCESSFUL
// MAX INVERSIONS
///
/// This methods finds all the possible inversions within a given array
///
/// - Parameters:
///    - arr: array
/// - Returns:
///    - number of inversions
///
/// - Complexity: O(*n^2*), where *n* is the length of the array.
///
func maxInversions(arr: [Int]) -> Int {
    // Build dictionary with decreasing indexes
    let decreasingValuesIndexes = getDecreasingValuesIndexes(arr: arr)

    // Look for triplets
    return findTriplets(arr: arr, valuesIndexes: decreasingValuesIndexes)
}

///
/// This method builds a dictionary that contains an array _indexes__array_ for each index i of the array arr. Each element j in _indexes__array_ should be such as arr[i] >  arr[j],  j > i
///
/// - Parameters:
///    - arr: array
///
/// - Returns:
///    - Dictionary that contains:
///        * As keys: indexes of each element in the array
///        * As values: array of indexes of elements
///
/// - Complexity: O(*n^2*), where *n* is the length of the array.
///
/// For each element i, i in 0..n-1 (not inclusive):
/// 1) Iterates over the array starting from j=i+1
/// 2) Creates an array that includes indexes of elements that at a given pos j are less that element at pos i (i.e. indexes_array)
/// 2) Adds a key/value pair to the dictionary =>  [i: indexes_array]
///
///         For array:
///           [8, 6, 1, 4, 5]
///         Dictionary:
///           [0: [1, 2, 3, 4], 1: [2, 3, 4], 2: [], 3: []]
///
///           Element at pos 0 -> 8
///           Elements that are lesser -> [6, 1, 4, 5]
///           Indexes of elements that are lesser -> [1, 2, 3, 4]
///
///           Element at pos 1 -> 6
///           Elements that are lesser -> [1, 4, 5]
///           Indexes of elements that are lesser -> [2, 3, 4]
///
///           Element at pos 2 -> 1
///           Elements that are lesser -> []
///           Indexes of elements that are lesser -> []
///
///           Element at pos 3 -> 4
///           Elements that are lesser -> []
///           Indexes of elements that are lesser -> []
///
///
func getDecreasingValuesIndexes(arr: [Int]) -> [Int: [Int]]{
    var decreasingValuesIndexes:[Int: [Int]] = [:]

    for i in 0..<(arr.count - 1) {
        let currentValue = arr[i]
        var indexes:[Int] = []
        for j in (i+1)..<arr.count {
            let nextValue = arr[j]
            if currentValue > nextValue  {
                indexes.append(j)
            }
        }
        decreasingValuesIndexes[i] = indexes
    }

    return decreasingValuesIndexes
}

///
/// This method finds all possible triplets with the given indexes dictionary
///
/// - Parameters:
///    - arr: array
///    - valuesIndexes: dictionary containing indexes of available elements to create a triplet
///
/// - Returns:
///     - Number of triplets
///
/// - Complexity: Worst case performance is O(*n^2*), where *n* is the length of the array.
///
///  This method:
///  1) Iterates over the array arr= arr[n] from i in 0..n-2 (not inclusive). The index at arr[i] will be considered as the 1st element index.
///  2) Gets the indexes of i from the dictionary and iterates over them b = b[m] from j in 0..m. The index at b[j] will be considered as the 2nd element index.
///  3) Gets the indexes of b[j] from the dictionary. If the array of indexes is greater than 0, it increases the triplets counter (3rd element)
///
func findTriplets(arr: [Int], valuesIndexes:[Int: [Int]]) -> Int {
    var counter = 0
    for i in 0..<(arr.count-2) {
        let secondIndexes = valuesIndexes[i] ?? []
        for secondIndex in secondIndexes {
            let thirdIndexes = valuesIndexes[secondIndex] ?? []
            counter += thirdIndexes.count
        }
    }
    return counter
}

print(maxInversions(arr: [15, 10, 1, 7, 8])) // 3
print(maxInversions(arr: [8, 6, 1, 4, 5])) // 3
print(maxInversions(arr: [8, 6, 1, 4, 2, 5])) // 6
print(maxInversions(arr: [5, 3, 4, 2, 1])) // 7
print(maxInversions(arr: [4, 2, 2, 1])) // 2
print(maxInversions(arr: [10, 15, 5, 1, 8, 3, 4, 2, 1])) // 40
print(maxInversions(arr: [615, 368, 260, 115, 944, 873, 353, 893, 961, 333, 527, 803, 474, 143, 469, 555, 918, 378, 147, 488, 349, 899, 191, 566, 695, 253, 741, 191, 903, 105, 363, 164, 749, 835, 181, 334, 212, 379, 859, 358, 869, 714, 318, 815, 730, 501, 760, 856, 411, 931])) // 2635