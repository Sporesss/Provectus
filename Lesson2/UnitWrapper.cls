global class UnitWrapper implements Comparable {
    
    public Unit someUnit;
    
    public UnitWrapper(Unit someUnit) {
        this.someUnit = someUnit;
    }
    
    global Integer compareTo (Object someObject) {
        UnitWrapper objectForCompare = (UnitWrapper)someObject;
        
        Integer returnValue = 0;
        if (someUnit.getHp() > objectForCompare.someUnit.getHp()) {
            returnValue = 1;
        } else if (someUnit.getHp() > objectForCompare.someUnit.getHp()) {
            returnValue = -1;
        }
        return returnValue;
    }
    
    /* for run in the developer console
   
    List<UnitWrapper> listOfUnits = new List<UnitWrapper> {new UnitWrapper(new Unit('Orc', 200, 18, 50, false)),
    new UnitWrapper(new Unit('John Snow', 180, 22, 55, false)),
    new UnitWrapper(new Unit('Red Woman', 150, 20, 40, false)),
    new UnitWrapper(new Unit('Wild man', 170, 25, 45, false))
	};
                                                                                 
	for (UnitWrapper eachUnit : listOfUnits) {
   	System.debug(eachUnit);                                             
	} 
	listOfUnits.sort();
	System.debug('AFTER SORT _____________________________________________________________');
	for (UnitWrapper eachUnit : listOfUnits) {
   	System.debug(eachUnit);                                             
	}*/ 
}