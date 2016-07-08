@isTest
private class triggerOnNumberOfWinsTest {
    
    @isTest
    /** Check if "Winrate__c" field was changed. */
    static void checkIfWinrateUpdate() {
        Unit__c unit1 = new Unit__c(name='Vanya', Winrate__c = 0, Number_of_wins__c = 4, Quantity_of_fights__c = 12);
        insert unit1;
        Unit__c retrievedUnit1 = [SELECT Id, Name, Winrate__c FROM Unit__c WHERE Name = 'Vanya'];
        System.assertNotEquals(0, retrievedUnit1.Winrate__c);
    }
    
    @isTest
    /** Check if "Position_in_rating__c" field was changed. */
    static void checkIfPositionInRatingWasChanged() {
        /** Create new Units. */
        List<Unit__c> listOfUnits = new List<Unit__c> {new Unit__c(name='Vasya', Winrate__c = 0, Number_of_wins__c = 2, Quantity_of_fights__c = 5),
                                        new Unit__c(name='Petya', Winrate__c = 0, Number_of_wins__c = 4, Quantity_of_fights__c = 11),
    									new Unit__c(name='Anton', Winrate__c = 0, Number_of_wins__c = 8, Quantity_of_fights__c = 15)};
		insert listOfUnits;
        /** Retreive one record and update "Number_of_wins__c" field. */
        Unit__c retrievedUnit1 = [SELECT Id, Name, Winrate__c, Position_in_rating__c FROM Unit__c WHERE Name = 'Petya'];        
        retrievedUnit1.Number_of_wins__c = 10;
        /** Remember value of "Position_in_rating__c" field before update record. */
        Decimal positionInRatingBeforeUpdateUnit1 = retrievedUnit1.Position_in_rating__c;
        update retrievedUnit1;
        Unit__c retrievedUnit1AfterUpdate = [SELECT Id, Name, Winrate__c, Position_in_rating__c FROM Unit__c WHERE Name = 'Petya'];
        /** Check if "Position_in_rating__c" field was changed and equals 1.*/
        System.assertEquals(1, (Integer)retrievedUnit1AfterUpdate.Position_in_rating__c);
    }
}