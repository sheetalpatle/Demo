@isTest(SeeAllData=false)
public class AccountTriggerHandlerTest {
    
    @isTest
    public static void testCreateContact() {
        Account acc1 = new Account(
            Name = 'Test Account 1',
            Phone = '999999999',
            Create_Contact_Checkbox__c = true
        );
        
        list<Account> accountList = new list<Account>{acc1};
            insert accountList;
        
        Test.startTest();
        
        Test.stopTest();
        Contact createdContact = [SELECT AccountId, LastName, FirstName, Phone FROM Contact WHERE AccountId = :acc1.Id LIMIT 1];
        System.assertEquals('Contact', createdContact.LastName);
        System.assertEquals('Test Account 1', createdContact.FirstName);
        System.assertEquals('999999999', createdContact.Phone, 'Contact phone should match account phone');
        
    }
    @isTest
    public static void testCreateContactOnUpdate() {
        
        Account acc2 = new Account(
            Name = 'Test Account 2',
            Phone = '999999999',
            Create_Contact_Checkbox__c = false
        );
        
        
        insert acc2;
        acc2.Create_Contact_Checkbox__c = true; 
        update acc2;

        Contact createdContact = [SELECT AccountId, LastName, FirstName, Phone FROM Contact WHERE AccountId = :acc2.Id LIMIT 1];
        System.assertNotEquals(null, createdContact);
        System.assertEquals('Contact', createdContact.LastName);
        System.assertEquals('Test Account 2', createdContact.FirstName);
        System.assertEquals('999999999', createdContact.Phone);
    }

}