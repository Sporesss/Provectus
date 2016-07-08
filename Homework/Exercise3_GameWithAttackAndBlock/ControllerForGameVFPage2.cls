public with sharing class ControllerForGameVFPage2 {
    
    /** Fields*/
    List<wrapperUnits> unitsList;
    Unit__c newUnit;
    Unit__c winnerWithpAllHP;
    Game2 myGame;
    public List<Unit__c> selectedUnits {get;set;}
    public Boolean renderedFlag {get;set;}
    public Boolean fightByStepFlag {get;set;}
    public Boolean winnerFlag {get; set;}
    public Boolean unitListFlag {get; set;}
    public List<String> logsForOutputOnVFPage {get; set;}
    public Log__c myLog {get; set;}
    public PageReference currPage {get; set;}
    
    /** Costructor. Set some start values, include Boolean flags for rendering some part on the visualforce page. */
    public ControllerForGameVFPage2() {
        winnerFlag = false;
        unitListFlag = true;
        logsForOutputOnVFPage = new List<String> ();
        currPage = ApexPages.currentPage();

    }
        
    /** Retrieve all Units and create List with wrapper entities. */
    public List<wrapperUnits> getUnitsList() {
        if(unitsList == null) {
            unitsList = new List<wrapperUnits>();
            for(Unit__c eachUnit: [select Id, Name, hp__c, dmgMin__c, dmgMax__c, attack__c, block__c, death_date__c, 
                                   Number_of_wins__c, Position_in_rating__c, Quantity_of_fights__c, Winrate__c, Stamina__c
                                   from Unit__c]) {
                unitsList.add(new wrapperUnits(eachUnit));
            }
        }
        return unitsList;
    }
    
    /** Set start values for some hidden fields of new Unit, when it calls. */
    public Unit__c getNewUnit() {
        if(newUnit == null) {
            newUnit = new Unit__c();
            newUnit.Number_of_wins__c = 0;
            newUnit.Position_in_rating__c = 0;
            newUnit.Quantity_of_fights__c = 0;
            newUnit.Winrate__c = 0;
            newUnit.Stamina__c = 100;
            }
        return newUnit;
    }
        
    /** Call auto-fight method from Game2 class. */
    public PageReference fight() { 
                
        /** If selected TWO and LIVE units, called auto-fight method from Game2 class. Else - show message for user. */
        if (checkIfSelectedTwoAndLiveunits()) {      
            myGame = new Game2();
            myLog = new Log__c(Log_Text__c = '');
           
            /** Pass Units,  "List<String> logsForOutputOnVFPage" for output on the visualforce page as list, "Log__c myLog" for save final Log__c object. */
            myGame.fight(selectedUnits.get(0), selectedUnits.get(1), logsForOutputOnVFPage, myLog);

        	WinnerFlag = true;
            unitListFlag = false;
        } else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'You can select only TWO fighters! Check if they are LIVE and try again!'));
            }
        
        return null;
    }
    
    /** Call manual-fight method from Game2 class. User can choose any combination attacks and blocks for each Unit. */
    public PageReference fight2() {         
        
        myGame = new Game2();
        myLog = new Log__c(Log_Text__c = '');
        
        /** If attacks and blocks chosen - call manual-fight method. Else - show message for user. */
        if (selectedUnits.get(0).attack__c != null && selectedUnits.get(0).block__c != null && 
            selectedUnits.get(1).attack__c != null && selectedUnits.get(1).block__c != null) {
                		/** Pass Units,  "List<String> logsForOutputOnVFPage" for output on the visualforce page as list, 
						"Log__c myLog" for save final Log__c object. */
                        Boolean ifFightFinished = myGame.fightByStep(selectedUnits.get(0), selectedUnits.get(1), logsForOutputOnVFPage, myLog);
                		/** If fight finished (some Unit has HP < 0) - show results of fight and hide fight section. */
                        if (ifFightFinished) {
                        WinnerFlag = true;
                        fightByStepFlag = false;
                }
            } else {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please, choose the attack and block for all units.'));
            }
        
        return null;
    }
    
    /** Insert new Unit and refresh visualforce page. */
    public PageReference newUnit() {
       insert newUnit;
       currPage.setRedirect(true);
       return currPage;
    }
    
    /** Action for update visualforce page after fight and possibility of play new fight. */
    public PageReference newFight() {
       currPage.setRedirect(true);
       return currPage;
    }

    /** If selected TWO and LIVE units - method make visible section for manual fight. Else - show message for user. */
    public PageReference transitionToFightByStepBlock() {       
        if (checkIfSelectedTwoAndLiveunits()) {            
            fightByStepFlag = true;
            unitListFlag = false;
        } else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'You can select only TWO fighters! Check if they are LIVE and try again!'));
            }      
        return null;
    }
    
    /** Method for check if selected TWO and LIVE units */
    private Boolean checkIfSelectedTwoAndLiveunits() {
        selectedUnits = new List<Unit__c>();
        List<Unit__c> selectedLiveUnits = new List<Unit__c>();
        
        /** Put in selectedUnits all selected Units */
        for(wrapperUnits unitSel: getUnitsList()) {
            if(unitSel.selected == true) {
                selectedUnits.add(unitSel.unit);
            }
        }
        
        /** Put in selectedLiveUnits all selected and LIVE Units */
        for(wrapperUnits unitSel: getUnitsList()) {
            if(unitSel.selected == true && unitSel.isLive.equals('Live')) {
                selectedLiveUnits.add(unitSel.unit);
            }
        }
        
        /** Compare two Lists - if selected only two users and all of them - LIVE.
		I used it for exclude possibility of select DEAD Units together with LIVE Units */
        if (selectedUnits.size() == selectedLiveUnits.size()) {            
            return true;
        } else {
            return false;
        }
    }
    
    /** Wrapper class. 
	In constructor I set Unit status based on the death date. Each Unit become available next day after death. */
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