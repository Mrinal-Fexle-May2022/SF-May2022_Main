trigger DistrictTrigger on District__c (After insert, After update, After delete) {
    
    if(trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete){
        	DistrictTriggerHandler.updateNumberOfDistrict(Trigger.New, Trigger.old);
        	DistrictTriggerHandler.countryJSONGenerator(Trigger.New, Trigger.old);
    	}
    }
}