/**
*  Description     :  This is a Test Class of Account Processor.
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  08/26/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

@isTest
public class AccountProcessorTest {
    
    /**
     * 
     *   @description    :  This Method Insert an Account and related Contact and checks the number of related Contact in the Account.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 08/26/2022 - Mrinal Das
     *		              
     * 
     **/
    public static testmethod void testAccountProcessor(){
        Account acc = new Account();
    	acc.Name = 'Test Account';
    	insert acc;
    
    	Contact con = new Contact();
        con.LastName = 'Test AccountContact';
        con.AccountId = acc.Id;
        
        insert con;
        
        List<Id> accListId = new List<Id>();
        accListId.add(acc.Id);
        
        Test.startTest();
        AccountProcessor.countContacts(accListId);
        Test.stopTest();
        
        Account accts = [SELECT Number_Of_Contacts__c FROM Account WHERE Id =: acc.Id];
        System.assertEquals(Integer.valueOf(accts.Number_Of_Contacts__c),1);
    }
}