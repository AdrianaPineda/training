# https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/727/
# Problem
# Big O:
# Time complexity: O(n)
# Space complexity: O(1)

# Problem


class Solution(object):
    def getNextNumberIndex(self, nums, i):
        current_number = nums[i]
        for j in range(i+1, len(nums)):
            if nums[j] > current_number:
                return j

        return -1

    def removeDuplicates(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        response = len(nums)
        for i in range(1, len(nums)):
            previous_number = nums[i-1]
            if previous_number >= nums[i]:
                next_number_index = self.getNextNumberIndex(nums, i-1)
                if next_number_index != -1:
                    nums[i] = nums[next_number_index]
                else:
                    response = i
                    break

        return response


solution = Solution()
print(solution.removeDuplicates([0, 0, 1, 1, 1, 2, 2, 3, 3, 4]))
print(solution.removeDuplicates([1, 1, 2]))
print(solution.removeDuplicates([1, 2]))
print(solution.removeDuplicates([1, 2, 3]))
