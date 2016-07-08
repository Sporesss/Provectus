public class Game2 {
    
    /** Since direction of attack and direction of block - the same, I create general list. */
    private final List<String> attacksAndBlocksList = new List<String> {'Right Head', 'Left Head', 'Right Body', 'Left Body', 'Right Leg', 'Left Leg'};
    
    /** Define random attack or block. One for attack and block, because direction of attack and direction of block - the same. */    
    private String randomAttacksAndBlocks() {
    return attacksAndBlocksList.get((Integer) Math.floor(Math.random() * (attacksAndBlocksList.size())));
    }
    
    /** Recursive method for auto-fight. */
    public Unit__c fight(Unit__c unit1, Unit__c unit2, List<String> logList, Log__c myLog) {
        /** Check if we have winner or everybody died. If not - play next round. */        
        if (!checkIfWeHaveWinner(unit1, unit2, logList, myLog)) {           
        	/** Set up random values of Attacks and Blocks */
        	unit1.attack__c = randomAttacksAndBlocks();
        	unit2.attack__c = randomAttacksAndBlocks();
        	unit1.block__c = randomAttacksAndBlocks();
        	unit2.block__c = randomAttacksAndBlocks();
            
            List<Integer> HPAfterFightList = countHPAfterEachFightStep(unit1, unit2, logList, myLog);       
            
            unit1.Hp__c = HPAfterFightList.get(0);
            unit2.Hp__c = HPAfterFightList.get(1);
            
        	/** Recursive call "fight" method */
            return fight(unit1, unit2, logList, myLog);
        } else {
            /** Somebody died */   
            return null;
        }
    } 
    
    /** Manual-fight method*/
    public Boolean fightByStep(Unit__c unit1, Unit__c unit2, List<String> logList, Log__c myLog) {
        /** Check if we have winner or everybody died. If not - play next round. */  
        if (!checkIfWeHaveWinner(unit1, unit2, logList, myLog)) {     
            List<Integer> HPAfterFightList = countHPAfterEachFightStep(unit1, unit2, logList, myLog);
            unit1.Hp__c = HPAfterFightList.get(0);
            unit2.Hp__c = HPAfterFightList.get(1);            
            return false;
        } else {
            /** Somebody died */ 
            return true;
        }
    }
 
    /** Metod count of random damage which Unit hit. Damage always not less, then minimal damage and not more, then maximal damage of this Unit. 
	Also method take into consideration of stamina. */
    private Integer damage (Unit__c unit) {
        Integer damage = (Integer) Math.floor((Math.random() * (unit.DmgMax__c - unit.DmgMin__c + 1) 
                                               + unit.DmgMin__c) * (unit.Stamina__c / 100));
        return damage;
    }
    
    /** Retrieve unit for save his original HP (before fight), when we will update this unit */
    private Unit__c retrieveMyUnit(Unit__c someUnit) {
        Unit__c retrievedUnit = [select Id, Name, hp__c, dmgMin__c, dmgMax__c, attack__c, block__c, death_date__c, 
                                 Number_of_wins__c, Position_in_rating__c, Quantity_of_fights__c, Winrate__c, Stamina__c  
                                 FROM Unit__c
                                 WHERE Id =:someUnit.Id];
        return retrievedUnit;
        }
           
    /** General method for auto-fight and manual-fight, which check HP of each Unit and define winner and loser. Change appropriate fields and keep logs.
	Return true if any Unit has HP < 0. Else - false. */
    private Boolean checkIfWeHaveWinner (Unit__c unit1, Unit__c unit2, List<String> logList, Log__c myLog) {
        if (unit1.Hp__c <= 0 && unit2.Hp__c > 0) { 
            unit1 = retrieveMyUnit(unit1);
            unit1.death_date__c = Date.today();
            unit1.Quantity_of_fights__c = unit1.Quantity_of_fights__c + 1;
            update unit1;
            
            unit2 = retrieveMyUnit(unit2);
            unit2.Number_of_wins__c = unit2.Number_of_wins__c + 1;
            unit2.Quantity_of_fights__c = unit2.Quantity_of_fights__c + 1;
            /** Winner lose 10 point of stamina after each fight. */
            unit2.Stamina__c = unit2.Stamina__c - 10; 
            update unit2;
                       
            logList.add(unit1.Name + ' died.');
            logList.add('Winner ' + unit2.Name + '.');
            /** Create String for output on the visualforce page. */ 
            String commonLogInString = '';
            for (String eachLog : logList) {
                commonLogInString = commonLogInString + eachLog + '\n';
            }

            myLog.Winner__c = unit2.Id;
            myLog.Loser__c = unit1.Id;
            myLog.Log_Text__c = commonLogInString;            
            insert myLog;
            
            return true;
            
        } else if (unit2.Hp__c <= 0 && unit1.Hp__c > 0) {
            unit2 = retrieveMyUnit(unit2);
            unit2.death_date__c = Date.today();
            unit2.Quantity_of_fights__c = unit2.Quantity_of_fights__c + 1;
            update unit2;
            
            unit1 = retrieveMyUnit(unit1);
            unit1.Number_of_wins__c = unit2.Number_of_wins__c + 1;
            unit1.Quantity_of_fights__c = unit1.Quantity_of_fights__c + 1;
            /** Winner lose 10 point of stamina after each fight. */
            unit1.Stamina__c = unit1.Stamina__c - 10;
            update unit1;

            logList.add(unit2.Name + ' died.');
            logList.add('Winner ' + unit1.Name + '.');
            /** Create String for output on the visualforce page. */ 
            String commonLogInString = '';
            for (String eachLog : logList) {
                commonLogInString = commonLogInString + eachLog + '\n';
            }

            myLog.Winner__c = unit1.Id;
            myLog.Loser__c = unit2.Id;
            myLog.Log_Text__c = commonLogInString;         
            insert myLog;
            
            return true;
            
        } else if (unit1.Hp__c <= 0 && unit2.Hp__c <= 0) {
            unit1 = retrieveMyUnit(unit1);
            unit2 = retrieveMyUnit(unit2);
            unit1.death_date__c = Date.today();
            unit1.Quantity_of_fights__c = unit1.Quantity_of_fights__c + 1;
            unit2.death_date__c = Date.today();
            unit2.Quantity_of_fights__c = unit2.Quantity_of_fights__c + 1;
            update unit1;
            update unit2;
            
            logList.add('Draw. ' + unit1.Name + ' and ' + unit2.Name + ' died.');
            /** Create String for output on the visualforce page. */ 
            String commonLogInString = '';
            for (String eachLog : logList) {
                commonLogInString = commonLogInString + eachLog + '\n';
            }
            
            myLog.Loser__c = unit1.Id;
            myLog.Log_Text__c = commonLogInString;
            
            /** Since we don't have winner, only losers, I create second log with the same log text, but with other loser. 
			It needs for correct statistic. In both logs, winner fields are empty. */
            Log__c logForSecondLoser = new Log__c();
            logForSecondLoser.Loser__c = unit2.Id;
            logForSecondLoser.Log_Text__c = myLog.Log_Text__c;
            insert myLog;
            insert logForSecondLoser; 
                       
            return true;
            
        } else {
            /** All Units live. */
            return false;
        }
    }
    
    /** General method for auto-fight and manual-fight, which count HP of each Unit after each fight-round. 
    Check if attacks was blocked. Keep logs. Return list with new value of HP. */
    private List<Integer> countHPAfterEachFightStep(Unit__c unit1, Unit__c unit2, List<String> logList, Log__c myLog) {
        Integer damageFromUnit1;
        Integer damageFromUnit2 = damage(unit2);
        /** check if attack was neutralized (matched to Block) */
       	if (unit1.attack__c.equals(unit2.block__c)) {
            damageFromUnit1 = 0;
            logList.add(unit1.Name + ' hit to ' + unit2.Name + ' in ' + unit1.attack__c + ',  but attack was blocked.');
        } else {
            damageFromUnit1 = damage(unit1);
            logList.add(unit1.Name + ' hit ' + damageFromUnit1 + ' to ' + unit2.Name + '.');
        }
        
        if (unit2.attack__c.equals(unit1.block__c)) {
            damageFromUnit2 = 0;
            logList.add(unit2.Name + ' hit to ' + unit1.Name + ' in ' + unit2.attack__c + ',  but attack was blocked.');
        } else {
            damageFromUnit2 = damage(unit2);
            logList.add(unit2.Name + ' hit ' + damageFromUnit2 + ' to ' + unit1.Name + '.');
        }
        Integer HPAfterEachFightStepUnit1 = (Integer)(unit1.Hp__c - damageFromUnit2);
        logList.add(unit1.Name + ' has ' + HPAfterEachFightStepUnit1 + ' HP.');
        Integer HPAfterEachFightStepUnit2 = (Integer)(unit2.Hp__c - damageFromUnit1);
        logList.add(unit2.Name + ' has ' + HPAfterEachFightStepUnit2 + ' HP.');
        
        List<Integer> HPList = new List<Integer> {HPAfterEachFightStepUnit1, HPAfterEachFightStepUnit2};
        
        return HPList;
    }
}