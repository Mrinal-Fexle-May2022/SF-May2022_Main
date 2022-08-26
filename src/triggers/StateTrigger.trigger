trigger StateTrigger on State__c (After insert, After update, After delete) {
    
    if(trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete){
            StateTriggerHandler.updateNumberOfState(Trigger.New, Trigger.old);
        	StateTriggerHandler.countryJSONGenerator(Trigger.New, Trigger.old);
    	}
    }
}