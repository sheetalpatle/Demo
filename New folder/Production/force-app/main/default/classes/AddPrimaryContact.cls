public class AddPrimaryContact implements Queueable{
    
    Contact con;
    string state;
    public  AddPrimaryContact(Contact con,String state){
        this.con = con;
        this.state = state;
    }
    public void execute(QueueableContext QC){
        list<Account> staccount = [select Id from Account WHERE BillingState = :state LIMIT 200];
                List<Contact> lstOfConts = new List<Contact>();

        for(Account acc : staccount){
            //This line creates a new Contact record (conInst) by cloning the original Contact (con) passed into the constructor.
            Contact conInst = con.clone(false,false,false,false);
            conInst.AccountId = acc.Id;
            lstOfConts.add(conInst);
        }          
        insert lstOfConts;
        
    }
    
}