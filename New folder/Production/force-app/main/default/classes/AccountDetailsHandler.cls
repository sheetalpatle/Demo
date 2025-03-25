public without sharing class AccountDetailsHandler {
    @AuraEnabled(cacheable=true)
    public static account getAccountDetails(Id accountId) {
            account result = [select Name, Rating, Type, Industry, Phone,(SELECT Phone FROM Contacts) 
                             from Account 
                             WHERE Id =: accountId];
            return result;
    }
    @AuraEnabled
    public static account updateAccountDetails(Id accountId, String accountName, String rating, String type, String industry, String phone){
        Account accountToUpdate = [SELECT Id, Name, Rating, Type, Industry,(SELECT Phone FROM Contacts) FROM Account WHERE Id = :accountId LIMIT 1];
        
        // Update the fields
        accountToUpdate.Name = accountName;
        accountToUpdate.Rating = rating;
        accountToUpdate.Type = type;
        accountToUpdate.Industry = industry;
        accountToUpdate.Contacts[0].Phone = phone;

        update accountToUpdate;

        return accountToUpdate; 
    
    }
    
}