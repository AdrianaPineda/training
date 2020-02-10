# https://codeforces.com/contest/1238/problem/B
# Big O
# Time complexity: O(n*nlog(n))
# Space complexity: O(n*n)

# Problem


def min_shots_to_kill_enemies(enemies, distance_thrown, enemies_positions):
    sorted_positions = sorted(set(enemies_positions), key=lambda x:int(x), reverse=True)
    shots = 0
    for enemie_string in sorted_positions:
        enemie = int(enemie_string)
        enemie_pos = enemie - shots*distance_thrown
        if (enemie_pos <= 0):
            break
        shots += 1

    return shots if shots > 0 else 1


# Read input
if __name__ == "__main__":
    queries = int(input())

    for i in range(0, queries):
        enemies, distance_thrown = (int(x) for x in input().split())
        enemies_positions = input().split()
        print(min_shots_to_kill_enemies(
            enemies, distance_thrown, enemies_positions))
