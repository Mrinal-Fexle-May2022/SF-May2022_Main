@isTest
/**
*  Description     :  This is the Test Class test the execution of a queueable job in a test method.
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  08/26/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/
public class AsyncExecutionExampleTest {
    
    static testmethod void test1(){
        Test.startTest();
        ID jobID = System.enqueueJob(new AsyncExecutionExample());
        AsyncApexJob jobInfo = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobID];
        System.debug(jobInfo);
        System.enqueueJob(new AsyncExecutionExample());
        Test.stopTest();
        
        Account acct = [SELECT Name, Phone FROM Account WHERE Name='Acme' LIMIT 1];
        System.assertNotEquals(null, acct);
        System.assertEquals('(415) 555-1212', acct.Phone);
    }
}