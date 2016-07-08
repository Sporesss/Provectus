@isTest
private class Game2Test {
    
    @isTest
    /** Test "auto-fight" method. Checks, if Units HP was changed after fight. */
    static void fightTest() {
        Unit__c unit1 = new Unit__c(name='Vanya', hp__c=300, dmgMin__c=30, dmgMax__c=60, Winrate__c = 0, Number_of_wins__c = 0, 
                                    Quantity_of_fights__c = 0, Stamina__c = 100);
        Unit__c unit2 = new Unit__c(name='Igor', hp__c=250, dmgMin__c=20, dmgMax__c=80, Winrate__c = 0, Number_of_wins__c = 0, 
                                    Quantity_of_fights__c = 0, Stamina__c = 100);
        insert unit1;
        insert unit2;
        Unit__c retrievedUnit1 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c
                                 FROM Unit__c WHERE Name = 'Vanya'];
        Unit__c retrievedUnit2 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c
                                 FROM Unit__c WHERE Name = 'Igor'];
        Game2 game = new Game2();
        
        List<String> logList = new List<String>();
        for (Integer i = 0; i < 20; i++) {
            Log__c newLog = new Log__c();
        	game.fight(retrievedUnit1, retrievedUnit2, logList, newLog);
            System.assert(retrievedUnit1.hp__c < 0 || retrievedUnit2.hp__c < 0);
        }
    }
    
    @isTest
    /** Test "auto-fight" method. Checks, if two Units with negative HP died - their death date was changed to Date.today(). */
    static void fightTestWhenBothHPLessThenNull() {
        Unit__c unit1 = new Unit__c(name='Vanya', hp__c=-10, dmgMin__c=30, dmgMax__c=60, Winrate__c = 0, Number_of_wins__c = 0, 
                                    Quantity_of_fights__c = 0, Stamina__c = 100, death_date__c=Date.today().addDays(10));
        Unit__c unit2 = new Unit__c(name='Igor', hp__c=-20, dmgMin__c=20, dmgMax__c=80, Winrate__c = 0, Number_of_wins__c = 0, 
                                    Quantity_of_fights__c = 0, Stamina__c = 100, death_date__c=Date.today().addDays(20));
        insert unit1;
        insert unit2;
        Unit__c retrievedUnit1 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                                 FROM Unit__c WHERE Name = 'Vanya'];
        Unit__c retrievedUnit2 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                                 FROM Unit__c WHERE Name = 'Igor'];

        Game2 game = new Game2();
        Log__c newLog = new Log__c();
        List<String> logList = new List<String>();
        game.fight(retrievedUnit1, retrievedUnit2, logList, newLog);
        
        Unit__c retrievedUnit3 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                                 FROM Unit__c WHERE Name = 'Vanya'];
        Unit__c retrievedUnit4 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                                 FROM Unit__c WHERE Name = 'Igor'];
        
        System.assertEquals(Date.today(), retrievedUnit3.death_date__c);
        System.assertEquals(Date.today(), retrievedUnit4.death_date__c);
    }
    
    @isTest
    /** Test "manual-fight" method. Attacks and blocks not match, so we check, if Units HP was changed after fight. */
    static void fightByStepTestAttacksAndBlocksNotEquals() {       
        Unit__c unit1 = new Unit__c(name='Vanya', hp__c=300, dmgMin__c=30, dmgMax__c=60, Winrate__c = 0, Number_of_wins__c = 0, 
                                    Quantity_of_fights__c = 0, Stamina__c = 100, death_date__c=Date.today().addDays(10), 
                                   attack__c = 'Right Head', block__c= 'Right Head');
        Unit__c unit2 = new Unit__c(name='Igor', hp__c=250, dmgMin__c=20, dmgMax__c=80, Winrate__c = 0, Number_of_wins__c = 0, 
                                    Quantity_of_fights__c = 0, Stamina__c = 100, death_date__c=Date.today().addDays(20),
                                   attack__c = 'Right leg', block__c= 'Right leg');
        
        Integer unit1hp = (Integer)unit1.hp__c;
        Integer unit2hp = (Integer)unit2.hp__c;
        Game2 game = new Game2();
        Log__c newLog = new Log__c();
        List<String> logList = new List<String>();
        game.fightByStep(unit1, unit2, logList, newLog);
        System.assert(unit1.hp__c < unit1hp && unit2.hp__c < unit2hp);
    }
    
    @isTest
    /** Test "manual-fight" method. Unit1 attack match to Unit2 block, so we check, if Unit1 HP was changed, but Unit2 HP - the same. */
    static void fightByStepTestAttackUnit1EqualsBlockUnit2() {
        Unit__c unit1 = new Unit__c(name='Vanya', hp__c=300, dmgMin__c=30, dmgMax__c=60, Winrate__c = 0, Number_of_wins__c = 0, 
                                    Quantity_of_fights__c = 0, Stamina__c = 100, death_date__c=Date.today().addDays(10), 
                                   attack__c = 'Right Head', block__c= 'Right Head');
        Unit__c unit2 = new Unit__c(name='Igor', hp__c=250, dmgMin__c=20, dmgMax__c=80, Winrate__c = 0, Number_of_wins__c = 0, 
                                    Quantity_of_fights__c = 0, Stamina__c = 100, death_date__c=Date.today().addDays(20),
                                   attack__c = 'Right leg', block__c= 'Right Head');
        
        Integer unit1hp = (Integer)unit1.hp__c;
        Integer unit2hp = (Integer)unit2.hp__c;
        Game2 game = new Game2();
        Log__c newLog = new Log__c();
        List<String> logList = new List<String>();
        game.fightByStep(unit1, unit2, logList, newLog);
        System.assert(unit1.hp__c < unit1hp && unit2.hp__c == unit2hp);
    }
    
    @isTest
    /** Test "manual-fight" method. Unit2 attack match to Unit1 block, so we check, if Unit2 HP was changed, but Unit1 HP - the same. */
    static void fightByStepTestAttackUnit2EqualsBlockUnit1() {
        Unit__c unit1 = new Unit__c(name='Vanya', hp__c=300, dmgMin__c=30, dmgMax__c=60, Winrate__c = 0, Number_of_wins__c = 0, 
                                    Quantity_of_fights__c = 0, Stamina__c = 100, death_date__c=Date.today().addDays(10), 
                                   attack__c = 'Right Head', block__c= 'Right leg');
        Unit__c unit2 = new Unit__c(name='Igor', hp__c=250, dmgMin__c=20, dmgMax__c=80, Winrate__c = 0, Number_of_wins__c = 0, 
                                    Quantity_of_fights__c = 0, Stamina__c = 100, death_date__c=Date.today().addDays(20),
                                   attack__c = 'Right leg', block__c= 'Left Head');
        
        Integer unit1hp = (Integer)unit1.hp__c;
        Integer unit2hp = (Integer)unit2.hp__c;
        Game2 game = new Game2();
        Log__c newLog = new Log__c();
        List<String> logList = new List<String>();
        game.fightByStep(unit1, unit2, logList, newLog);
        System.assert(unit1.hp__c == unit1hp && unit2.hp__c < unit2hp);
    }
    
    @isTest
    /** Test "manual-fight" method. Unit1 has negative HP, so we check, if Unit1 died, but Unit2 death date - the same. */
    static void fightByStepTestIfUnit1HPLessThanNull() {
        Unit__c unit1 = new Unit__c(name='Vanya', hp__c=-10, dmgMin__c=30, dmgMax__c=60, Winrate__c = 0, Number_of_wins__c = 0, 
                                    Quantity_of_fights__c = 0, Stamina__c = 100, death_date__c=Date.today().addDays(10), 
                                   attack__c = 'Right Head', block__c= 'Right leg');
        Unit__c unit2 = new Unit__c(name='Igor', hp__c=250, dmgMin__c=20, dmgMax__c=80, Winrate__c = 0, Number_of_wins__c = 0, 
                                    Quantity_of_fights__c = 0, Stamina__c = 100, death_date__c=Date.today().addDays(20),
                                   attack__c = 'Right leg', block__c= 'Left Head');
        
        insert unit1;
        insert unit2;
        
        Unit__c retrievedUnit1 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c, attack__c, block__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                                 FROM Unit__c WHERE Name = 'Vanya'];
        Unit__c retrievedUnit2 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c, attack__c, block__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                                 FROM Unit__c WHERE Name = 'Igor'];
        
        Integer unit1QuantityOfFights = (Integer)retrievedUnit1.Quantity_of_fights__c;
        Date unit2DeathDate = unit2.death_date__c;
        Integer unit2QuantityOfFights = (Integer)retrievedUnit2.Quantity_of_fights__c;
        Game2 game = new Game2();
        Log__c newLog = new Log__c();
        List<String> logList = new List<String>();
        game.fightByStep(retrievedUnit1, retrievedUnit2, logList, newLog);
        
        Unit__c retrievedUnit3 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c, attack__c, block__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                                 FROM Unit__c WHERE Name = 'Vanya'];
        Unit__c retrievedUnit4 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c, attack__c, block__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                                 FROM Unit__c WHERE Name = 'Igor'];
        
        System.assertEquals(Date.today(), retrievedUnit3.death_date__c);
        System.assertEquals(unit2DeathDate, retrievedUnit4.death_date__c);
        System.assertEquals(unit1QuantityOfFights + 1, (Integer)retrievedUnit3.Quantity_of_fights__c);
        System.assertEquals(unit2QuantityOfFights + 1, (Integer)retrievedUnit4.Quantity_of_fights__c);
    }
}