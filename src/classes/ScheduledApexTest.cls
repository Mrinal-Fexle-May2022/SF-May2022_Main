/**
*  Description     :  This is a Test Class that Test the Schedulable Apex Class.
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  08/26/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/
@istest
class ScheduledApexTest {

   static testmethod void test() {
   Test.startTest();
       
       Account a = new Account();
       a.Name = 'testScheduledApexFromTestMethod';
       a.Phone = '56874230';
       a.Email__c = 'daas125@gmail.com';
       a.IFSC_Code__c = '58445200';
       a.Type = 'Saving Account';
      insert a;

      // Schedule the test job

      String jobId = System.schedule('testBasicScheduledApex',
      ScheduledApex.CRON_EXP, 
         new ScheduledApex());

      // Get the information from the CronTrigger API object
      CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
         NextFireTime
         FROM CronTrigger WHERE id = :jobId];

      // Verify the expressions are the same
      System.assertEquals(ScheduledApex.CRON_EXP, 
         ct.CronExpression);

      // Verify the job has not run
      System.assertEquals(0, ct.TimesTriggered);

      // Verify the next time the job will run
      System.assertEquals('2022-09-03 00:00:00', 
         String.valueOf(ct.NextFireTime));
      System.assertNotEquals('testScheduledApexFromTestMethodUpdated',
         [SELECT id, name FROM account WHERE id = :a.id].name);

   Test.stopTest();

   System.assertEquals('testScheduledApexFromTestMethodUpdated',
   [SELECT Id, Name FROM Account WHERE Id = :a.Id].Name);

   }
}