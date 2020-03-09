# https://codeforces.com/contest/743/problem/A

# Problem
# Big O:
# Time complexity: O(n)
# Space complexity: O(n)

# Problem


def minimum_cost_between_airports(vladiks_house, olympiad, airports):
    return 1 if airports[vladiks_house] != airports[olympiad] else 0


# Read input
first_line = input().split()
_, vladiks_house, olympiad = (int(i) for i in first_line)

airports = list(input())
print(minimum_cost_between_airports(vladiks_house - 1, olympiad - 1, airports))
