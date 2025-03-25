public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContacts(Id accountId) {

        return [
            SELECT FirstName, LastName, Phone, Email
            FROM Contact
            WHERE AccountId = :accountId];
    }
    @AuraEnabled
    public static list<Contact> updateContacts(list<Contact> contacts){
        try{
            update contacts;
            return contacts;
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}