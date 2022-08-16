trigger ContactTrigger on Contact (Before insert, Before Update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            ContactTriggerHandler.syncContactStatus(Trigger.new, Trigger.oldMap);
        }
    }
}