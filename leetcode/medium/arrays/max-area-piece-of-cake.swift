// https://leetcode.com/problems/maximum-area-of-a-piece-of-cake-after-horizontal-and-vertical-cuts/

// Time complexity: O(n*log(n) + m*log(m) + O(h*w*(n+m))
// Space complexity: O(n+m)
// Timeout
func maxArea(_ h: Int, _ w: Int, _ horizontalCuts: [Int], _ verticalCuts: [Int]) -> Int {
	var area = 0
	let sortedHorizontalCuts = horizontalCuts.sorted()
	let sortedVerticalCuts = verticalCuts.sorted()
	
    for i in 0..<h {
        for j in 0..<w {
            let verticalCut = getClosestCut(j, sortedVerticalCuts)
            let horizontalCut = getClosestCut(i, sortedHorizontalCuts)
            let currentArea = (j - verticalCut + 1) * (i - horizontalCut + 1)
            area = max(area, currentArea)
        }
    }	
	
    let aproxArea = area % Int(pow(10, 9) + 7)
	return aproxArea
}

func getClosestCut(_ position: Int, _ cuts: [Int]) -> Int {
	for k in 0..<cuts.count {
		let cut = cuts[k]
		let nextCut = k == (cuts.count - 1) ? Int.max : cuts[k+1]
		if cut <= position && nextCut > position {
			return cuts[k]
		}
    }

    return 0
}

// Alt
// Time complexity: O(n*log(n) + m*log(m)) + O(n*m)
// Space complexity: O(n+m)
// Timeout
func maxArea(_ h: Int, _ w: Int, _ horizontalCuts: [Int], _ verticalCuts: [Int]) -> Int {
	var area = 0
	let sortedHorizontalCuts = horizontalCuts.sorted() + [h]
	let sortedVerticalCuts = verticalCuts.sorted() + [w]
	
    var previousHorizCut = 0
    var previousVertiCut = 0

    for i in 0..<sortedHorizontalCuts.count {
        let currHorizontalCut = sortedHorizontalCuts[i]
        for j in 0..<sortedVerticalCuts.count {
            let currVerticalCut = sortedVerticalCuts[j]
            let currentArea = (currVerticalCut - previousVertiCut) * (currHorizontalCut - previousHorizCut)
            area = max(area, currentArea)

            previousVertiCut = currVerticalCut
        }

        previousHorizCut = currHorizontalCut
    }

    let aproxArea = area % Int(pow(10, 9) + 7)
	return aproxArea
}

// Alt
// Time complexity: O(n*log(n) + m*log(m)) + O(n + m)
// Space complexity: O(n+m)
func maxArea(_ h: Int, _ w: Int, _ horizontalCuts: [Int], _ verticalCuts: [Int]) -> Int {
    var area = 0
	let sortedHorizontalCuts = horizontalCuts.sorted() + [h]
	let sortedVerticalCuts = verticalCuts.sorted() + [w]

    let maxHeight = getMaxSize(sortedHorizontalCuts)
    let maxWidth = getMaxSize(sortedVerticalCuts)

    return (maxHeight * maxWidth) % Int(pow(10, 9) + 7)
}

func getMaxSize(_ cuts: [Int]) -> Int {
    var previousCut = 0
    var maxSize = 0
    for i in 0..<cuts.count {
        let currentCut = cuts[i]
        maxSize = max(maxSize, currentCut - previousCut)
        previousCut = currentCut
    }

    return maxSize
}
