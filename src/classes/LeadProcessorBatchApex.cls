/**
*  Description     :  This class implements the Schedulable interface to update Lead records with a specific LeadSource.
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  08/26/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public class LeadProcessorBatchApex implements Database.Batchable<sObject> {
    public integer count = 0;

     /**
     * 
     *   @description    :  This start Method runs the querylocator to get the leadsource from Lead.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 08/26/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');
    }

    /**
     * 
     *   @description    :  This is a Execute method that update the leadSource of the Leads.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 08/26/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public void execute(Database.BatchableContext bc, List<Lead> leadList){
        List<Lead> newLeadlist = new List<Lead>();
        
        for(Lead leads : leadList){
            leads.leadSource = 'Dreamforce';
            newLeadlist.add(leads);
            count += 1;
        }
        
        if(newLeadlist.size() > 0){
          update newLeadlist;  
        }
    }

    /**
     * 
     *   @description    :  This Finish Method counts the number of leads Updated
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 08/26/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public void finish(Database.BatchableContext bc){
        system.debug('Count -> ' + count);
    }
}