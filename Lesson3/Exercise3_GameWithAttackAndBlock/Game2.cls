public class Game2 {

    public final List<String> attacksAndBlocksList = new List<String> {'Right Head', 'Left Head', 'Right Body', 'Left Body', 'Right Leg', 'Left Leg'};

    
    /** count of random damage which hit every Unit */
    public Integer damage (Unit__c unit) {                /** count of random damage which hit every Unit */
        Integer damage = (Integer) Math.floor(Math.random() * (unit.DmgMax__c - unit.DmgMin__c + 1) + unit.DmgMin__c);
        System.debug(unit.Name + ' hit damage' + damage);
        return damage;
    }
    
    /** retrieve unit for save his HP when we will update this unit */
    public Unit__c retrieveMyUnit(Unit__c someUnit) {
        Unit__c retrievedUnit = [SELECT Id, Name, hp__c, dmgMin__c, dmgMax__c, attack__c, block__c, death_date__c 
                                 FROM Unit__c
                                 WHERE Id =:someUnit.Id];
        return retrievedUnit;
        }
        
    public String randomAttacksAndBlocks() {
    return attacksAndBlocksList.get((Integer) Math.floor(Math.random() * (attacksAndBlocksList.size())));
    }
    
    /** standart method "fight" for two Units (auto-fight) */
    public Unit__c fight(Unit__c unit1, Unit__c unit2) {
        /** check if we have winner or everybody died */        
        if (unit1.Hp__c <= 0 && unit2.Hp__c > 0) {               
            unit1 = retrieveMyUnit(unit1);
            unit1.death_date__c = Date.today();
            update unit1;
            return unit2;
        } else if (unit2.Hp__c <= 0 && unit1.Hp__c > 0) {
            unit2 = retrieveMyUnit(unit1);
            unit2.death_date__c = Date.today();
            update unit2;
            return unit1;
        } else if (unit1.Hp__c <= 0 && unit2.Hp__c <= 0) {
            unit1 = retrieveMyUnit(unit1);
            unit2 = retrieveMyUnit(unit1);
            unit1.death_date__c = Date.today();
            unit2.death_date__c = Date.today();
            update unit1;
            update unit2;
            return null;
        }
        /** set up random values of Attacks and Blocks */
        unit1.attack__c = randomAttacksAndBlocks();
        unit2.attack__c = randomAttacksAndBlocks();
        unit1.block__c = randomAttacksAndBlocks();
        unit2.block__c = randomAttacksAndBlocks();
        
        Integer damageFromUnit1;
        Integer damageFromUnit2 = damage(unit2);
        /** check if attack was neutralized (matched to Block) */
        if (unit1.attack__c.equals(unit2.block__c)) {
            damageFromUnit1 = 0;
        } else {
            damageFromUnit1 = damage(unit1);
        }
        
        if (unit2.attack__c.equals(unit1.block__c)) {
            damageFromUnit2 = 0;
        } else {
            damageFromUnit2 = damage(unit2);
        }
        unit1.Hp__c = unit1.Hp__c - damageFromUnit2;
        unit2.Hp__c = unit2.Hp__c - damageFromUnit1;
        /** recursive call "fight" method */
        return Fight(unit1, unit2);  
    }  
    
    /** manual-fight method*/
    public void fightByStep(Unit__c unit1, Unit__c unit2) {       
    
        Integer damageFromUnit1;
        Integer damageFromUnit2 = damage(unit2);
        if (unit1.attack__c.equals(unit2.block__c)) {
            damageFromUnit1 = 0;
        } else {
            damageFromUnit1 = damage(unit1);
        }
        
        if (unit2.attack__c.equals(unit1.block__c)) {
            damageFromUnit2 = 0;
        } else {
            damageFromUnit2 = damage(unit2);
        }
        unit1.Hp__c = unit1.Hp__c - damageFromUnit2;
        unit2.Hp__c = unit2.Hp__c - damageFromUnit1;
    }
}