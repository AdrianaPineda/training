# https://codeforces.com/contest/1238/problem/B

# Problem


def shot_enemies(enemies_positions, shot_point, distance_thrown):
    new_enemies_positions = []
    for i in range(0, len(enemies_positions)):
        current_position = enemies_positions[i]
        new_position = current_position - 1
        if (current_position == shot_point or new_position <= 0):
            continue
        else:
            new_enemies_positions.append(new_position)
    return new_enemies_positions


def get_minimun_shots(enemies, enemies_positions, distance_thrown):
    enemies_dictionary = set()
    for i in range(0, enemies):
        enemie = enemies_positions[i]
        division = enemie // distance_thrown
        modulus = enemie % distance_thrown
        number_of_shots = division + 1 if distance_thrown > 1 and modulus > 0 else division
        # print(number_of_shots)

        if division > 0 and modulus > 0:
            real_division = enemie / distance_thrown
            enemies_dictionary.add(real_division)
        else:
            enemies_dictionary.add(number_of_shots)

    shots = 0
    # print("==== 1", enemies_dictionary)
    sorted_positions = sorted(enemies_dictionary, reverse=True)
    # print("==== 2", sorted_positions)
    while len(sorted_positions) > 0:
        current_shot = sorted_positions[0]
        sorted_positions = shot_enemies(
            sorted_positions, current_shot, distance_thrown)
        shots += 1
    return shots

    # count = len(enemies_dictionary)
    # print(count)
    # print(min_number_of_shots)
    # print(max_number_of_shots)
    # if (min_number_of_shots >= count):
    #     return count

    # if (min_number_of_shots < count):
    #     return count - 1


def min_shots_to_kill_enemies(enemies, distance_thrown, enemies_positions):
    return get_minimun_shots(enemies, enemies_positions, distance_thrown)


# Read input
queries = int(input())

for i in range(0, queries):
    enemies, distance_thrown = map(int, input().split())
    enemies_positions = list(map(int, input().split()))
    print(min_shots_to_kill_enemies(enemies, distance_thrown, enemies_positions))


# 7 2
# 5 5 2 4 7 6 2
