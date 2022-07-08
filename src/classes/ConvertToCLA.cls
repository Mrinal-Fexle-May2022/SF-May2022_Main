/**
*  Description     :  The Class shows to use SOSL over a set of records to determine their object type
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  07/03/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/
public with sharing class ConvertToCLA {
    
    Static List<Contact> contacts = new List<Contact>();
    Static List<Lead> leads = new List<Lead>();
    Static List<Account> accounts = new List<Account>();
    
    /**
     * 
     *   @description    :   Method to run SOSL query over Account, Lead and Contact with adding record to the list
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/03/2022 - Mrinal Das
     *		              
     * 
     **/
 
    public Static void convertType(String phoneNumber) {
        List<List<SObject>> results = [FIND :phoneNumber 
            IN Phone FIELDS 
            RETURNING Contact(Id, Phone, FirstName, LastName), 
            Lead(Id, Phone, FirstName, LastName), 
            Account(Id, Phone, Name)];
        List<SObject> records = new List<SObject>();
        records.addAll(results[0]); //add Contact results to our results super-set
        records.addAll(results[1]); //add Lead results
        records.addAll(results[2]); //add Account results
 
        if (!records.isEmpty()) { 
            for (Integer i = 0; i < records.size(); i++) { 
                SObject record = records[i];
                if (record.getSObjectType() == Contact.sObjectType) { 
                    contacts.add((Contact) record);
                } else if (record.getSObjectType() == Lead.sObjectType){ 
                    leads.add((Lead) record);
                } else if (record.getSObjectType() == Account.sObjectType) { 
                    accounts.add((Account) record); 
                }
            }
        }
        
        System.debug('Record List => ' + records);
        System.debug('Account List => ' + accounts);
        System.debug('Lead List => ' + leads);
        System.debug('Contact List => ' + contacts);


    }
    
}