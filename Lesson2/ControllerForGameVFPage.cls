public class ControllerForGameVFPage {

    public Unit unit1 {get; set;}
    public Unit unit2 {get; set;}
    public Game myGame {get; set;}
    public Unit winner {get; set;}
    public Boolean BlockFlag {get; set;}
    public Boolean WinnerFlag {get; set;}
    
    public ControllerForGameVFPage() {
        unit1 = new Unit();
        unit2 = new Unit();
        BlockFlag = true;
        WinnerFlag = false;
    }
    
    public PageReference fight() {
        myGame = new Game();
        winner = myGame.fight(unit1, unit2);
        if (winner == null) {
            winner = new Unit();
            winner.setName('Everybody died.....');
        }
        BlockFlag = false;
        WinnerFlag = true;
        return null;
    }
    
}