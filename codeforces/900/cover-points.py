# https://codeforces.com/problemset/problem/1047/B
# Big O:
# Time complexity: O(n)
# Space complexity: O(n)
# Problem


def find_minimum_cathetus_length(coordinates):
    minimum_cathetus_length = 0
    for coordinate in coordinates:
        x = coordinate["x"]
        y = coordinate["y"]
        cathetus = x + y
        if (cathetus > minimum_cathetus_length):
            minimum_cathetus_length = cathetus

    return minimum_cathetus_length


# Read input
if __name__ == "__main__":
    number_of_coordinates = int(input())
    coordinates = []
    for i in range(0, number_of_coordinates):
        x, y = (int(x) for x in input().split())
        coordinates.append({"x": x, "y": y})
    print(find_minimum_cathetus_length(coordinates))
