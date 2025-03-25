public class AccountTriggerHandler {
    
    public static void createContact(List<Account> accList, Map<Id, Account> oldRecords) {
        List<Contact> contactToCreate = new List<Contact>();
        Set<Id> accountIds = new Set<Id>();

        for (Account acc : accList) {
            Account oldRecord = oldRecords != null ? oldRecords.get(acc.Id) : null;           
            accountIds.add(acc.Id);
        }

        try {
            Integer contactCount = [SELECT COUNT() FROM Contact WHERE AccountId IN :accountIds];
            if (contactCount == 0) {
                for (Account ac : accList ) {
                    if (ac.Create_Contact_Checkbox__c == true) {
                        Contact newContact = new Contact();
                        newContact.AccountId = ac.Id;
                        newContact.LastName = 'Contact';
                        newContact.FirstName = ac.Name;
                        newContact.Phone = ac.Phone;
                        contactToCreate.add(newContact);
                    }
                }

                if (!contactToCreate.isEmpty()) {
                    insert contactToCreate;
                }
            }
        } catch (Exception e) {
           System.debug('Error occurred while creating contacts: ' + e.getMessage());
           throw new AuraHandledException('Error occurred while creating contacts: ' + e.getMessage());
        }
    }
}