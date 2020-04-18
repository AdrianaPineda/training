# https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/549/
# Problem
# Big O:
# Time complexity: O(n*log(n)) + O(n) => O(n)
# Space complexity: O(1)

# Problem


class Solution(object):
    def singleNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        nums.sort()
        previous_number = nums[0]
        previous_number_occurrences = 1
        for i in range(1, len(nums)):
            current_number = nums[i]

            if previous_number == current_number:
                previous_number_occurrences += 1
                continue

            if previous_number_occurrences == 1:
                break
            else:
                previous_number_occurrences = 1
                previous_number = current_number

        return previous_number


solution = Solution()
print(solution.singleNumber([1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 6]))
