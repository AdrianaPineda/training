// https://leetcode.com/problems/employee-free-time/

class Interval {
    var start: Int
    var end: Int
    public init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}

// Timeout
func employeeFreeTime(_ scheduleUnSorted: [[Interval]]) -> [Interval] {
    let schedule = sortSchedule(scheduleUnSorted)
    let (firstStartTime, lastStartTime) = getStartTimes(schedule)
    var workingTimes = Array(repeating: 0, count: (lastStartTime - firstStartTime + 1))

    for interval in schedule {
        let startTime = interval.start
        let endTime = interval.end
        workingTimes[startTime - firstStartTime] = workingTimes[startTime - firstStartTime] + 1
        workingTimes[endTime - firstStartTime] = workingTimes[endTime - firstStartTime] - 1
    }

    var freeTimes = [Interval]()
    var currSum = 0
    var currStart = 0
    var currEnd = 0
    for (i, time) in workingTimes.enumerated() {
        currSum += time

        if currSum == 0 {
            let prevTime = currSum - time
            if prevTime != 0 && currStart == 0 {
                currStart = (i + firstStartTime)
            }
            currEnd = (i + firstStartTime + 1)
        } else {
            if currStart  != 0 && currEnd != 0 {
                freeTimes.append(Interval(currStart, currEnd))
                currStart = 0
                currEnd = 0
            }
        }
    }

    return freeTimes
}

func sortSchedule(_ schedule: [[Interval]]) -> [Interval] {
    var joinedSchedules = [Interval]()

    for intervals in schedule {
        joinedSchedules.append(contentsOf: intervals)
    }

    return joinedSchedules.sorted { $0.start < $1.start }
}

func getStartTimes(_ schedule: [Interval]) -> (Int, Int) {

    var firstStartTime = Int.max
    var lastStartTime = Int.min

    for interval in schedule {
        firstStartTime = min(firstStartTime, interval.start)
        lastStartTime = max(lastStartTime, interval.end)
    }

    return (firstStartTime, lastStartTime)
}

// ===============

// e: number of employes
// i: number of intervals per employee
// Time complexity: O(e*i + e*i*log(e*i) + e*i) => O(e*i*log(e*i))
// Space complexity: O(e*i)
func employeeFreeTime(_ schedule: [[Interval]]) -> [Interval] {
    let sortedSchedule = sortSchedule(schedule)
    var freeTimes = [Interval]()
    var currStart = sortedSchedule[0].start
    var currEnd = sortedSchedule[0].end
    for interval in sortedSchedule {
        let startTime = interval.start
        let endTime = interval.end

        if startTime >= currStart && startTime <= currEnd {
            currEnd = max(currEnd, endTime)
            continue
        }

        freeTimes.append(Interval(currEnd, startTime))
        currStart = startTime
        currEnd = endTime
    }

    return freeTimes
}

func sortSchedule(_ schedule: [[Interval]]) -> [Interval] {
    var joinedSchedules = [Interval]()

    for intervals in schedule {
        joinedSchedules.append(contentsOf: intervals)
    }

    return joinedSchedules.sorted { $0.start < $1.start }
}

let schedule = [[Interval(1, 2), Interval(5, 6)], [Interval(1, 3), Interval(4, 10)]]
let response = employeeFreeTime(schedule)
print(" \(response.count) => \(response[0].start) - \(response[0].end)") // [[3,4]]

let schedule2 = [[Interval(1, 3), Interval(6, 7)], [Interval(2, 4), Interval(2, 5), Interval(9, 12)]]
let response2 = employeeFreeTime(schedule2)
print(" \(response2.count) => \(response2[0].start) - \(response2[0].end) - \(response2[1].start) - \(response2[1].end)") // [[5,6],[7,9]]

let schedule3 = [[Interval(45, 56), Interval(89, 96)], [Interval(5, 21), Interval(57, 74)]]
let response3 = employeeFreeTime(schedule3)
print(" \(response3.count) => \(response3[0].start) - \(response3[0].end) = \(response3[1].start) - \(response3[1].end) = \(response3[2].start) - \(response3[2].end) ") // [[21,45],[56,57],[74,89]]
