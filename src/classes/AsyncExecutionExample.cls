/**
*  Description     :  This class shows implementation of the Queueable interface.
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  08/26/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/
public class AsyncExecutionExample implements Queueable {
    
    /**
     * 
     *   @description    :  The execute method in this example inserts a new account.
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
        Account acc = new Account(Name='Acme', Phone= '(415) 555-1212', Email__c = 'dasmrinal514@gmail.com', Type = 'FD Account', IFSC_Code__c = '548fdhk6');
        insert acc;
    }
}