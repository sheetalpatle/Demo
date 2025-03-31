// account detail handler
public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static Account getAccountDetails(Id accountId) {
        return [SELECT Id, Name,Phone, Rating, Type, Industry,(SELECT Id, Name, Phone FROM Contacts LIMIT 1)  FROM Account WHERE Id = :accountId LIMIT 1];
    }

    @AuraEnabled
    public static void updateAccount(Account account) {
        update account;
    }
    @AuraEnabled
    public static void deleteContacts(list<Id> contactIds) {
        try{
        list<Contact> contactToDelete = [SELECT Id,Name FROM Contact WHERE Id =:contactIds];
        delete contactToDelete;

        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
        
    }
}