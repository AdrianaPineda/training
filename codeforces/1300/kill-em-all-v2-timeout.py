# https://codeforces.com/contest/1238/problem/B

# Problem
def min_shots_to_kill_enemies(enemies, distance_thrown, enemies_positions):
    sorted_positions = sorted(enemies_positions, reverse=True)
    shots = 0
    previous_value = sorted_positions[0]
    for i in range(0, enemies):
        if (i > 0 and sorted_positions[i] == previous_value):
            previous_value = sorted_positions[i]
            continue
        enemie_pos = sorted_positions[i] - shots*distance_thrown
        previous_value = sorted_positions[i]
        if (enemie_pos <= 0):
            break
        shots += 1

    return shots if shots > 0 else 1


# Read input
queries = int(input())

for i in range(0, queries):
    enemies, distance_thrown = map(int, input().split())
    enemies_positions = list(map(int, input().split()))
    print(min_shots_to_kill_enemies(enemies, distance_thrown, enemies_positions))
