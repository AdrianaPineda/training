# https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/546/
# Problem
# Big O:
# Time complexity:
# Solution 1: ~O(n^2)
# Solution 2: O(n) + O(n) => O(n)
# Solution 3: O(n)
# Space complexity:
# Solution 1: O(1)
# Solution 2: O(n)
# Solution 3: O(n)

# Problem

# Read input


class Solution3(object):
    def twoSum(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        dictionary = {}
        for i in range(0, len(nums)):
            second_number = target - nums[i]
            second_number_index = dictionary.get(second_number)
            if second_number_index:
                return [second_number_index, i]
            dictionary[nums[i]] = i

        return []


class Solution2(object):
    def twoSum(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        dictionary = {}
        for i in range(0, len(nums)):
            dictionary[nums[i]] = i

        for i in range(0, len(nums)):
            first_number = nums[i]
            second_number = target - first_number
            second_number_index = dictionary.get(second_number)
            if second_number_index and second_number_index != i:
                return [i, second_number_index]

        return []


class Solution(object):
    def getNumberIndex(self, start, nums, number):
        for j in range(start, len(nums)):
            current_number = nums[j]
            if current_number == number:
                return j
        return -1

    def twoSum(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        for i in range(0, len(nums)):
            first_number = nums[i]
            start = i + 1
            second_number = target - first_number
            second_number_index = self.getNumberIndex(
                start, nums, second_number)
            if second_number_index >= 0:
                return [i, second_number_index]

        return []


solution = Solution3()
print(solution.twoSum([2, 7], 9))
print(solution.twoSum([2, 7, 11, 15], 9))
print(solution.twoSum([-1, -2, -3, -4, -5], -8))
print(solution.twoSum([1, 3, 4, 2], 6))

# [2, 7, 11, 15], target 9
# i = 0
#   first_number = 2
#   start = 1
#   second_number = 9 - 2 = 7
#   nums[j]= 7
#   return

# [2, 7, 11, 15], target 17
# i = 0
#   first_number = 2
#   start = 1
#   second_number = 17 - 2 = 15
#   j = 1, nums[j]= 7
#   j = 2, nums[j] = 11
#   j = 3, nums[j] = 15

# [2, 7, 11, 15], target 26
# i = 0
#   first_number = 2
#   start = 1
#   second_number = 26 - 2 = 24
#   j = 1, nums[j]= 7
#   j = 2, nums[j] = 11
#   j = 3, nums[j] = 15
# i = 1
#   first_number = 7
#   start = 2
#   second_number = 26 - 7 = 19
#   j = 2, nums[j] = 11
#   j = 3, nums[j] = 15
# i = 2
#   first_number = 11
#   start = 3
#   second_number = 26 - 11 = 15
#   j = 3, nums[j] = 15

# [2, 7], target 9
# i = 0
#   first_number = 2
#   start = 1
#   second_number = 9 - 2 = 7
#   j = 1, nums[j]= 7
