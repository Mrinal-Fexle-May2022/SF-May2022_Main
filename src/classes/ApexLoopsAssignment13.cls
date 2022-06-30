/**
*  Description     :  Practicing all types of loops in Apex
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/27/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				     
*
**/

public with sharing class ApexLoopsAssignment13 {

    /**
     * 
     *   @description    :   Example of Do While loop
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void apexDoWhileLoop(){
        Integer count = 1;

        do {
            System.debug(count);
            count++;
        } while (count < 11);

        System.debug(count);
    }
    
    /**
     * 
     *   @description    :   Example of Do While loop iterating on a list
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public static void listOnDoWhile(){
        List<Lead> leadList = [SELECT id, Name, Company FROM Lead WHERE Status = 'Working - Contacted'];
        Integer indexOfList = 0;
        
    
    	do {
            
            system.debug(leadList[indexOfList]);
            indexOfList++;
            
    		}
        
    	while(indexOfList < 3);  

    }
        
    /**
     * 
     *   @description    :   Updating Number Of locations in Account
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public static void listOnWhile() {
        List<Account> updateAccountsRecords = [SELECT Id, Name, NumberofLocations__c FROM Account];
        integer i = 1;
        
        while (i<5) {
            updateAccountsRecords[i].NumberofLocations__c = 2;
            System.debug(' Updated Number Of Locations ' + updateAccountsRecords[i].NumberofLocations__c);
            i++;
        }
        
        
    }

    /**
     * 
     *   @description    :   Example of While loop
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void apexWhileLoop() {
        Integer count = 1;

        while (count < 11) {
            System.debug(count);
            count++ ;
        }
    }

    /**
     * 
     *   @description    :   Example of For loop
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void apexTraditionalForLoop(){
        for (Integer i = 0; i < 10; i++) {
            System.debug(i+1);
        }
    }

    /**
     * 
     *   @description    :   Example of List Iteration
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void apexListIteration() {
        Integer[] myInts = new Integer[] {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

        for (Integer i:myInts) {
            System.debug(i);
        }
    }
    
    /**
     * 
     *   @description    :   Iteration of loop on a Map
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public static void loopOnMap() {
 		List<Contact> conList = [select Id,Name from Contact LIMIT 5];
		Map<Id,Contact> mapOfContacts = new Map<Id,Contact>();
		System.debug('');
		for(Contact con : conList){
    		mapOfContacts.put(con.Id,con); 
		}
	system.debug('Map of Contact -> ' + mapOfContacts);
        
        System.debug('-------------***----------------');
        for(Id conId: mapOfContacts.Keyset()){
            System.debug('###'+mapOfContacts.get(conId));
        }
	}

    

    /**
     * 
     *   @description    :   Examples of Apex Conditional (if-else) Statements
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void apexConditionalStatements(){
        Integer place = 2;
        String medalColor;
        if (place == 1) {
            medalColor = 'gold';
        } else if (place == 2) {
            medalColor = 'silver';
        } else if (place == 3) {
            medalColor = 'bronze';
        } else {
            medalColor = null;
        }
        
        System.debug(medalColor);
    }
           

}