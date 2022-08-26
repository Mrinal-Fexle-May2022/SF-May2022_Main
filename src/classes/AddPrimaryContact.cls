/**
*  Description     :  This Class Implements Queueable Apex that inserts the same Contact for each Account for a specific state.
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  08/26/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/
public class AddPrimaryContact implements Queueable {
    
    Private Contact con;
    Private String state;
    
    public AddPrimaryContact(Contact con, String state){
        this.con = con;
        this.state = state;
    }
    /**
     * 
     *   @description    :  This Method Query For the Billing State and Insert the contact for the account.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 08/26/2022 - Mrinal Das
     *		              
     * 
     **/
    public void execute (QueueableContext context){
        List<Account> accs = [SELECT Id, Name, (SELECT Id,  LastName FROM Contacts) FROM Account WHERE BillingState =: state LIMIT 200];
        
        List<Contact> primaryCon = new List<Contact>();
        for(Account acc : accs){
            Contact con = con.clone();
        	con.AccountId = acc.Id;
            primaryCon.add(con);
        }
        
        if(primaryCon.size() > 0){
            insert primaryCon;
        }
    }
    
}