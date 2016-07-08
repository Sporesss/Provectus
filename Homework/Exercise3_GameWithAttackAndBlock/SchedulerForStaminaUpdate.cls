global class SchedulerForStaminaUpdate implements Schedulable {
	global void execute(SchedulableContext sc){
        List<Unit__c> allUnits = [SELECT Id, Stamina__c FROM Unit__c];
        for (Unit__c eachUnit : allUnits) {
            eachUnit.Stamina__c = 100;
        }
        update allUnits;
    }
    /** for run
    SchedulerForStaminaUpdate sched = new SchedulerForStaminaUpdate();
	String timeAndDate = '0 0 1 * * ?'; // every day at 1 am
	String jobID = system.schedule('Update Stamina', timeAndDate, sched);
	*/
}