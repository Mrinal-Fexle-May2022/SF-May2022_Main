/**
*  Description     :  Class With Future Method For Account.
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  08/26/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public class AccountProcessor {
     /**
     * 
     *   @description    :  This Method accepts a List of Account IDs and updates a custom field 
     * 						on the Account object with the number of contacts associated to the Account.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 08/26/2022 - Mrinal Das
     *		              
     * 
     **/
    
    @future
    public static void countContacts(List<Id> accountIds){
        
        List<Account> accList = [SELECT Id, Number_Of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN: accountIds];
        for(Account acc : accList){
            acc.Number_Of_Contacts__c = acc.Contacts.size();
        }
        
            update accList;
        
    }

}