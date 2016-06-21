public with sharing class ControllerForGameVFPage2 {
    
    List<wrapperUnits> unitsList;
    Unit__c newUnit;
    public List<Unit__c> selectedUnits {get;set;}
    public Boolean renderedFlag {get;set;}
    public Boolean fightByStepFlag {get;set;}
    public Boolean messageFlag {get;set;}
    public Game2 myGame {get; set;}
    public Unit__c winner {get; set;}
    public Boolean WinnerFlag {get; set;}
    
    public ControllerForGameVFPage2() {
        WinnerFlag = false;
    }
        
    public List<wrapperUnits> getUnitsList() {
        if(unitsList == null) {
            unitsList = new List<wrapperUnits>();
            for(Unit__c eachUnit: [select Id, Name, hp__c, dmgMin__c, dmgMax__c, attack__c, block__c, death_date__c from Unit__c]) {
                unitsList.add(new wrapperUnits(eachUnit));
            }
        }
        return unitsList;
    }
    
    public Unit__c getNewUnit() {
        if(newUnit == null) {
            newUnit = new Unit__c();
            }
        return newUnit;
    }
    /** auto-fight method*/
    public PageReference fight() {  
        selectedUnits = new List<Unit__c>();
        for(wrapperUnits unitSel: getUnitsList()) {
            if(unitSel.selected == true && unitSel.isLive.equals('Live')) {
                selectedUnits.add(unitSel.unit);
            }
        }
        
        /** check if selected 2 units*/
        if (selectedUnits.size() == 2) {      
            messageFlag = false;
            myGame = new Game2();
            winner = myGame.fight(selectedUnits.get(0), selectedUnits.get(1));
        if (winner == null) {
            winner = new Unit__c();
            winner.Name = 'Everybody died.....';
        }
        WinnerFlag = true;
        } else {
            messageFlag = true;
            }
        
        return null;
    }
    
    /** manual-fight method*/
    public PageReference fight2() {         
        myGame = new Game2();
        myGame.fightByStep(selectedUnits.get(0), selectedUnits.get(1));
        /** check if we have winner or everybody died */
        if (selectedUnits.get(0).Hp__c <= 0 && selectedUnits.get(1).Hp__c > 0) {
            winner = selectedUnits.get(1);
            Unit__c loser = myGame.retrieveMyUnit(selectedUnits.get(0));
            loser.death_date__c = Date.today();
            update loser;
            WinnerFlag = true;
            fightByStepFlag = false;
        } else if (selectedUnits.get(1).Hp__c <= 0 && selectedUnits.get(0).Hp__c > 0) {
            winner = selectedUnits.get(0);
            Unit__c loser = myGame.retrieveMyUnit(selectedUnits.get(1));
            loser.death_date__c = Date.today();
            update loser;
            WinnerFlag = true;
            fightByStepFlag = false;
        } else if (selectedUnits.get(0).Hp__c <= 0 && selectedUnits.get(1).Hp__c <= 0) {
            Unit__c loser1 = myGame.retrieveMyUnit(selectedUnits.get(0));
            loser1.death_date__c = Date.today();
            update loser1;
            Unit__c loser2 = myGame.retrieveMyUnit(selectedUnits.get(1));
            loser2.death_date__c = Date.today();
            update loser2;
            
            winner = new Unit__c();
            winner.Name = 'Everybody died.....';
            WinnerFlag = true;
            fightByStepFlag = false;
        }  
        return null;
    }
    
    public PageReference newUnit() {
       insert newUnit;
        return null;
    }

    /** make visible section for manual fight */
    public PageReference transitionToFightByStepBlock() {
        selectedUnits = new List<Unit__c>();
        for(wrapperUnits unitSel: getUnitsList()) {
            if(unitSel.selected == true && unitSel.isLive.equals('Live')) {
                selectedUnits.add(unitSel.unit);
            }
        }
        
        if (selectedUnits.size() == 2) {       
            messageFlag = false;         
            fightByStepFlag = true;
        } else {
            messageFlag = true;
            }      
        return null;
    }
    
    public class wrapperUnits{
        public Unit__c unit {get; set;}
        public Boolean selected {get; set;}
        public String isLive {get; set;}
        public wrapperUnits(Unit__c unit) {
            this.unit = unit;
            selected = false;
            if (unit.death_date__c == Date.today()) {
                isLive = 'DIED';
            } else {
                isLive = 'Live';
            }
        }
    }
}