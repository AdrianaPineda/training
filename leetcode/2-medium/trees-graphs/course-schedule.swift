// https://leetcode.com/problems/course-schedule/

// Time complexity: O(n + v), n the number of courses and v the vertices
// Space complexity: O(n + v)
func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    var courses = [Int: [Int]]()
    for prereqTuple in prerequisites {
        guard prereqTuple.count == 2 else { continue }
        let course = prereqTuple[0]
        let prereq = prereqTuple[1]

        var currCourses = [course]
        if let cachedCourses = courses[prereq] {
            currCourses = currCourses + cachedCourses
        }

        courses[prereq] = currCourses
    }

    return isCyclical(courses)
}

func isCyclical(_ coursesGraph: [Int: [Int]]) -> Bool {
    for (prereq, courses) in coursesGraph {
        if canGetToTarget(target: prereq, courses: courses, coursesGraph) { return false }
    }

    return true
}

func canGetToTarget(target: Int, courses: [Int], _ coursesGraph: [Int: [Int]]) -> Bool {
    var coursesToVisit = courses
    var visited = Set<Int>()

    while !coursesToVisit.isEmpty {
        let currCourse = coursesToVisit.removeLast()
        if currCourse == target { return true }

        if visited.contains(currCourse) { continue }
        visited.insert(currCourse)
        coursesToVisit.append(contentsOf: coursesGraph[currCourse] ?? [])
    }

    return false
}

// Timeout
class Node {
    let val: Int
    var neighbors = [Node]()
    init(val: Int) { self.val = val }
    func add(node: Node) {
        neighbors.append(node)
    }
}

func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    let nodesDict = buildPrerequisitesGraph(prerequisites)

    for node in nodesDict.values {
        guard findMaxCourses(node: node) else { return false }
    }

    return true
}

func findMaxCourses(node: Node?, _ visitedNodes: Set<Int> = Set<Int>()) -> Bool {
    guard let node = node else { return true }

    var currentVisited = visitedNodes
    currentVisited.insert(node.val)
    for neighbor in node.neighbors {
        if currentVisited.contains(neighbor.val) { return false }
        guard findMaxCourses(node: neighbor, currentVisited) else { return false }
    }

    return true
}

// Alt
func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    let nodesDict = buildPrerequisitesGraph(prerequisites)

    var visitedNodes = Set<Int>()
    for node in nodesDict.values {
        guard findMaxCourses(node: node, &visitedNodes) else { return false }
    }

    return true
}

func findMaxCourses(node: Node?, _ visitedNodes: inout Set<Int>) -> Bool {
    guard let node = node else { return true }

    visitedNodes.insert(node.val)
    for neighbor in node.neighbors {
        if visitedNodes.contains(neighbor.val) { return false }
        guard findMaxCourses(node: neighbor, &visitedNodes) else { return false }
    }

    visitedNodes.remove(node.val) // backtracking

    return true
}

func buildPrerequisitesGraph(_ prerequisites: [[Int]]) -> [Int: Node] {
    var createdNodes = [Int: Node]()
    for prereqTuple in prerequisites {
        guard prereqTuple.count == 2 else { continue }
        let course = prereqTuple[0]
        let prereq = prereqTuple[1]

        let courseNode = createdNodes[course] ?? Node(val: course)
        let prereqNode = createdNodes[prereq] ?? Node(val: prereq)

        prereqNode.add(node: courseNode)
        createdNodes[course] = courseNode
        createdNodes[prereq] = prereqNode
    }

    return createdNodes
}

print(canFinish(20, [[0,10],[3,18],[5,5],[6,11],[11,14],[13,1],[15,1],[17,4]])) // false
print(canFinish(5, [[1,4],[2,4],[3,1],[3,2]])) // true
print(canFinish(1, [[]])) // true
print(canFinish(2, [[1,0]])) // true
print(canFinish(2, [[1,0],[0,1]])) // false

/**