# https://codeforces.com/problemset/problem/1285/B
# Problem
# Big O:
# Time complexity: O(n)
# Space complexity: O(n)

from functools import reduce


def is_tastiness_greater_or_equal_than(cupcakes_tastiness, tastiness_to_compare):
    total_tastiness = 0
    for tastiness in cupcakes_tastiness:
        total_tastiness += tastiness
        if total_tastiness >= tastiness_to_compare:
            return True

    return False


def will_yasser_be_happy(cupcakes_tastiness):
    yasser_tastiness = reduce((lambda x, y: x + y), cupcakes_tastiness)

    cupcakes_tastiness_without_last = cupcakes_tastiness[:-1]
    if is_tastiness_greater_or_equal_than(cupcakes_tastiness_without_last, yasser_tastiness):
        return False

    cupcakes_tastiness_reversed = cupcakes_tastiness[::-1]  # ::-1 for reverse
    cupcakes_tastiness_reverse_without_last = cupcakes_tastiness_reversed[:-1]
    if is_tastiness_greater_or_equal_than(cupcakes_tastiness_reverse_without_last, yasser_tastiness):
        return False

    return True


# Read input
test_cases = int(input())
responses = []
for i in range(0, test_cases):
    cupcakes = int(input())
    cupcakes_tastiness = [int(i) for i in input().split()]
    responses.append(will_yasser_be_happy(cupcakes_tastiness))

for response in responses:
    print("YES" if response else "NO")
