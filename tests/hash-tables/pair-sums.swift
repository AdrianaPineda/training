// Pair sums
/**
Given a list of n integers arr[0..(n-1)], determine the number of 
different pairs of elements within it which sum to k.
If an integer appears in the list multiple times, each copy is 
considered to be different; that is, two pairs are considered 
different if one pair includes at least one array index which
 the other doesn't, even if they include the same values.

Signature
    int numberOfWays(int[] arr, int k)

Input
    n is in the range [1, 100,000].
    Each value arr[i] is in the range [1, 1,000,000,000].
    k is in the range [1, 1,000,000,000].

Output
    Return the number of different pairs of elements which sum to k.

Example 1
    n = 5
    k = 6
    arr = [1, 2, 3, 4, 3]
    output = 2
    The valid pairs are 2+4 and 3+3.

Example 2
    n = 5
    k = 6
    arr = [1, 5, 3, 3, 3]
    output = 4
    There's one valid pair 1+5, and three different valid pairs 3+3 (the 3rd 
    and 4th elements, 3rd and 5th elements, and 4th and 5th elements).
*/

// Add any helper functions you may need here
func getNumberOcurrences(arr: [Int]) -> [Int: Int] {
    var numberOcurrences = [Int: Int]()
    for num in arr {
        guard let ocurrence = numberOcurrences[num] else {
            numberOcurrences[num] = 1
            continue
        }
        numberOcurrences[num] = ocurrence + 1
    }
    return numberOcurrences
}

// Time complexity: O(n)
// Space complexity: O(n)
func numberOfWays(arr: [Int], k: Int) -> Int {
    // Write your code here
    var numberOcurrences = getNumberOcurrences(arr: arr)
    var result = 0
  
    for num in arr {
        let corresponding = abs(num - k)
        guard let ocurrence = numberOcurrences[corresponding], ocurrence > 0 else {
            continue
        }
    
        result += ocurrence
        if num == corresponding {
            result -= 1
        }
    
        numberOcurrences[num] = (numberOcurrences[num] ?? 0) - 1
    }

    print(numberOcurrences)
    return result
}

func numberOfWaysAlt(arr: [Int], k: Int) -> Int {
    // Write your code here
    let numberOcurrences = getNumberOcurrences(arr: arr)
    var result = 0
  
    for num in arr {
        let corresponding = abs(num - k)
        guard let ocurrence = numberOcurrences[corresponding], ocurrence > 0 else {
            continue
        }
    
        result += ocurrence
        if num == corresponding {
            result -= 1
        }
    }

    print(numberOcurrences)
    return result / 2 // results are counted twice
}

let arr1 = [ 1, 2, 3, 4, 3]
let k1 = 6
print(numberOfWays(arr: arr1, k: 6)) // 2

let arr2 = [ 1, 5, 3, 3, 3]
let k2 = 6
print(numberOfWays(arr: arr2, k: 6)) // 4
