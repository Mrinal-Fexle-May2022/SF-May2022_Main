/**
*  Purpose         :  This trigger is to handle send mail and update Account Number on Account Object.
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  07/20/2022
*
*  Revision Logs   :  V1.0 - Created - Mrinal Das
*
**/

trigger AccountTrigger on Account (after insert, before insert, after update, before update) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){

            //Calling updateaccount method from the class
            AccountTriggerHandler.updateAccountNumber(Trigger.New);
        }
        
        //Throws Error While updating the account number feild
        if(Trigger.isUpdate){
            AccountTriggerHandler.accountNumberUpdateError(Trigger.New, Trigger.oldMap);
            AccountTriggerHandler.updateAccountNumber(Trigger.New);
        }
    }
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){

            //Calling sendemail method from the class
            AccountTriggerHandler.sendAccountEmail(Trigger.New);
        }
        
        //Send Email When feild is Updated
        if(Trigger.isUpdate){
            
            AccountTriggerHandler.UpdateAccountEmail(Trigger.New, Trigger.oldMap);
        }
    }
}