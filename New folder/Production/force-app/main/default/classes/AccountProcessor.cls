public class AccountProcessor {
	@future
    public static void countContacts(list<Id> setId){
       list<Account> acclist = [SELECT Id,Number_Of_Contacts__c,(SELECT Id,AccountId from Contacts) from Account WHERE ID =:setId];
        for(Account acc : accList){
            list<Contact> con = acc.Contacts;
            acc.Number_Of_Contacts__c = con.size();
        }
          update acclist;
    }
}