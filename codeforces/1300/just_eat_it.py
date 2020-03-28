# https://codeforces.com/problemset/problem/1285/B
# Problem
# Big O:
# Time complexity:
# Space complexity:


def will_yasser_be_happy(cupcakes_tastiness):
    number_of_cupcakes = len(cupcakes_tastiness)
    max_column = 0
    max_tastiness = cupcakes_tastiness[0]
    tastiness = [cupcakes_tastiness[0]]
    for i in range(1, number_of_cupcakes):
        previous_tastiness = tastiness[i-1]
        current_tastiness = cupcakes_tastiness[i] + previous_tastiness
        tastiness.append(current_tastiness)
        if current_tastiness > max_tastiness and i < (number_of_cupcakes - 1):
            max_tastiness = current_tastiness
            max_column = i

    yasser_tastiness = tastiness[i]
    if max_tastiness >= yasser_tastiness:
        return "NO"

    new_max = 0
    new_tastiness = []
    new_tastiness.append(tastiness[i])
    for i in range(1, number_of_cupcakes):
        previous_tastiness = new_tastiness[i-1]
        current_tastiness = new_tastiness[i-1] - cupcakes_tastiness[i - 1]
        new_tastiness.append(current_tastiness)
        if current_tastiness >= yasser_tastiness:
            return "NO"

    return "YES"


# Read input
test_cases = int(input())
responses = []
for i in range(0, test_cases):
    cupcakes = int(input())
    cupcakes_tastiness = [int(i) for i in input().split()]
    responses.append(will_yasser_be_happy(cupcakes_tastiness))

for response in responses:
    print(response)
