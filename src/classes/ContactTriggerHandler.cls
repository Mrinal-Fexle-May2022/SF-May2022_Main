/**
*  Description     :  This Class Handle Contact Trigger for Inserting and Updating Records
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  08/12/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public with sharing class ContactTriggerHandler {
    
    /**
     * 
     *   @description    :  This method Handle Contact status. If contact status is blan then it put the status of its parent or grandparent.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 08/12/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public static void syncContactStatus(List<Contact>conList, Map<Id, Contact>oldConMap){
        //Set of Contacts with account ids
        Set<Id> setOfConWithAccIds = new Set<Id>();
        for(Contact con: conList){
            setOfConWithAccIds.add(con.AccountId);
        }
        
        Map<Id, Account> accMap = new Map <id, Account>([SELECT Id, Status__c, Property__r.Status__c FROM Account WHERE Id IN: setOfConWithAccIds]);
        System.debug(accMap);
        
        for(Contact con: conList){
            if(con.Status__c == null){
                Account acc = accMap.get(con.AccountId); 
                if(acc.Status__c != null){
                    con.Status__c = acc.Status__c; //If contact status is null and account status is not null then fill the contact status
                }
                else if(acc.Status__c == null && acc.Property__r.Status__c != null){
                    con.Status__c = acc.Property__r.Status__c; // else if account status is null then fill the status of the property
                }
            } 
        }
    }
}