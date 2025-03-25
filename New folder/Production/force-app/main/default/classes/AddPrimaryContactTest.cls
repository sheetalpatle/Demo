@isTest
public class AddPrimaryContactTest {
    @testSetup
    static void setup(){
        list<Account> accountList = new list<Account>();
        for(integer i=0; i<100; i++){
            if(i<50){
                accountList.add(new Account(Name = 'AC'+i, BillingState = 'NY'));
                
            }else
                accountList.add(new Account(Name = 'AC'+i, BillingState = 'CA'));
        }
        insert accountList;
    }
    @isTest
    static  void testAddPrimaryContactTest(){
        Contact con = new Contact(LastName = 'test Contact');
        AddPrimaryContact ac = new AddPrimaryContact(con , 'CA');
        test.StartTest();
        	system.enqueueJob(ac);
        test.StopTest();
        //system.assertEquals(50,[select Count() FROM Contact]);
        //System.assertEquals(50, [select count() from Contact]);

        
        
    }
}