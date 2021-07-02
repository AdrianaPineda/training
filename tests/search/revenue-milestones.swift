/**
We keep track of the revenue Facebook makes every day, and we want to 
know on what days Facebook hits certain revenue milestones. Given an 
array of the revenue on each day, and an array of milestones Facebook 
wants to reach, return an array containing the days on which Facebook reached every milestone.

Signature
    int[] getMilestoneDays(int[] revenues, int[] milestones)

Input
    revenues is a length-N array representing how much revenue FB made 
    on each day (from day 1 to day N). milestones is a length-K array of total revenue milestones.

Output
    Return a length-K array where K_i is the day on which FB first had 
    milestones[i] total revenue. If the milestone is never met, return -1.

Example
    revenues = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
    milestones = [100, 200, 500]

    output = [4, 6, 10]

    Explanation
    On days 4, 5, and 6, FB has total revenue of $100, $150, and $210 respectively. 
    Day 6 is the first time that FB has >= $200 of total revenue.
*/
// Add any helper functions you may need here

// revenues_2 = [700, 800, 600, 400, 600, 700]
// milestones_2 = [3100, 2200, 800, 2100, 1000]
// expected_2 = [5, 4, 2, 3, 2]

// 1) hash table => [milestone: index]
//    milestonesIndexes: [ 3100: 0  , 2200:  1,  800: 2, 2100: 3, 1000: 4 ]
// 2) sort milestones => [800, 1000, 2100, 2200, 3100]
// currMilestone = 0 (800)
// 3) loop revenues, total sum
//    sum >= currMilestone
//    hash[currMilestone] -> currIndex, result[currIndex] = loopIndex + 1
//    nextMilestone   

// sum = 1500
// currMilestone = 0 => 800, 1 => 1000, 2 => 2100

// Brute-force
// Time complexity: O(n*m)
// Space complexity: O(1)
func getMilestoneDays(_ revenues: [Int], _ milestones: [Int]) -> [Int] {
    var results = [Int]()
    for milestone in milestones {
        var sum = 0
        for (i, revenue) in revenues.enumerated() {
            sum += revenue
            if sum >= milestone {
                results.append((i + 1))
                break
            }
        }
    }
    
    return results
}

// Time complexity: O(n*log(n) + O(m + n)), n the number of milestones, m the number of revenues
// Space complexity: O(n)
func getMilestoneDays(_ revenues: [Int], _ milestones: [Int]) -> [Int] {
  var milestonesIndexes = [Int: Int]()
  for (i, milestone) in milestones.enumerated() {
    milestonesIndexes[milestone] = i
  }
  
  var results = Array(repeating: 0, count: milestones.count)
  let sortedMilestones = milestones.sorted() // O(n*log(n))
  var sum = 0
  var currMilestone = 0
  for (j, revenue) in revenues.enumerated() {
    guard currMilestone < milestones.count else {
      break
    }
    
    sum += revenue
    
    while currMilestone < milestones.count && sum >= sortedMilestones[currMilestone] {
      let milestone = sortedMilestones[currMilestone]
      guard let currMilestoneIndex = milestonesIndexes[milestone] else {
        continue
      }
      
      results[currMilestoneIndex] = (j + 1)
      currMilestone += 1
    }
    
  }
  
  return results

}

print(getMilestoneDays([10, 20, 30, 40, 50, 60, 70, 80, 90, 100], [100, 200, 500])) // [4, 6, 10]
print(getMilestoneDays([700, 800, 600, 400, 600, 700], [3100, 2200, 800, 2100, 1000])) // [5, 4, 2, 3, 2]
print(getMilestoneDays([100, 200, 300, 400, 500], [300, 800, 1000, 1400])) // [2, 4, 4, 5]
