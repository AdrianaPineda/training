# https://codeforces.com/problemset/problem/1315/B
# Problem
# Big O:
# Time complexity: O(n) + O(n) => O(n)
# Space complexity: O(n-1) => O(n)

# Problem

# Solution:
# 1) Iterate over crossroad char array and detect indexes at which the crossroad changed.
# 2) Iterate over array returned in step 1 backwards, determine the cost based on the crossroad type
#    and stop when the cost is greater or equal than the budget


def crossroad_station_cost(crossroad, bus_ticket, tram_ticket):
    if (crossroad == "A"):
        return bus_ticket
    return tram_ticket


def get_crossroad_change_indexes(crossroads):
    crossroads_length = len(crossroads)
    current_crossroad = crossroads[0]
    crossroad_change_indexes = [0]
    i = 1
    while (i < crossroads_length - 1):
        if crossroads[i] != current_crossroad:
            current_crossroad = crossroads[i]
            crossroad_change_indexes.append(i)
        i += 1
    return crossroad_change_indexes


def find_closest_road_index(bus_ticket, tram_ticket, budget, crossroads):
    cost = 0

    crossroads_length = len(crossroads)
    crossroad_change_index = crossroads_length - 1

    crossroad_change_indexes = get_crossroad_change_indexes(crossroads)
    j = len(crossroad_change_indexes) - 1

    while cost <= budget and j >= 0:
        crossroad_index = crossroad_change_indexes[j]
        current_crossroad = crossroads[crossroad_index]
        current_cost = crossroad_station_cost(
            current_crossroad, bus_ticket, tram_ticket)
        cost += current_cost
        if (cost <= budget):
            crossroad_change_index = crossroad_index
        j -= 1

    # Adding 1 as response needs to take into account first crossroad is at index 1
    return crossroad_change_index + 1


# Read input
test_cases = int(input())
responses = []
for _ in range(test_cases):
    bus_ticket, tram_ticket, budget = (int(x) for x in input().split())
    crossroad = input()
    response = find_closest_road_index(
        bus_ticket, tram_ticket, budget, crossroad)
    responses.append(response)

for response in responses:
    print(response)
