public with sharing class ControllerForLesson3Page {

    public WorkPeriod3 periodAsus {get;set;}
    public WorkPeriod3 periodSamsung {get;set;}
    
    public ControllerForLesson3Page() {
        Company3 asus = new Company3('ASUS', 1);
        Company3 samsung = new Company3('Samsung', 2);
        
        Order3 orderAsus = new Order3('orderAsus', 1, asus);
        Order3 orderSamsung = new Order3('orderSamsung ', 2, samsung);
        
        Rate3 rateAsus  = new Rate3 ('rateAsus', 1, 10000, 1000);
        Rate3 rateSamsung  = new Rate3('rateSamsung', 2, 15000, 1500);
        
        periodAsus = new WorkPeriod3 ('periodAsus', 1, orderAsus, rateAsus, Date.today(),  Date.today().addDays(2)) ;
        periodSamsung = new WorkPeriod3 ('periodSamsung', 2, orderSamsung, rateSamsung, Date.today().addDays(1), Date.today().addDays(10)) ;       
    }
}