// https://leetcode.com/explore/interview/card/facebook/54/sorting-and-searching-3/310/
//Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals, 
// and return an array of the non-overlapping intervals that cover all the intervals in the input.

/**
input => [[1,3],[2,6],[8,10],[15,18]]
result => [[1,6],[8,10],[15,18]]
*/

// Time complexity: O(n*log(n))
// Space complexity: O(n)
func merge(_ intervals: [[Int]]) -> [[Int]] {
	var result = [[Int]]()

	let intervalsSorted = intervals.sorted { $0[0] < $1[0]} // O(n*log(n))
	var start = intervalsSorted[0][0]
	var end = intervalsSorted[0][1]

	for i in 1..<intervalsSorted.count {
		let currInterval = intervalsSorted[i]
		let currStart = currInterval[0]
		let currEnd = currInterval[1]

		if currStart >= start && currStart <= end {
			end = max(end, currEnd)
			start = min(start, currStart)
			continue
		}

		result.append([start, end])
		start = currStart
		end = currEnd
	}

	result.append([start, end])

	return result
}

func merge(_ intervals: [[Int]]) -> [[Int]] {
	var result = [[Int]]()

	let intervalsSorted = intervals.sorted { $0[0] < $1[0]}
	var start = intervalsSorted[0][0]
	var end = intervalsSorted[0][1]

	for interval in intervalsSorted {
		if interval[0] <= end {
			end = max(end, interval[0])
			continue
		}

		result.append([start, end])
		start = interval[0]
		end = interval[1]
	}

	result.append([start, end])
	
	return result
}

func merge(_ intervals: [[Int]]) -> [[Int]] {
	var result = [[Int]]()

	let intervalsSorted = intervals.sorted { $0[0] < $1[0]}

	for interval in intervalsSorted {
		let lastInterval = result.last ?? interval

		if interval[0] > lastInterval[1] {
			result.append(interval)
			continue
		}

		result.popLast()
		result.append([lastInterval[0], max(interval[1], lastInterval[1])])
	}

	return result
}

print(merge([[1,3],[2,6],[8,10],[15,18]])) // [[1, 6], [8, 10], [15, 18]]
print(merge([[1,4],[4,5]])) // [[1, 5]]
print(merge([[1,4],[0,4]])) // [[0, 4]]
print(merge([[1,4],[2,3]])) // [[1, 4]
print(merge([[2,3],[4,5],[6,7],[8,9],[1,10]])) // [[1, 10]]