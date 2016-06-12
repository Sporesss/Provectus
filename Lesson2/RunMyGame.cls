public class RunMyGame {
    public void main() {
        // use this piece of code for test "fight" method for TWO Units in developer console
    	Unit orc = new Unit('Orc', 200, 5, 15, false);
		Unit human = new Unit('John Smith', 180, 4, 17, false);
		Game fightForTwo = new Game();
		Unit winner = fightForTwo.fight(orc, human);
		if (winner != null) {
    		System.debug('Winner: ' + winner.getName());
		} else {
    		System.debug('Everybody died.....');
		}


		// use this piece of code for test "fight" method for ANY Units in developer console
        List<Unit> listOfUnits = new List<Unit> {new Unit('Orc', 200, 18, 50, false),
                                        new Unit('John Snow', 180, 22, 55, false),
                                        new Unit('Red Woman', 150, 20, 40, false),
    									new Unit('Wild man', 170, 25, 45, false)};
		Game myGame = new Game();
		List<Unit> winnerList = myGame.fight(listOfUnits);
			if (!winnerList.isEmpty()) {
    			System.debug('WINNER IS ' + winnerList.get(0).getName() + ' with ' + winnerList.get(0).getHp() + ' HP!');
			} else {
    			System.debug('Everybody died.....');
			}
		}
    }