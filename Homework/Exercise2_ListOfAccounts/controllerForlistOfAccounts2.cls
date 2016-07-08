public class controllerForlistOfAccounts2{
    
    List<wrapperAccounts> accountList;
    public List<Account> selectedObjects {get;set;}
    public Boolean renderedFlag {get;set;}
   
    public List<wrapperAccounts> getAccountList() {
        if(accountList == null) {
            accountList = new List<wrapperAccounts>();
            for(Account eachAccount: [select Id, Name, Industry, Description from Account]) {
                accountList.add(new wrapperAccounts(eachAccount));
            }
        }
        return accountList;
    }
    
    public PageReference processSelected() {   
        selectedObjects = new List<Account>();
        for(wrapperAccounts objSel: getAccountList()) {
            if(objSel.selected == true) {
                selectedObjects.add(objSel.acc);
            }
        }
        /** System.debug('These are the selected Accounts...');
        *for(Account obj: selectedObjects) {
        *    update obj;
        *}
        */

        renderedFlag = true;
        accountList = null; 
        return null;
    }

    public class wrapperAccounts{
        public Account acc {get; set;}
        public Boolean selected {get; set;}
        public wrapperAccounts(Account acc) {
            this.acc = acc;
            selected = false;
        }
    }
}