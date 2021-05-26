// https://leetcode.com/explore/interview/card/facebook/57/others-3/3043/

/**
You are given two lists of closed intervals, firstList and secondList, 
where firstList[i] = [starti, endi] and secondList[j] = [startj, endj]. 
Each list of intervals is pairwise disjoint and in sorted order.

Return the intersection of these two interval lists.

A closed interval [a, b] (with a < b) denotes the set of real numbers x with a <= x <= b.

The intersection of two closed intervals is a set of real numbers that are either empty 
or represented as a closed interval. For example, the intersection of [1, 3] and [2, 4] is [2, 3].
*/

/**
Input: 
    firstList = [[0,2],[5,10],[13,23],[24,25]], 
    secondList = [[1,5],[8,12],[15,24],[25,26]]

Output: 
    [[1,2],[5,5],[8,10],[15,23],[24,24],[25,25]]

*/

struct Range {
	var start: Int
	var end: Int
}

// Time complexity: O(min(m, n))
// Space complexity: O(min(m, n))
//  being m and n the lengths of each list
func intervalIntersection(_ firstList: [[Int]], _ secondList: [[Int]]) -> [[Int]] {
	var result = [[Int]]()

	var firstListCounter = 0
	var secondListCounter = 0

	var pointer1: Range? = firstList.count > firstListCounter ? Range(start: firstList[firstListCounter][0], end: firstList[firstListCounter][1]) : nil
	var pointer2: Range? = secondList.count > secondListCounter ? Range(start: secondList[secondListCounter][0], end: secondList[secondListCounter][1]) : nil

	while let pointer1UW = pointer1, let pointer2UW = pointer2 {
		let lowerBound = max(pointer1UW.start, pointer2UW.start)
		let upperBound = min(pointer1UW.end, pointer2UW.end)

		if (upperBound >= lowerBound) {
			result.append([lowerBound, upperBound])
		}

		if pointer1UW.end <= pointer2UW.end {
			firstListCounter += 1
			pointer1 = firstList.count > firstListCounter ? Range(start: firstList[firstListCounter][0], end: firstList[firstListCounter][1]) : nil
		}

		if pointer2UW.end <= pointer1UW.end {
			secondListCounter += 1
			pointer2 = secondList.count > secondListCounter ? Range(start: secondList[secondListCounter][0], end: secondList[secondListCounter][1]) : nil
		}
	}

	return result
}

// Without struct Range and without pointers
func intervalIntersection(_ firstList: [[Int]], _ secondList: [[Int]]) -> [[Int]] {
	var result = [[Int]]()

	var firstListCounter = 0
	var secondListCounter = 0

	while firstList.count > firstListCounter && secondList.count > secondListCounter {
		let pointer1Start = firstList[firstListCounter][0]
		let pointer2Start = secondList[secondListCounter][0]
		let pointer1End = firstList[firstListCounter][1]
		let pointer2End = secondList[secondListCounter][1]

		let lowerBound = max(pointer1Start, pointer2Start)
		let upperBound = min(pointer1End, pointer2End)

		if (upperBound >= lowerBound) {
			result.append([lowerBound, upperBound])
		}

		if pointer1End <= pointer2End {
			firstListCounter += 1
		}

		if pointer2End <= pointer1End {
			secondListCounter += 1
		}
	}

	return result
}

print(intervalIntersection([[0,2],[5,10],[13,23],[24,25]], [[1,5],[8,12],[15,24],[25,26]])) // [[1, 2], [5, 5], [8, 10], [15, 23], [24, 24], [25, 25]]
print(intervalIntersection([[1,3],[5,9]], [])) // []
print(intervalIntersection([], [[4,8],[10,12]])) // []
print(intervalIntersection([[1,7]], [[3,10]])) // [3, 7]

/**
Debugging

results = [[1, 2], [5, 5], [8, 10], [13, 25], [24, 24], [25, 25]]

counter1 = 0
counter2 = 0

pointer1 = (start: 0, end: 2)
pointer2 = (start: 1, end: 5)

    lowerBound = 1
    upperBound = 2

===
counter1 = 1
counter2 = 0

pointer1 = (start: 5, end: 10)
pointer2 = (start: 1, end: 5)

    lowerBound = 5
    upperBound = 5

===
counter1 = 1
counter2 = 1

pointer1 = (start: 5, end: 10)
pointer2 = (start: 8, end: 12)

    lowerBound = 8
    upperBound = 10

===
counter1 = 2
counter2 = 1

pointer1 = (start: 13, end: 23)
pointer2 = (start: 8, end: 12)

    lowerBound = 13
    upperBound = 12

===
counter1 = 2
counter2 = 2

pointer1 = (start: 13, end: 23)
pointer2 = (start: 15, end: 24)

    lowerBound = 15
    upperBound = 23

===
counter1 = 3
counter2 = 2

pointer1 = (start: 24, end: 25)
pointer2 = (start: 15, end: 24)

    lowerBound = 24
    upperBound = 24

===
counter1 = 3
counter2 = 3

pointer1 = (start: 24, end: 25)
pointer2 = (start: 25, end: 26)

    lowerBound = 25
    upperBound = 25

===
counter1 = 4
counter2 = 3

pointer1 = (start: 24, end: 25)
pointer2 = (start: 25, end: 26)

    lowerBound = 25
    upperBound = 25

*/