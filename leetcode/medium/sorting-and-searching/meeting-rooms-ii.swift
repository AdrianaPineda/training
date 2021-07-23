// https://leetcode.com/problems/meeting-rooms-ii/
/**

Example 1:
    Input: intervals = [[0,30],[5,10],[15,20]]
    Output: 2

Example 2:
    Input: intervals = [[7,10],[2,4]]
    Output: 1

           |----|
    |---|
|--------------------|
0                    30

|----|      |--------|
|--------------------|
2                    10



[2, 4]
[3, 10]
[4, 10]
[7, 10]


1) sort interval (start interval)
1a) sort interval (end interval)
2) keep max concurrent meetings

pointer start
pointer end
*/

// Time complexity: O(n*log(n))
// Space complexity: O(n)
func minMeetingRooms(_ intervals: [[Int]]) -> Int {
    let startIntervals = intervals.sorted { $0[0] < $1[0] } // O(n*log(n))
    let endIntervals = intervals.sorted { $0[1] < $1[1] } // O(n*log(n))

    var startPointer = 0
    var endPointer = 0

    var maxMeeting = 0
    var concurrentMeetings = 0
    while startPointer < startIntervals.count {
        let startInter = startIntervals[startPointer][0]
        let endInter = endIntervals[endPointer][1]

        if startInter <= endInter {
            startPointer += 1
            concurrentMeetings += 1
        }

        if endInter <= startInter {
            concurrentMeetings -= 1
            endPointer += 1
        }

        maxMeeting = max(concurrentMeetings, maxMeeting)
    }

    return maxMeeting
}