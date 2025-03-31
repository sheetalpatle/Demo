public class MixDmlClass {
    
    public static void DemoMixsDml(){
        Account acc = new Account();
        acc.Name = 'Sheetal2';
        insert acc;
        avoidMixDmlError();
        //addin comments for checking
       
    }
    @future
    public static void avoidMixDmlError(){
       Profile p = [select Id from Profile WHERE Name = 'System Administrator'];
        UserRole ur = [SELECT Id, Name FROM UserRole Where Name = 'CEO'];
        User us = new User(alias = 'sheetal', email='sheetal.patle@ngauge.digital', 
            emailencodingkey='UTF-8', lastname='Hours', 
            languagelocalekey='en_US', 
            localesidkey='en_US', profileid = p.Id, userroleid = ur.Id,
            timezonesidkey='America/Los_Angeles', 
            username='sheetal.patle@ngauge.digital');
            
            insert us;
    }
    
}