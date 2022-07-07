/**
*  Description     :  This class is for practising SObject in apex
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  07/05/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public with sharing class ApexSObject {
    
     /**
     * 
     *   @description    :  This method shows different ways to assign sObjects 
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/05/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public ApexSObject() {
        //An sObject variable represents a row of data and can only be declared in Apex using the SOAP API name of the object
       Account acc = new Account();
       Student__c stu = new Student__c();

       //The use of the generic sObject abstract type to represent any object
       sObject acc1 = new Account();

       //casting between the generic sObject type and the specific sObject type
       Account acc2 = (Account)acc1;

       //specifying initial field values with comma-separated name = value pairs when instantiating a new sObject
       Account acc3 = new Account(name = 'Acme', billingcity = 'San Francisco');
       System.debug(acc3);
    }
    
     /**
     * 
     *   @description    :   Method Shows how to insert feild to an object and convert a sobject before operation 
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/05/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void accessingSObjectFeilds(){
        Account acc = new Account(Name = 'Acme', BillingCity = 'San Francisco'); //Assign name and billing city to account
        insert acc;
        acc.Name = 'Acme'; // Access the account name field and assign it 'Acme'

        sObject accessId = [SELECT Id, Name FROM Account WHERE Name = 'Acme' LIMIT 1];
        ID id = accessId.ID;
        System.debug(id);

        // It is recommended to first convert an SObject into a specific object before performing an operation.
        Account convertedAccount = (Account)accessId;
        convertedAccount.name = 'Acme2';
        update convertedAccount;
        Contact con = new Contact(FirstName = 'Sal', LastName = 'Welver', Account = convertedAccount);
        insert con;
        System.debug(con);


    }

    /**
     * 
     *   @description    :   Method Converting a Custom SObject to generic object and filling data into feild.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/05/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void insertCustomObject() {
        sObject student = new Student__c();

        Student__c convertingStudent = (Student__c)student;

        convertingStudent.Roll_Number__c = 025;
		convertingStudent.Name = 'Mrinal Das';
        convertingStudent.Phone_Number__c = '6289560710';
        convertingStudent.Father_Name__c = 'Mr. Mahesh Das';
        convertingStudent.Father_Mobile_Number__c = '727800055';
        convertingStudent.Mobile_Number__c = '65823256465';
		convertingStudent.Overall_Grade__c = 'A';
		convertingStudent.Email__c = 'dasmrinal216@gmail.com';
        convertingStudent.Address__c = 'Duttapukur, WestBengal- 26587';

        insert convertingStudent;
        System.debug('Records Updated');

        
    }

    /**
     * 
     *   @description    :   Method to update a Custom feild using Sobject
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/05/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public static void updateCustomObject() {

        StudentSubjects__c studentSub = new StudentSubjects__c(Name = 'BST-03'); //Assign name and billing city to account
        insert studentSub;

        sObject accessId = [SELECT Id, Name FROM StudentSubjects__c WHERE Name = 'BST-03' LIMIT 1];
        ID id = accessId.ID;
        System.debug(id);

        // It is recommended to first convert an SObject into a specific object before performing an operation.
        StudentSubjects__c convertedStudent = (StudentSubjects__c)accessId;
        convertedStudent.name = 'BST-04';
        update convertedStudent;
    }

     /**
     * 
     *   @description    :  Method to try isSet funtion 
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/05/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void SObjectFeilds() {
        Contact nullFirst = new Contact(LastName='Codey', FirstName=null);
        System.assertEquals(true, nullFirst.isSet('FirstName'), 'FirstName is set to literal value, so it counts as set');
        Contact unsetFirst = new Contact(LastName='Astro');
        System.assertEquals(false, unsetFirst.isSet('FirstName'), 'FirstName is not set');
    }
}