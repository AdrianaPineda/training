//
// Problem: https://www.hackerrank.com/challenges/ctci-comparator-sorting/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=sorting
// Big O:
// Time complexity: O(n), n being the player with the shortest name
// Space complexity: O(1)

class Checker implements Comparator<Player> {
  	// complete this method
	public int compare(Player a, Player b) {
		int scoreA = a.score;
		int scoreB = b.score;

		if (scoreA > scoreB) {
			return -1;
		}

		if (scoreB > scoreA) {
			return 1;
		}

		String nameA = a.name;
		String nameB = b.name;
		
		return nameA.compareTo(nameB);
    }
}
