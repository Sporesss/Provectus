public with sharing class ControllerForCompaniesAndWorkPeriod {
    public List<Work_Period__c> workPeriodList {get;set;}
    private List<Account> accountList;
    
    public ControllerForCompaniesAndWorkPeriod() {
        workPeriodList = [SELECT Id, Name, Order__r.Account__r.Id, Rate__r.Revenue__c, Rate__r.Margin__c, Start_Date__c, End_Date__c FROM Work_Period__c];
    }
    
    public List<Account> getAccountList() {
        List<Id> accountIdList = new List<Id> ();
        for (Work_Period__c eachWorkPeriod : workPeriodList ) {
            accountIdList.add(eachWorkPeriod.Order__r.Account__r.Id);
        }
        accountList = [SELECT Id, Name FROM Account WHERE Id =: accountIdList];
        return accountList;
    }
}