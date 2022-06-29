/**
*  Description     :   Class for practising InstanceOf KeyWord
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/29/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				      
*
**/

public with sharing class ApexIntanceOfKeyword {

    /**
     * 
     *   @description    :   Method to check Instance of an Object and Typecaste a Variable to it. 
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/29/2022 - Mrinal Das
     *		              
     * 
     **/

    public ApexIntanceOfKeyword() {
        sObject s = new Account();

        if(s instanceOf Account) {
            Account acc = (Account)s;
     } else if(s instanceOf Contact) {
            Contact con = (Contact)s;
        }
    }
}