@isTest
public class AccountProcessorTest {
	@isTest
    public static void TestAccountProcessorTest() {
        Account acc = new Account();
            acc.Name = 'test account';
            insert acc;
       
        Contact con = new Contact();
        	con.LastName = 'test contact';
        	con.AccountId = acc.Id;
        	insert con;
        set<Id> setId = new set<Id>();
        	setId.add(acc.Id);
        Test.startTest();
        	AccountProcessor.countContacts(setId);
        Test.stopTest();
        
        Account count = [select Number_Of_Contacts__c from Account where Id =:acc.Id];
        system.assertEquals(1,integer.valueOf(count.Number_Of_Contacts__c));
        	
    }
}