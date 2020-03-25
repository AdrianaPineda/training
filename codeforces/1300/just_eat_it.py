# https://codeforces.com/problemset/problem/1285/B
# Problem
# Big O:
# Time complexity:
# Space complexity:


def will_yasser_be_happy(cupcakes_tastiness):
    return "YES"


# Read input
test_cases = int(input())
responses = []
for i in range(0, test_cases):
    cupcakes = int(input())
    cupcakes_tastiness = input().split()
    responses.append(will_yasser_be_happy(cupcakes_tastiness))

for response in responses:
    print(response)
