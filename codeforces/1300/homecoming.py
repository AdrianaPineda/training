# https://codeforces.com/problemset/problem/1315/B
# Problem
# Big O:
# Time complexity:
# Space complexity:

# Problem


def crossroad_station_cost(crossroad, bus_ticket, tram_ticket):
    if (crossroad == "A"):
        return bus_ticket
    return tram_ticket


# def next_crossroad(crossroad):
#     if crossroad == "A":
#         return "B"
#     return "A"


def find_closest_road_index(bus_ticket, tram_ticket, budget, crossroads):
    crossroads_length = len(crossroads)
    i = 0
    current_crossroad = crossroads[0]
    crossroad_changes = [i]
    i += 1
    while (i < crossroads_length - 1):
        if crossroads[i] != current_crossroad:
            current_crossroad = crossroads[i]
            crossroad_changes.append(i)
        i += 1

    crossroad_changes_length = len(crossroad_changes)
    cost = 0
    cost_change_index = crossroads_length - 1
    j = crossroad_changes_length - 1

    while cost <= budget and j >= 0:
        crossroad_changes_value = crossroad_changes[j]
        last_crossroad = crossroads[crossroad_changes_value]
        current_cost = crossroad_station_cost(
            last_crossroad, bus_ticket, tram_ticket)
        cost += current_cost
        if (cost <= budget):
            cost_change_index = crossroad_changes[j]
        j -= 1

    return cost_change_index + 1


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
