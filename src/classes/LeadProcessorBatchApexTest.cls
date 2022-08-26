/**
*  Description     :  This Test Class insert 200 Lead records, 
                      schedule the DailyLeadProcessor class to run and test that all Lead records were updated correctly
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
public class LeadProcessorBatchApexTest {
    @testSetup
    static void setup(){
        List<Lead> leadList = new List<Lead>();
        
        for(Integer i= 1; i <= 200; i++){
            Lead leads = new Lead();
            leads.LastName = 'Acme' + i;
            leads.Company = 'firebolt';
            leads.Status = 'Working - Contacted';
            leadList.add(leads);
        }
        
        insert leadList;
    }
    
    @isTest static void test(){
        Test.startTest();
        LeadProcessorBatchApex leadProcess = new LeadProcessorBatchApex();
        Id batchId = Database.executeBatch(leadProcess);
        Test.stopTest();
        
        System.assertEquals(200, [SELECT Count() FROM Lead WHERE Company = 'firebolt']);
    }
}