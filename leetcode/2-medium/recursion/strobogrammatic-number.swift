// https://leetcode.com/explore/interview/card/facebook/53/recursion-3/3029/

// Given an integer n, return all the strobogrammatic numbers that are of length n. You may return the answer in any order.
// A strobogrammatic number is a number that looks the same when rotated 180 degrees (looked at upside down).
//
// Example 1:
// Input: n = 2
// Output: ["11","69","88","96"]
//
// Example 2:
// Input: n = 1
// Output: ["0","1","8"]


/**
0 => 0
1 => 1
6 => 9
8 => 8
9 => 6

n
 1: 0, 1, 8
 2: 00, 11, 88, 96, 69
 3: 101, 111, 181, 609, 906, 619, 916, 689, 986, 808, 818, 888
 4: 1001, 1111, 1881, 1691, 1961, 6009, 9006, 6119, 9116, 6889, 9886, 6969, 9966, 6699, 9696, 8008, 8118, 8888, 8698, 8968
 6: 101101
  
 3 => 
    2 => "0", "1", "8"

        1   101 111 181
        6   609 619 689
        8   801 818 888
        9   906 916 986
**/

// Time complexity: O(n*5^(n/2))
// Space complexity: O(n*5^(n/2)) & O(n/2) for recursive stack
func findStrobogrammatic(_ n: Int) -> [String] {
    return findStrobogrammaticRecursive(n, count: n)
}

func findStrobogrammaticRecursive(_ n: Int, count: Int) -> [String] {
    if count == 1 {
        return ["0", "1", "8"]
    }

    if count == 2 {
        if count == n {
            return ["11", "88", "96", "69"]
        } else {
            return ["00", "11", "88", "96", "69"]
        }
    }

    let numbers = findStrobogrammaticRecursive(n, count: count - 2)
    var strobogrammaticNums = [String]()
    let extremeNums = n == count ? [1, 6, 8, 9] : [0, 1, 6, 8, 9]
    for i in extremeNums {
        for num in numbers {
            let start = i
            let end = getStrobogrammaticNum(num: i)
            strobogrammaticNums.append("\(start)\(num)\(end)")
        }
    }

    return strobogrammaticNums
}

func findStrobogrammaticRecursive(_ n: Int, count: Int) -> [String] {
        if count < 1 {
            return [""]
        }
        
        if count == 1 {
            return ["0", "1", "8"]
        }

        let numbers = findStrobogrammaticRecursive(n, count: count - 2)
        var strobogrammaticNums = [String]()
        let extremeNums = n == count ? [1, 6, 8, 9] : [0, 1, 6, 8, 9]
        for i in extremeNums {
            for num in numbers {
                let start = i
                let end = getStrobogrammaticNum(num: i)
                strobogrammaticNums.append("\(start)\(num)\(end)")
            }
        }

        return strobogrammaticNums
    }

func getStrobogrammaticNum(num: Int) -> Int {
    switch num {
    case 6:
        return 9
    case 9:
        return 6
    default:
        return num
    }
}

print(findStrobogrammatic(1)) // ["0","1","8"]
print(findStrobogrammatic(2)) // ["11","69","88","96"]
print(findStrobogrammatic(3)) // [101 111 181 609 619 689 801 818 888 906 916 986]
print(findStrobogrammatic(4)) // ["1001","1111","1691","1881","1961","6009","6119","6699","6889","6969","8008","8118","8698","8888","8968","9006","9116","9696","9886","9966"]