public class Game {
    public Integer damage (Unit unit) {                // count of random damage which hit every Unit
        Integer damage = (Integer) Math.floor(Math.random() * (unit.getDmgMax() - unit.getDmgMin() + 1) + unit.getDmgMin());
        System.debug(unit.getName() + ' hit damage' + damage);
        return damage;
    }
    
    public Unit fight(Unit unit1, Unit unit2) {        // standart method "fight" for two Units
        if (unit1.getHp() <= 0 && unit2.getHp() > 0) {
            return unit2;
        } else if (unit2.getHp() <= 0 && unit1.getHp() > 0) {
            return unit1;
        } else if (unit1.getHp() <= 0 && unit2.getHp() <= 0) {
            return null;
        }
        unit1.setHp(unit1.getHp() - Damage(unit2));
        unit2.setHp(unit2.getHp() - Damage(unit1));
        return Fight(unit1, unit2);  // recursive call "fight" method
    }
    
    public List<Unit> fight(List<Unit> listOfFighters) { // method "fight" for any number of Units; accept "List<Unit>" as parameter
        List<Unit> survivors = new List<Unit> ();  // create "List<Unit>" for survivors
        Integer totalDamage = 0;
        for (Integer i = 0; i < listOfFighters.size(); i++) {
            if (listOfFighters.get(i).getHp() >= 0) {
                listOfFighters.get(i).setDmg(Damage(listOfFighters.get(i)));
                totalDamage += listOfFighters.get(i).getDmg();
                survivors.add(listOfFighters.get(i));      // adding survivors to "List<Unit> survivors"
            }  
        }
        
        if (survivors.size() <= 1) {  // return result: List with winner or empty List if all Units was killed
            return survivors;
        } 
             
        for (Integer i = 0; i < survivors.size(); i++) {  // total fight: every Unit get total damage divide on the number of enemies
            listOfFighters.get(i).setHp(listOfFighters.get(i).getHp() - (totalDamage - listOfFighters.get(i).getDmg())/ (survivors.size() - 1));
        }
        return fight(survivors); // recursive call "fight" method
    }   
}