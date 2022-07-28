/**
*  Description     :  Trigger Practise to check old and new value for all Trigger Events.
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  07/20/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

trigger AccountTriggerEvents on Account (before insert, before update, after insert, after update, after delete) {

    if(Trigger.isBefore){
        
        system.debug('Checking in Before Trigger Operations');
        //Checking Before Insert
        if(Trigger.isInsert){
            
            system.debug('Check Insert List ::: Trigger.New ' + Trigger.New);
            system.debug('Check Insert List ::: Trigger.old ' + Trigger.old);
        }
        
        //Checking before Update
        if(Trigger.isUpdate){
            
            system.debug('Check Update List ::: Trigger.New ' + Trigger.New);
            system.debug('Check Update List ::: Trigger.old ' + Trigger.old);
            
            //If the Type value Change on Account the Trigger will Fire
            if(Trigger.New[0].Type != Trigger.old[0].Type){
                
                system.debug('Type Value Changed');
                system.debug('Trigger.New Data' + Trigger.New[0].Type);
                system.debug('Trigger.old Data' + Trigger.old[0].Type);
            }
        }
    }
    
    if(Trigger.isAfter){
    
        system.debug('Checking in After Trigger Operations');
        //Cheking After Insert
        if(Trigger.isInsert){
            
            system.debug('Check Insert List ::: Trigger.New ' + Trigger.New);
            system.debug('Check Insert List ::: Trigger.old ' + Trigger.old);
        }
        
        //Checking After Update
        if(Trigger.isUpdate){
            
            system.debug('Check Update List ::: Trigger.New ' + Trigger.New);
            system.debug('Check Update List ::: Trigger.old ' + Trigger.old);
            
            if(Trigger.New[0].Type != Trigger.old[0].Type){
                
                system.debug('Type Value Changed');
                system.debug('Trigger.New Data' + Trigger.New[0].Type);
                system.debug('Trigger.old Data' + Trigger.old[0].Type);
            }
        }
        
        //Checking After Delete
        if(Trigger.isDelete){
            system.debug('Check Delete List ::: Trigger.New ' + Trigger.New);
            system.debug('Check Delete List ::: Trigger.old ' + Trigger.old);
        }
    }
}