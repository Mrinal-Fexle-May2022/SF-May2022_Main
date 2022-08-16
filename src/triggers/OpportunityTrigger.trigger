trigger OpportunityTrigger on Opportunity (After insert, After Update) {

    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
           OpportunityTriggerHandler.insertAndUpdateAutomobileRecords(Trigger.New, Trigger.oldMap);
        }
    }
}