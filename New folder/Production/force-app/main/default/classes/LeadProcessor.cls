public class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful{
    
    public Database.Querylocator Start(Database.BatchableContext BC){ //Database.Querylocato-->return Object/records
        return Database.getQueryLocator('select Id,LeadSource from Lead');//Database.getQueryLocator-->
        
    }
    public integer recordProcessed = 0;
    public void execute(Database.BatchableContext BC,list<Lead> scope){
        list<Lead> leadList = new list<Lead>();
        for(integer i=0 ; i<20; i++){
        for(Lead leads : scope){
            leads.LastName = 'Lead'+i;
            leads.LeadSource = 'Dreamforce';
            recordProcessed = recordProcessed + 1;
        }
        }
        update scope;
    }
    public void finish(database.BatchableContext BC){
         System.debug(recordProcessed + ' records processed. Shazam!');
        //  Database.batacth(new LeadProcessor());
    }

}