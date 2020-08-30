# Problem: https://www.hackerrank.com/challenges/binary-search-tree-lowest-common-ancestor/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=trees
# Big O:
# Time complexity: O(n) in the worst case
# Space complexity: O(n) in the worst case


class Node:
    def __init__(self, info):
        self.info = info
        self.left = None
        self.right = None


def lca(node, v1, v2):
    val = node.info

    if val > v1 and val > v2 and node.left is not None:
        return lca(node.left, v1, v2)

    if val < v1 and val < v2 and node.right is not None:
        return lca(node.right, v1, v2)

    return node


# 15
# 8 4 2 1 3 6 5 7 10 14 15 9 12 11 13
# 15 11
# expected => 14
