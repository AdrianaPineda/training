# https://codeforces.com/contest/1238/problem/B

# Problem


def min_shots_to_kill_enemies(enemies, distance_thrown, enemies_positions):
    sorted_positions = sorted(set(enemies_positions), reverse=True)
    shots = 0
    for enemie in sorted_positions:
        enemie_pos = enemie - shots*distance_thrown
        if (enemie_pos <= 0):
            break
        shots += 1

    return shots if shots > 0 else 1

# Read input
def to_int_array(string_array):
    int_array = []
    for i in range(0, len(string_array)):
        int_array.append(int(string_array[i]))
    return int_array


if __name__ == "__main__":
    queries = int(input())

    for i in range(0, queries):
        enemies_as_string, distance_thrown_as_string = input().split()
        enemies = int(enemies_as_string)
        distance_thrown = int(distance_thrown_as_string)
        enemies_positions_as_string = input().split()
        enemies_positions = to_int_array(enemies_positions_as_string)
        print(min_shots_to_kill_enemies(
            enemies, distance_thrown, enemies_positions))
