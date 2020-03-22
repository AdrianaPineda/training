# https://codeforces.com/problemset/problem/1221/C
# Problem
# Big O:
# Time complexity: O(1)
# Space complexity: O(1)
members_per_team = 3


def find_perfect_teams(coders, mathematicians, specializationlesses):
    students = coders + mathematicians + specializationlesses
    if (students < members_per_team):
        return 0
    minimum_coders_and_mathematicians = min(coders, mathematicians)
    possible_teams = students // members_per_team
    return min(minimum_coders_and_mathematicians, possible_teams)


# Read input
queries = int(input())
responses = []
for _ in range(queries):
    query = input().split()
    coders, mathematicians, specializationlesses = (int(x) for x in query)
    response = find_perfect_teams(coders, mathematicians, specializationlesses)
    responses.append(response)

for response in responses:
    print(response)
