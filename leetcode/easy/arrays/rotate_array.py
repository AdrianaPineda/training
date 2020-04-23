# https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/646/
# Problem
# Big O:
# Time complexity: O(n)
# Space complexity: O(1)

# Problem


class Solution(object):

    def rotate_number(self, nums, k, index, element):
        next_index = (index + k) % len(nums)
        next_element = nums[next_index]
        nums[next_index] = element

        return next_index, next_element

    def solve(self, nums, k):
        index = 0
        element = nums[index]
        same_index_passes = 0
        for _ in range(0, len(nums)):
            index, element = self.rotate_number(nums, k, index, element)

            is_next_index_rotated = index == same_index_passes
            if is_next_index_rotated:
                index += 1
                element = nums[index]
                same_index_passes += 1

    def rotate(self, nums, k):
        """
        :type nums: List[int]
        :type k: int
        :rtype: None Do not return anything, modify nums in-place instead.
        """
        if k == 0 or k == len(nums) or len(nums) == 1:
            return

        self.solve(nums, k)


solution = Solution()
nums = [1, 2, 3, 4, 5, 6]
solution.rotate(nums, 2)
print(nums)

# index = 0
# element = -1
# iterations = 0
# while (iterations < len(nums)):
#     next_index = 2 % 4 = 2
#     next_element = nums[2] = 3
#     nums[2] = -1 ===> [-1, -100, -1, 99]
#     element = 3
#     index = 2
#     iterations += 1
# while (iterations < len(nums)):
#     next_index = 4 % 4 = 0
#     next_element = nums[0] = -1
#     nums[0] = -3 ===> [3, -100, -1, 99]
#     element = 3
#     index = 2
#     iterations += 1


# index = 0
# element = nums[index]
# while (index != 0):
#     next_index = (index + k) % len(nums)
#     next_element = nums[next_index]
#     nums[next_index] = element
#     element = next_element
#     index = next_index


# sample: [1,2,3,4,5] k =2
# index = 0
# element = nums[0] = 1

# while 1:
#     next_index = (0 + 2) % 5 = 2%5 = 2
#     next_element = nums[2] = 3
#     nums[2] = 1 ===> [1,2,1,4,5]
#     element = 3
#     index = 2
# while 2:
#     next_index = (2 + 2) % 5 = 4 % 5 = 4
#     next_element = nums[4] = 5
#     nums[4] = 3 ===> [1,2,1,4,3]
#     element = 5
#     index = 4
# while 3:
#     next_index = (4 + 2) % 5 = 6 % 5 = 1
#     next_element = nums[1] = 2
#     nums[1] = 5 ===> [1,5,1,4,3]
#     element = 2
#     index = 1
# while 4:
#     next_index = (1 + 2) % 5 = 3 % 5 = 3
#     next_element = nums[3] = 4
#     nums[3] = 2 ===> [1,5,1,2,3]
#     element = 4
#     index = 3
# while 5:
#     next_index = (3 + 2) % 5 = 5%5 = 0
#     next_element = nums[0] = 1
#     nums[0] = 4 ===> [4,5,1,2,3]
#     element = 1
#     index = 0


# start at index i = 0
# element = arr[i]
# loop:
#     next_index = (i+k)%len(nums)
#     next_element = arr[next_index]
#     arr[next_index] = element

# sample: [1,2,3,4,5] k =2

# element = a[i] = ?
# next_index = (i+k)%len(nums) = 2
# arr[next_index] = element => ?
# next_element = arr[next_index] => next_element => ?
# result = ?

# [1,2,3,4,5]
# i = 0
# element = a[0] = 1
# next_index = (0+2)%5 = 2%5 = 2
# next_element = arr[next_index] => next_element = a[2] => next_element = 3 !!!
# arr[next_index] = element => arr[2] = 1
# result = [1, 2, 1, 4, 5]

# i = next_index = 2
# element !!!! = a[i] = value_to_put = next_element(previous_iteration) => 3
# next_index = (2+2)%5 = 4%5 = 4
# next_element = arr[next_index] => next_element = a[4] => 5!!!!
# arr[next_index] = element => arr[4] = 3
# result = [1, 2, 1, 4, 3]

# i = next_index = 4
# element !!!! = a[i] = value_to_put = next_element(previous_iteration) => 5
# next_index = (4+2)%5 = 6%5 = 1
# next_element = arr[next_index] => next_element = a[1] => 2!!!!
# arr[next_index] = element => arr[1] = 5
# result = [1, 5, 1, 4, 3]

# i = next_index = 1
# element !!!! = a[i] = value_to_put = next_element(previous_iteration) => 2
# next_index = (1+2)%5 = 3%5 = 3
# next_element = arr[next_index] => next_element = a[3] => next_element = 4 !!!!
# arr[next_index] = element => arr[3] = 2
# result = [1, 5, 1, 2, 3]

# i = next_index = 3
# element !!!! = a[i] = value_to_put = next_element(previous_iteration) => 4
# next_index = (3+2)%5 = 5%5 = 0
# next_element = arr[next_index] => next_element = a[0] => next_element = 1 !!!!
# arr[next_index] = element => arr[0] = 4
# result = [4, 5, 1, 2, 3]


# cases:
# no need to rotate any number because k = len(nums)
# need to rotate numbers
