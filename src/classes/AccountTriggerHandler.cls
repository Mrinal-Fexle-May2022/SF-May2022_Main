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
                    
                mail.setToAddresses(new String[] {acc.Email__c});
                mail.setSubject('Account Created Successfully');
                mail.setHtmlBody('Dear, ' + acc.Name + ' your ' + acc.Type + ' Account has been created Successfully <br> Account Number: ' + acc.AccountNumber
                                + '<br> IFSC CODE: ' + acc.IFSC_Code__c + '<br> Phone: ' + acc.Phone);
                emailList.add(mail);
            } else {
                acc.addError('Type Is Not Selected');
            }
        } 
        
        //Email function to send mail
        
        if(emailList.size()>0){

            Messaging.SendEmail(emailList);
        }
    }
    
    /**
     * 
     *   @description    :  This method Handle account to stop from updating accountnumber.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/20/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public static void accountNumberUpdateError(List<Account> accList, Map<Id, Account>oldMap){
        for(Account acc: accList){
            if(acc.AccountNumber != oldMap.get(acc.Id).AccountNumber){
                acc.AccountNumber.addError('Account Number Cannot be changed Once Set');
            }
        }
    }
    
    /**
     * 
     *   @description    :  This method handle update email function.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/20/2022 - Mrinal Das
     *		              
     * 
     **/
    public static void UpdateAccountEmail(List<Account> updatedList, Map<Id, Account>oldMap){
        
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        
        for(Account acc: updatedList){
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            mail.setToAddresses(new String[] {acc.Email__c});
            mail.setSubject('Account Updated Successfully');
            
            // Send Mail If Email Address is updated
            if(acc.Email__c != oldMap.get(acc.Id).Email__c){
                mail.setHtmlBody('Dear, ' + acc.Name + ' your ' + acc.Type + ' Email Address has been Successfully Updated <br> Account Number: ' + acc.AccountNumber
                                + '<br> IFSC CODE: ' + acc.IFSC_Code__c + '<br> Phone: ' + acc.Phone);
                emailList.add(mail);
            }
            
            // Send Mail if Phone Number is Updated
            if(acc.Phone != oldMap.get(acc.Id).Phone){
                mail.setHtmlBody('Dear, ' + acc.Name + ' your ' + acc.Type + ' Phone Number has been Successfully Updated <br> Phone: ' + acc.Phone
                                + '<br> IFSC CODE: ' + acc.IFSC_Code__c + '<br> Account Number: ' + acc.AccountNumber);
                emailList.add(mail);
            }
            
            //Send Mail if Account Type is Updated
            if(acc.Type != oldMap.get(acc.Id).Type){
                mail.setHtmlBody('Dear, ' + acc.Name + ' your Account Type has Been Successfully updated to: ' + acc.Type + '<br> Phone: ' + acc.Phone
                                + '<br> IFSC CODE: ' + acc.IFSC_Code__c + '<br> Account Number: ' + acc.AccountNumber);
                emailList.add(mail);
            }
            
            
        }
        
        //Email function to send mail
        
        if(emailList.size()>0){

            Messaging.SendEmail(emailList);
        }
    }
}