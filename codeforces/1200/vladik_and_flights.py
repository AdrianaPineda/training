# https://codeforces.com/contest/743/problem/A

# Problem
# Big O:
# Time complexity: O(n)
# Space complexity: O(n)

# Problem


def minimum_cost_between_airports(vladiks_house, olympiad, airports_companies):
    return 1 if airports_companies[vladiks_house] != airports_companies[olympiad] else 0


# Read input
first_line = input().split()
_, vladiks_house, olympiad = (int(i) for i in first_line)

airports_companies = list(input())
print(minimum_cost_between_airports(
    vladiks_house - 1, olympiad - 1, airports_companies))
