/**
*  Description     :  This class is to handle send email and Account Number on Account object
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  07/20/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public with sharing class AccountTriggerHandler {

    /**
     * 
     *   @description    :  This method runs random number generator on account number.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/20/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void updateAccountNumber(List<Account> accountList) {

        //Generating random acoount number for saving and Fd account
        Integer randomNumber = Integer.valueof((Math.random() * 10000));
        for(Account acc : accountList){
            if(acc.Type == 'Savings Account'){
                acc.AccountNumber = 'SB-'+ randomNumber;
            } else if(acc.Type == 'FD Account'){
                acc.AccountNumber = 'FD-'+ randomNumber;
            }
        } 
    }

    /**
     * 
     *   @description    :  This method runs Email sending logic to the user.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/20/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public static void sendAccountEmail(List<Account> accountList){
        
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        
        for(Account acc : accountList){
            
            if(acc.Type != null){
                
                //Creating an email message object
                
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    
                mail.setToAddresses(new String[] {'mrinal.das@fexle.com'});
                mail.setSubject('Account Created Successfully');
                mail.setHtmlBody('Dear, ' + acc.Name + ' your ' + acc.Type + ' Account has been created Successfully <br> Account Number: ' + acc.AccountNumber);
                emailList.add(mail);
            }
        }
        
        //Email function to send mail
        
        Messaging.SendEmail(emailList);
    }
}