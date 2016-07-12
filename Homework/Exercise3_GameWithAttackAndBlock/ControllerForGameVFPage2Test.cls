/** Test for Game controller. */
@isTest
private class ControllerForGameVFPage2Test {
       
    @isTest
    /** Test for normal situation, where simulated that user select for auto-fight two and live units. */
    static void passIntoFightMethodTwoAndLiveUnits() {
        Test.startTest();
        ControllerForGameVFPage2 newObject = new ControllerForGameVFPage2();
        Test.stopTest();
        
        List<Unit__c> unitsList = new List<Unit__c> {
            new Unit__c(name='Vasya', hp__c=300, dmgMin__c=30, dmgMax__c=60, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100),
            new Unit__c(name='Anton', hp__c=250, dmgMin__c=20, dmgMax__c=80, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100)
            };
        insert unitsList;
        
        Unit__c unit1 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Vasya'];
        Unit__c unit2 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Anton'];
                   
        List<ControllerForGameVFPage2.wrapperUnits> wrapperUnitsList = new List<ControllerForGameVFPage2.wrapperUnits> {
            											new ControllerForGameVFPage2.wrapperUnits(unit1, true, 'Live'), 
                                                        new ControllerForGameVFPage2.wrapperUnits(unit2, true, 'Live')
          												};
       
        newObject.setUnitsList(wrapperUnitsList);
        newObject.fight();
        System.assertEquals(true, newObject.WinnerFlag, 'The winner section unvisible. ');

		newObject.transitionToFightByStepBlock();
        System.assertEquals(true, newObject.fightByStepFlag, 'The "fight by step" section unvisible. ');
    }
    
    @isTest
    /** Test for situation, where simulated that user select for auto-fight only one and live unit. */
    static void passIntoFightMethodOneAndLiveUnits() {
        Test.startTest();
        ControllerForGameVFPage2 newObject = new ControllerForGameVFPage2();
        Test.stopTest();
        
		Unit__c unit1 = new Unit__c(name='Vasya', hp__c=300, dmgMin__c=30, dmgMax__c=60, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100);

        insert unit1;
        
        Unit__c retrievedUnit1 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         		FROM Unit__c WHERE Name = 'Vasya'];
                   
        List<ControllerForGameVFPage2.wrapperUnits> wrapperUnitsList = new List<ControllerForGameVFPage2.wrapperUnits> {
            											new ControllerForGameVFPage2.wrapperUnits(retrievedUnit1, true, 'Live')
          												};
       
