/**
*  Description     :  This class fetch all Account related Opportuntiy, Contacts and Cases Id's and Names.
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  09/03/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public with sharing class AccountRelatedDataLWC {

     /**
     * 
     *   @description    :   Method to return Account List. 
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 09/03/2022 - Mrinal Das
     *		              
     * 
     **/

    @AuraEnabled(cacheable=true)
    public static list<Account> getAccountDetails(String recordKey){
        List<Account>accList =  [SELECT Id, Name FROM Account WHERE Id = :recordKey];
        System.debug(accList);
        return accList;
       
    } 

    /**
     * 
     *   @description    :   Method to return Account  Id related  ContactList. 
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 09/03/2022 - Mrinal Das
     *		              
     * 
     **/

    @AuraEnabled(cacheable=true)
    public static list<Contact> getContactDetails(String recordKey){
        List<Contact> conList = [SELECT Id, LastName FROM Contact WHERE AccountId =: recordKey];
        System.debug(conList);
        return conList;
    }

    /**
     * 
     *   @description    :   Method to return Account  Id related  Opportunity List. 
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 09/03/2022 - Mrinal Das
     *		              
     * 
     **/

    @AuraEnabled(cacheable=true)
    public static list<Opportunity> getOpportunityDetails(String recordKey){
        List<Opportunity> oppList = [SELECT Id, Name FROM Opportunity WHERE AccountId =: recordKey];
        System.debug(oppList);
        return oppList;
    }

    /**
     * 
     *   @description    :   Method to return Account  Id related  Case List. 
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 09/03/2022 - Mrinal Das
     *		              
     * 
     **/

    @AuraEnabled(cacheable=true)
    public static list<Case> getCaseDetails(String recordKey){
        List<Case> caseList = [SELECT Id, CaseNumber, AccountId, ContactId FROM Case WHERE AccountId =: recordKey];
        System.debug(caseList);
        return caseList;
    }
}