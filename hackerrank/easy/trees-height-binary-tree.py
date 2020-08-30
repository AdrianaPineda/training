# Problem: https://www.hackerrank.com/challenges/tree-height-of-a-binary-tree/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=trees
# Big O:
# Time complexity: O(n), where n is the number of nodes in the tree
# Space complexity: O(n), due to recursion


class Node:
    def __init__(self, info):
        self.info = info
        self.left = None
        self.right = None


def height(root):
    left_node = root.left
    right_node = root.right

    if left_node == None and right_node == None:
        return 0

    left_height = 0
    right_height = 0
    if left_node:
        left_height = height(left_node)

    if right_node:
        right_height = height(right_node)

    return 1 + max(left_height, right_height)
