// https://leetcode.com/explore/interview/card/facebook/52/trees-and-graphs/274/

/**
Input: grid = [
  ["1","1","1","1","0"],
  ["1","1","0","1","0"],
  ["1","1","0","0","0"],
  ["0","0","0","0","0"]
]

result: 1


Input: grid = [
  ["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
]

result: 3

Input: grid = [
    ["1","1","1"],
    ["0","1","0"],
    ["1","1","1"]
]
*/

struct Point: Hashable {
	let i: Int
	let j: Int
	init(i: Int, j: Int) {
		self.i = i
		self.j = j
	}
}

// Time complexity: O(m*n)
// Space complexity: O(m*n)
func numIslands(_ grid: [[Character]]) -> Int {
	var islands = 0
	var visitedPoints = [Point: Bool]()
	var pointsToVisit = [Point]()

	for i in 0..<grid.count { // row
		for j in 0..<grid[i].count { //column
			let point = Point(i: i, j: j)

			if visitedPoints[point] != nil || grid[i][j] == "0" { // visited or water
				continue
			}

			islands += 1

			pointsToVisit.append(point)
			while !pointsToVisit.isEmpty {
				let point = pointsToVisit.removeLast()
				visitedPoints[point] = true
				updatePointsToVisit(&pointsToVisit, i: point.i, j: point.j, grid: grid, visitedPoints)
			}
		}
	}

	return islands
}

func updatePointsToVisit(_ pointsToVisit: inout [Point], i: Int, j: Int, grid: [[Character]], _ visitedPoints: [Point: Bool]) {
	if j > 0 && grid[i][j - 1] == "1" && visitedPoints[Point(i: i, j: j - 1)] == nil { // to the left
		pointsToVisit.append(Point(i:i, j: j - 1))
	}

	if i > 0 && grid[i-1][j] == "1" && visitedPoints[Point(i: i - 1, j: j)] == nil { // to the top
		pointsToVisit.append(Point(i:i - 1, j: j))
	}

	if j < grid[i].count - 1 && grid[i][j + 1] == "1" && visitedPoints[Point(i: i, j: j + 1)] == nil { // to the right
		pointsToVisit.append(Point(i:i, j: j + 1))
	}

	if i < grid.count - 1 && grid[i + 1][j] == "1" && visitedPoints[Point(i: i + 1, j: j)] == nil { // to the bottom
		pointsToVisit.append(Point(i:i + 1, j: j))
	}
}

// Time complexity: O(m*n)
// Space complexity: O(max(m*n))
func numIslands(_ grid: inout [[Character]]) -> Int {
	var islands = 0
	var pointsToVisit = [Point]()

	for i in 0..<grid.count { // row
		for j in 0..<grid[i].count { //column
			let point = Point(i: i, j: j)

			if grid[i][j] == "0" { // visited or water
				continue
			}

			islands += 1

			pointsToVisit.append(point)
			while !pointsToVisit.isEmpty {
				let point = pointsToVisit.removeLast()
				grid[point.i][point.j] = "0"
				updatePointsToVisit(&pointsToVisit, i: point.i, j: point.j, grid: grid)
			}
		}
	}

	return islands
}

func updatePointsToVisit(_ pointsToVisit: inout [Point], i: Int, j: Int, grid: [[Character]]) {
	if j > 0 && grid[i][j - 1] == "1" { // to the left
		pointsToVisit.append(Point(i:i, j: j - 1))
	}

	if i > 0 && grid[i-1][j] == "1" { // to the top
		pointsToVisit.append(Point(i:i - 1, j: j))
	}

	if j < grid[i].count - 1 && grid[i][j + 1] == "1" { // to the right
		pointsToVisit.append(Point(i:i, j: j + 1))
	}

	if i < grid.count - 1 && grid[i + 1][j] == "1" { // to the bottom
		pointsToVisit.append(Point(i:i + 1, j: j))
	}
}