        newObject.setUnitsList(wrapperUnitsList);
        newObject.fight();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('You can select only TWO fighters! Check if they are LIVE and try again!'),
                            'Apex Message was not added.'); 
        newObject.transitionToFightByStepBlock();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('You can select only TWO fighters! Check if they are LIVE and try again!'),
                            'Apex Message was not added.'); 
    }
    
    @isTest
    /** Test for situation, where simulated that user select for auto-fight three and live units. */
    static void passIntoFightMethodThreeAndLiveUnits() {
        Test.startTest();
        ControllerForGameVFPage2 newObject = new ControllerForGameVFPage2();
        Test.stopTest();
        
        List<Unit__c> unitsList = new List<Unit__c> {
            new Unit__c(name='Vasya', hp__c=300, dmgMin__c=30, dmgMax__c=60, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100),
            new Unit__c(name='Anton', hp__c=250, dmgMin__c=20, dmgMax__c=80, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100),
            new Unit__c(name='Petya', hp__c=200, dmgMin__c=10, dmgMax__c=50, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100)
            };
        insert unitsList;
        
        Unit__c unit1 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Vasya'];
        Unit__c unit2 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Anton'];
        Unit__c unit3 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Petya'];
                   
        List<ControllerForGameVFPage2.wrapperUnits> wrapperUnitsList = new List<ControllerForGameVFPage2.wrapperUnits> {
            											new ControllerForGameVFPage2.wrapperUnits(unit1, true, 'Live'), 
                                                        new ControllerForGameVFPage2.wrapperUnits(unit2, true, 'Live'),
                                                        new ControllerForGameVFPage2.wrapperUnits(unit3, true, 'Live')
          												};
       
        newObject.setUnitsList(wrapperUnitsList);
        newObject.fight();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('You can select only TWO fighters! Check if they are LIVE and try again!'),
                            'Apex Message was not added.');
        newObject.transitionToFightByStepBlock();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('You can select only TWO fighters! Check if they are LIVE and try again!'),
                            'Apex Message was not added.'); 
    }
    
    @isTest
    /** Test for situation, where simulated that user select for auto-fight two, but dead units. */
    static void passIntoFightMethodTwoAndDeadUnits() {
        Test.startTest();
        ControllerForGameVFPage2 newObject = new ControllerForGameVFPage2();
        Test.stopTest();
        
        List<Unit__c> unitsList = new List<Unit__c> {
            new Unit__c(name='Vasya', hp__c=300, dmgMin__c=30, dmgMax__c=60, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100),
            new Unit__c(name='Anton', hp__c=250, dmgMin__c=20, dmgMax__c=80, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100)
            };
        insert unitsList;
        
        Unit__c unit1 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Vasya'];
        Unit__c unit2 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Anton'];
                   
        List<ControllerForGameVFPage2.wrapperUnits> wrapperUnitsList = new List<ControllerForGameVFPage2.wrapperUnits> {
            											new ControllerForGameVFPage2.wrapperUnits(unit1, true, 'DIED'), 
                                                        new ControllerForGameVFPage2.wrapperUnits(unit2, true, 'DIED')
          												};
       
        newObject.setUnitsList(wrapperUnitsList);
        newObject.fight();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('You can select only TWO fighters! Check if they are LIVE and try again!'),
                            'Apex Message was not added.');
        newObject.transitionToFightByStepBlock();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('You can select only TWO fighters! Check if they are LIVE and try again!'),
                            'Apex Message was not added.'); 
    }
    
    @isTest
    /** Test for situation, where simulated that user select for auto-fight one live, but second dead units. */
    static void passIntoFightMethodOneLiveAndSecondDeadUnits() {
        Test.startTest();
        ControllerForGameVFPage2 newObject = new ControllerForGameVFPage2();
        Test.stopTest();
        
        List<Unit__c> unitsList = new List<Unit__c> {
            new Unit__c(name='Vasya', hp__c=300, dmgMin__c=30, dmgMax__c=60, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100),
            new Unit__c(name='Anton', hp__c=250, dmgMin__c=20, dmgMax__c=80, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100)
            };
        insert unitsList;
        
        Unit__c unit1 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Vasya'];
        Unit__c unit2 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Anton'];
                   
        List<ControllerForGameVFPage2.wrapperUnits> wrapperUnitsList = new List<ControllerForGameVFPage2.wrapperUnits> {
            											new ControllerForGameVFPage2.wrapperUnits(unit1, true, 'DIED'), 
                                                        new ControllerForGameVFPage2.wrapperUnits(unit2, true, 'Live')
          												};
       
        newObject.setUnitsList(wrapperUnitsList);
        newObject.fight();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('You can select only TWO fighters! Check if they are LIVE and try again!'),
                            'Apex Message was not added.');
        newObject.transitionToFightByStepBlock();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('You can select only TWO fighters! Check if they are LIVE and try again!'),
                            'Apex Message was not added.'); 
    }
    
    @isTest
    /** Test for situation, where simulated that user select for auto-fight only one and died unit. */
    static void passIntoFightMethodOneAndDiedUnits() {
        Test.startTest();
        ControllerForGameVFPage2 newObject = new ControllerForGameVFPage2();
        Test.stopTest();
        
		Unit__c unit1 = new Unit__c(name='Vasya', hp__c=300, dmgMin__c=30, dmgMax__c=60, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100);

        insert unit1;
        
        Unit__c retrievedUnit1 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         		FROM Unit__c WHERE Name = 'Vasya'];
                   
        List<ControllerForGameVFPage2.wrapperUnits> wrapperUnitsList = new List<ControllerForGameVFPage2.wrapperUnits> {
            											new ControllerForGameVFPage2.wrapperUnits(retrievedUnit1, true, 'DIED')
          												};
       
        newObject.setUnitsList(wrapperUnitsList);
        newObject.fight();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('You can select only TWO fighters! Check if they are LIVE and try again!'),
                            'Apex Message was not added.'); 
        newObject.transitionToFightByStepBlock();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('You can select only TWO fighters! Check if they are LIVE and try again!'),
                            'Apex Message was not added.'); 
    }
    
    @isTest
    /** Test for situation, where simulated that user select for auto-fight three units: two and live + one dead. */
    static void passIntoFightMethodTwoLiveAndOneDiedUnits() {
        Test.startTest();
        ControllerForGameVFPage2 newObject = new ControllerForGameVFPage2();
        Test.stopTest();
        
        List<Unit__c> unitsList = new List<Unit__c> {
            new Unit__c(name='Vasya', hp__c=300, dmgMin__c=30, dmgMax__c=60, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100),
            new Unit__c(name='Anton', hp__c=250, dmgMin__c=20, dmgMax__c=80, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100),
            new Unit__c(name='Petya', hp__c=200, dmgMin__c=10, dmgMax__c=50, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100)
            };
        insert unitsList;
        
        Unit__c unit1 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Vasya'];
        Unit__c unit2 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Anton'];
        Unit__c unit3 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Petya'];
                   
        List<ControllerForGameVFPage2.wrapperUnits> wrapperUnitsList = new List<ControllerForGameVFPage2.wrapperUnits> {
            											new ControllerForGameVFPage2.wrapperUnits(unit1, true, 'Live'), 
                                                        new ControllerForGameVFPage2.wrapperUnits(unit2, true, 'Live'),
                                                        new ControllerForGameVFPage2.wrapperUnits(unit3, true, 'DIED')
          												};
       
        newObject.setUnitsList(wrapperUnitsList);
        newObject.fight();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('You can select only TWO fighters! Check if they are LIVE and try again!'),
                            'Apex Message was not added.'); 
        newObject.transitionToFightByStepBlock();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('You can select only TWO fighters! Check if they are LIVE and try again!'),
                            'Apex Message was not added.'); 
    }
    
    @isTest
    /** Test for normal situation, where simulated that user select for manual-fight units with all filled fields. */
    static void passIntoFight2MethodUnitsWithAttacksAndBlocksFilledFields() {
        Test.startTest();
        ControllerForGameVFPage2 newObject = new ControllerForGameVFPage2();
        Test.stopTest();
        
        List<Unit__c> unitsList = new List<Unit__c> {
            new Unit__c(name='Vasya', hp__c=100, dmgMin__c=30, dmgMax__c=60, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100, attack__c = 'Right Head', block__c= 'Right Head'),
            new Unit__c(name='Anton', hp__c=-5, dmgMin__c=20, dmgMax__c=80, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100, attack__c = 'Left leg', block__c= 'Left leg')
            };
        insert unitsList;
        
        Unit__c unit1 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c, attack__c, block__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Vasya'];
        Unit__c unit2 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c, attack__c, block__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Anton'];
                   
        List<ControllerForGameVFPage2.wrapperUnits> wrapperUnitsList = new List<ControllerForGameVFPage2.wrapperUnits> {
            											new ControllerForGameVFPage2.wrapperUnits(unit1, true, 'Live'), 
                                                        new ControllerForGameVFPage2.wrapperUnits(unit2, true, 'Live')
          												};
       
        newObject.setUnitsList(wrapperUnitsList);
        newObject.checkIfSelectedTwoAndLiveunits();
        newObject.fight2();
        System.assertEquals(true, newObject.WinnerFlag, 'The winner section unvisible. ');
    }
    
    @isTest
    /** Test for situation, where simulated that user select for manual-fight units with one empty attack field. */
    static void passIntoFight2MethodUnitsWithOneEmptyAttackField() {
        Test.startTest();
        ControllerForGameVFPage2 newObject = new ControllerForGameVFPage2();
        Test.stopTest();
        
        List<Unit__c> unitsList = new List<Unit__c> {
            new Unit__c(name='Vasya', hp__c=100, dmgMin__c=30, dmgMax__c=60, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100, block__c= 'Right Head'),
            new Unit__c(name='Anton', hp__c=-5, dmgMin__c=20, dmgMax__c=80, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100, attack__c = 'Left leg', block__c= 'Left leg')
            };
        insert unitsList;
        
        Unit__c unit1 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c, attack__c, block__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Vasya'];
        Unit__c unit2 = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c, attack__c, block__c,
                                  Winrate__c, Number_of_wins__c, Quantity_of_fights__c, Stamina__c, death_date__c
                         FROM Unit__c WHERE Name = 'Anton'];
                   
        List<ControllerForGameVFPage2.wrapperUnits> wrapperUnitsList = new List<ControllerForGameVFPage2.wrapperUnits> {
            											new ControllerForGameVFPage2.wrapperUnits(unit1, true, 'Live'), 
                                                        new ControllerForGameVFPage2.wrapperUnits(unit2, true, 'Live')
          												};
       
        newObject.setUnitsList(wrapperUnitsList);
        newObject.checkIfSelectedTwoAndLiveunits();
        newObject.fight2();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('Please, choose the attack and block for all units.'),
                            'Apex Message was not added.'); 
    }
    
    @isTest
    /** Test method for create new user. Normal situation, when all fields filled. */
    static void testNewUnitButton() {
        PageReference homePage = Page.GameVFPage2;
        
        Test.startTest();
        ControllerForGameVFPage2 newObject = new ControllerForGameVFPage2();
        Test.stopTest();
        
        Unit__c someUnit = new Unit__c(name='Anton', hp__c=100, dmgMin__c=20, dmgMax__c=80, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100);
        newObject.setNewUnit(someUnit);
        newObject.newUnit();
        Unit__c someUnitAfterNewUnitMethod = [SELECT Id, Name FROM Unit__c WHERE name='Anton'];
        System.assertNotEquals(null, someUnitAfterNewUnitMethod, 'Unit wasn\'t inserted.');
    }
    
    @isTest
    /** Test method for create new user. Situation, when HP field wasn't filled. */
    static void testNewUnitButtonIfUnitHasEmptyHpField() {
        PageReference homePage = Page.GameVFPage2;
        
        Test.startTest();
        ControllerForGameVFPage2 newObject = new ControllerForGameVFPage2();
        Test.stopTest();
        
        Unit__c someUnit = new Unit__c(name='Anton', dmgMin__c=20, dmgMax__c=80, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100);
        newObject.setNewUnit(someUnit);
        PageReference redirectedPage = newObject.newUnit();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('Please, fill all fields.'),
                            'Apex Message was not added.'); 
    }
    
    @isTest
    /** Test method for create new user. Situation, when name field wasn't filled. */
    static void testNewUnitButtonIfUnitHasEmptyNameField() {
        PageReference homePage = Page.GameVFPage2;
        
        Test.startTest();
        ControllerForGameVFPage2 newObject = new ControllerForGameVFPage2();
        Test.stopTest();
        
        Unit__c someUnit = new Unit__c(hp__c = 100, dmgMin__c=20, dmgMax__c=80, Number_of_wins__c = 0, Position_in_rating__c = 0, 
                        Quantity_of_fights__c = 0, Winrate__c = 0, Stamina__c = 100);
        newObject.setNewUnit(someUnit);
        PageReference redirectedPage = newObject.newUnit();
        System.assertEquals(TRUE, ApexPages.getMessages().get(0).getDetail().contains('Please, fill all fields.'),
                            'Apex Message was not added.'); 
    }
}