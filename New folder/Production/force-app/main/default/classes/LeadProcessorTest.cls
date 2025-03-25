@isTest
public class LeadProcessorTest {
    @testSetup
    static void testLeadProcessorTest(){
        list<Lead> leads = new list<Lead>();
        for(integer i=0 ; i<200; i++){
            Lead le = new Lead(
                LastName='Lead '+i,
                Status = 'Open - Not Contacted',
                Company='Lead'
            );
            leads.add(le);
        }
        insert leads;
    }
  @isTest static void test() {
        Test.startTest();
        	LeadProcessor lp = new LeadProcessor();
        	Id setId = Database.executeBatch(lp,200);
        Test.stopTest();
             System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);

    }
    @isTest
    static void testLeads(){
        
    }
    
}