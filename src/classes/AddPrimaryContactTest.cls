/**
*  Description     :  This Class Test the AddPrimaryAccountContact Class.
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
public class AddPrimaryContactTest {
    
     /**
     * 
     *   @description    :  This Method insert 50 Account records for BillingState NY and 50 Account records for BillingState CA.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 08/26/2022 - Mrinal Das
     *		              
     * 
     **/
    
    static testmethod void testQueueable(){
        List<Account> testAccounts = new List<Account>();
        for(Integer i=0; i<50; i++){
            testAccounts.add(new Account(Name='Account '+i, BillingState='CA'));
        }
        for(Integer j=0; j<50; j++){
            testAccounts.add(new Account(Name='Account '+j, BillingState='NY'));
        }
        insert testAccounts;
        
        Contact testContact = new Contact(FirstName = 'John', LastName='Doe');
        insert testContact;
        
        AddPrimaryContact addAcc = new addPrimaryContact(testContact, 'CA');
        
        Test.startTest();
        System.enqueueJob(addAcc);
        Test.stopTest();
        
        System.assertEquals(50, [SELECT Count() FROM Contact WHERE accountId IN (SELECT Id FROM Account WHERE BillingState='CA')]);
    }
}