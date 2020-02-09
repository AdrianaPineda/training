# https://codeforces.com/contest/1238/problem/B

# Problem


def shot_enemies(enemies_positions, shot_point, distance_thrown):
    new_enemies_positions = []
    for i in range(0, len(enemies_positions)):
        current_position = enemies_positions[i]
        new_position = current_position - distance_thrown
        if (current_position == shot_point or new_position <= 0):
            continue
        else:
            new_enemies_positions.append(new_position)
    return new_enemies_positions


def min_shots_to_kill_enemies(enemies, distance_thrown, enemies_positions):
    sorted_positions = sorted(enemies_positions, reverse=True)
    shots = 0
    while len(sorted_positions) > 0:
        current_shot = sorted_positions[0]
        sorted_positions = shot_enemies(
            sorted_positions, current_shot, distance_thrown)
        shots += 1
    return shots


# Read input
queries = int(input())

for i in range(0, queries):
    enemies, distance_thrown = map(int, input().split())
    enemies_positions = list(map(int, input().split()))
    print(min_shots_to_kill_enemies(enemies, distance_thrown, enemies_positions))
