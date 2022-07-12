/**
*  Description     :  This class for Practising Single and Bulk DML Operations
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  07/08/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public with sharing class ApexDMLOperations {       

    /**
     * 
     *   @description    :  This method  performs DML calls on single sObjects.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/08/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void singleDMLOperations() {

        //This example performs DML calls on single sObjects, which isn’t efficient.
        List<Contact> conList = [SELECT Department, Description from Contact];
        for(Contact badCon : conList) {
            if(badCon.Department == 'Finance') {
                badCon.Description = 'New description';
            }

            // Not a good practice since governor limits might be hit

            update badCon;
        }

    }

    
    /**
     * 
     *   @description    :  This method  performs DML operation in bulk.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/08/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void bulkDmlOperations(){

        //The DML operation is performed in bulk by calling update on a list of contacts. This code counts as one DML statement, which is far below the limit of 150.
        List<Contact> conList = [SELECT Department, Description from Contact];
        for(Contact con : conList) {
            if (con.Department == 'Finance'){
                con.Description = 'New description';
            }
        }

        // Call update on the list of contacts.
        // This results in one DML call for the entire list.
        update conList;
        System.debug(conList);



        //DML Operation on Custom Object

        List<Student__c> updatedStudent = new List<Student__c>(); 
        for(Student__c stuList : [SELECT Section__c, Stream__c FROM Student__c WHERE Stream__c = 'Arts' AND Section__c = 'C']){
            
            stuList.Section__c = 'B';
                updatedStudent.add(stuList);
        }

        update updatedStudent;
        System.debug('Section changed of the Students ->' + updatedStudent);
    }

    /**
     * 
     *   @description    :  This method  performs Adding and Retrieving Data With DML.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/08/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void addingAndRetrivingDataWithDml(){

        //Inserting a new account to the database
        Account acc = new Account(Name='Account Before Update');
        insert acc;

        // Querying the newly made  account.
        Account acc1 = [SELECT Name,Industry FROM Account WHERE Name='Account Before Update' LIMIT 1];

        System.debug('Account Name before update: ' + acc1.Name);
        System.debug('Account Industry before update: ' + acc1.Industry);// Industry is not set

        // Modify the two fields on the sObject.
        acc1.name = 'Account of the Day';
        acc1.Industry = 'Technology';

        // Persist the changes.
        update acc1;

        // Get a new copy of the account from the database with the two fields.
        Account acc2 = [SELECT Name,Industry FROM Account WHERE Name = 'Account of the Day' LIMIT 1];

        System.debug('Account Name after update: ' + acc2.Name);
        System.debug('Account Industry after update: ' + acc2.Industry);
        
    }

    /**
     * 
     *   @description    :  This method  performs Adding and Retrieving Data With DML.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/08/2022 - Mrinal Das
     *		              
     * 
     **/



    public static void apexInsertingAndUpdatingRecords(){
        Account[] accts = new List<Account>();
        for(Integer i=0; i<3; i++){
            Account acc = new Account(Name = 'Acme' + i, BillingCity='San Francisco');

            accts.add(acc);
        }

        Account accountToUpdate;
        try{
            insert accts;

            //update account Acme2.
            accountToUpdate = [SELECT BillingCity FROM Account WHERE Name = 'Acme2' AND BillingCity='San Francisco' LIMIT 1];

            //Update the billing city.
            accountToUpdate.BillingCity= 'New York';

            //Make the update call
            update accountToUpdate;
        } catch(DmlException e) {
            System.debug('An unexpected error has occunred: ' + e.getMessage());
        }

        // verify that the billing city was updated to New York.
        Account afterUpdate = [SELECT BillingCity FROM Account WHERE Id=:accountToUpdate.Id];
        System.assertEquals('New York', afterUpdate.BillingCity);
        System.debug('New York'+ afterUpdate.BillingCity);

        // inserting and Updating Records in Custom Objects

        Student__c [] student = new List<Student__c>();
        for(Integer i=0; i<3; i++){
            Student__c stu = new Student__c(Name = 'John Welver' + i, State__c='New Jersy');

            student.add(stu);
        }

        Student__c studentToUpdate;

        try{

            insert student;

            studentToUpdate = [SELECT State__c FROM Student__c WHERE Name='John Welver1' AND State__c='New Jersy'];

            studentToUpdate.State__c = 'Virginia';

            update studentToUpdate;

        } catch(DmlException e){
            System.debug('An unexpected error has occunred: ' + e.getMessage());
        }

        Student__c studentUpdate = [SELECT State__c FROM Student__c WHERE Id=:studentToUpdate.Id ];
        System.debug('New York '+ studentUpdate.State__c);
    }

    /**
     * 
     *   @description    :  This method  performs inserting and updating related records.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/08/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void apexInsertingAndUpdatingRelatedRecords(){
        try {
            Account acct = new Account(Name='SFDC Account');
            insert acct;
        
            // Once the account is inserted, the sObject will be 
            // populated with an ID.
            // Get this ID.
            ID acctID = acct.ID;
        
            // Add a contact to this account.
            Contact con = new Contact(
                FirstName='Joe',
                LastName='Smith',
                Phone='415.555.1212',
                AccountId=acctID);
            insert con;
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }

        try {
            // Query for the contact, which has been associated with an account.
            Contact queriedContact = [SELECT Account.Name 
                                      FROM Contact 
                                      WHERE FirstName = 'Joe' AND LastName='Smith'
                                      LIMIT 1];
        
            // Update the contact's phone number
            queriedContact.Phone = '415.555.1213';
        
            // Update the related account industry
            queriedContact.Account.Industry = 'Technology';
        
            // Make two separate calls 
            // 1. This call is to update the contact's phone.
            update queriedContact;
            // 2. This call is to update the related account's Industry field.
            update queriedContact.Account; 
        } catch(Exception e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }

    /**
     * 
     *   @description    :  This method  performs inserting and updating Custom Object related records.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/08/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void updatingCustomObjectRelatedRecord(){

        // Inserting Student, Teacher, HOD records and assigning id on the lookup feild of teacher and hod.
        try {
            HOD__c hodName = new HOD__c(Name = 'Rajeev');
            insert hodName;
            
            ID hodNameID = hodName.ID;
            
            Teacher__c teacher = new Teacher__c(Name = 'Vijay', HOD__c=hodNameID);
            insert teacher;
            
            ID teacherID = teacher.ID;
            
            Student__c student = new Student__c(Name = 'Nidhi', Teacher__c = teacherID);
            insert student;
                
        } catch(DmlException e){
            
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
        
        try{

            //Query for Student, Which has been associated with teacher and hod objects.
            
            Student__c queriedStudent = [SELECT Teacher__r.HOD__r.Name FROM Student__c WHERE Name = 'Nidhi' LIMIT 1];

            //Updating the related department on Hod from student object.
            
            HOD__c HODUpdate = new HOD__c(Id=queriedStudent.Teacher__r.HOD__c,Department__c='School Of CSE');

            update HODUpdate;
           
        } catch(Exception e) {
    		System.debug('An unexpected error has occurred: ' + e.getMessage());
		}

    }

     /**
     * 
     *   @description    :  This method  performs to update related records using external id.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/08/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void relatingRecordByUsingExternalId(){

        Opportunity newOpportunity = new Opportunity(Name = 'OpportunityWithAccount', StageName = 'prospecting', CloseDate=Date.today().addDays(7));

        Account accountReference = new Account(External_ID__c='SAP111111');

        //Add the account sObject to the opportunity
        newOpportunity.Account = accountReference;

        //Create the opportunity
        Database.SaveResult results = Database.insert(newOpportunity);
    }

     /**
     * 
     *   @description    :  This method is Creating Parent and Child Records in a Single Statement Using Foreign Keys
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/08/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void insertParentChild(){
        Date dt = Date.today();
        dt = dt.addDays(7);
        Opportunity newOpportunity = new Opportunity(Name = 'OpportunityWithAccountInsert', StageName = 'Prospecting', CloseDate = dt);

        Account accountReference = new Account(External_ID__c='SAP111112');
        newOpportunity.Account = accountReference;

        Account parentAccount = new Account(Name = 'Hallie', External_ID__c='SAP111112');

        Database.SaveResult[] results = Database.insert(new SObject[]{ parentAccount, newOpportunity});

        for(Integer i = 0; i< results.size(); i++){
            if(results[i].isSuccess()){
                System.debug('Successfully created ID: ' + results[i].getId());
            } else{
                System.debug('Error: could not create sobject ' + 'for array element ' + i + '.');
                System.debug('   The error reported was: ' + results[i].getErrors()[0].getMessage() + '\n');
            }
        }
    }
    
    /**
     * 
     *   @description    :  This method is Creating Parent and Child Records in a Single Statement Using Foreign Keys
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/08/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public static void insertingRelatedRecordUsingExternalId(){
       Contact newContact = new Contact(FirstName = 'John', LastName = 'Welver');
        
        Pan_Card__c panCardReference = new Pan_Card__c(External_Id__c = 'QUZ111223il');
        newContact.Pan_Card__c = panCardReference.Id;
        
        Pan_Card__c parentPanCard = new Pan_Card__c(Name= 'John', Age__c = 22, External_Id__c = 'QUZ111223il');
        Database.SaveResult[] results = Database.insert(new SObject[] {parentPanCard, newContact});
                                            
    }
    
    

     /**
     * 
     *   @description    :  This method  performs upsert records.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/08/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void apexUpsertingRecords(){
        Account[] acctsList = [SELECT Id, Name, BillingCity FROM Account WHERE BillingCity = 'Bombay'];

        for(Account acc: acctsList){
            acc.BillingCity = 'Mumbai';
        }

        Account newAcct = new Account(Name = 'Acme', BillingCity = 'San Francisco');
        acctsList.add(newAcct);
        try{
            upsert acctsList;
        } catch(DmlException e){
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
        
        //Upsert Contact Phone Feild
        
        List<Contact>conList = [Select Id, Name, Phone from Contact Where Phone='415.555.1213'];
        System.debug(conList);
        conList[0].Phone = '911.462.2516';
        Contact con = conList[0].clone();
        System.debug(con);
        con.phone = '999.222.5656';
        con.Email = 'salver912@gmail.com';
        con.FirstName = 'Mayve';
        con.LastName = 'Willie';
        conList.add(con);
        try{
            upsert conList;
            system.debug(conList);
        } catch(DmlException e){
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }

     /**
     * 
     *   @description    :   This method performs Merging Records
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/08/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void apexMergingRecords(){

        // Insert new accounts
        List<Account> ls = new List<Account>{ new Account(name='Acme Inc.'),new Account(name='Acme')};                                        
        insert ls;

       // Queries to get the inserted accounts 
        Account masterAcct = [SELECT Id, Name FROM Account WHERE Name = 'Acme Inc.' LIMIT 1];
        Account mergeAcct = [SELECT Id, Name FROM Account WHERE Name = 'Acme' LIMIT 1];

       // Add a contact to the account to be merged
        Contact c = new Contact(FirstName='Joe',LastName='Merged');
        c.AccountId = mergeAcct.Id;
        insert c;

        try {       
            merge masterAcct mergeAcct;
        } catch (DmlException e) {
            // Process exception
            System.debug('An unexpected error has occurred: ' + e.getMessage()); 
        }

        // Once the account is merged with the master account,
        // the related contact should be moved to the master record.
        masterAcct = [SELECT Id, Name, (SELECT FirstName,LastName From Contacts) 
              FROM Account WHERE Name = 'Acme Inc.' LIMIT 1];
        System.assert(masterAcct.getSObjects('Contacts').size() > 0);
        System.assertEquals('Joe', masterAcct.getSObjects('Contacts')[0].get('FirstName'));
        System.assertEquals('Merged', masterAcct.getSObjects('Contacts')[0].get('LastName'));

        // Verify that the merge record got deleted
        Account[] result = [SELECT Id, Name FROM Account WHERE Id=:mergeAcct.Id];
        System.assertEquals(0, result.size());

    }
    
    /**
     * 
     *   @description    :   This method performs Deleting Records
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/08/2022 - Mrinal Das
     *		              
     * 
     **/

     public static void apexDeleteRecord(){

        List<Account> deleteAcc = [SELECT Id, Name FROM Account WHERE Name = 'Acme0'];
        
        try{
            
            delete deleteAcc;
        } catch (DmlException e){
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }

     }

     /**
     * 
     *   @description    :   This method Shows Converting Leads
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/08/2022 - Mrinal Das
     *		              
     * 
     **/

     public static void apexConvertingLeads(){

        Lead newLead = new Lead(LastName = 'Fry', Company = 'Fry And Sons');
        insert newLead;

        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(newLead.id);

        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);

        Database.LeadConvertResult lcr = Database.convertLead(lc);
        System.assert(lcr.isSuccess());
     }
    
 }