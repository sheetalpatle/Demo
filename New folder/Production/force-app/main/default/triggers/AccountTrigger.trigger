trigger AccountTrigger on Account (after insert,after update) {
    
    if(trigger.isafter && (trigger.isinsert|| trigger.isupdate)){
        
        AccountTriggerHandler.createContact(trigger.new,Trigger.oldMap);
    }
}