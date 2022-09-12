/**
*  Description     :  This class get called on LWC with three simple method to print
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  09/02/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public with sharing class ReturnStringToClientSide {
    
    /**
     * 
     *   @description    :   Method 1 to display on client side. 
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 09/02/2022 - Mrinal Das
     *		              
     * 
     **/

    @AuraEnabled
    public static String getTextMethod1(){
        return 'Method- 1';
    }
    
    /**
     * 
     *   @description    :   Method 2 to display on client side. 
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 09/02/2022 - Mrinal Das
     *		              
     * 
     **/

    @AuraEnabled
    public static String getTextMethod2(){
        return 'Method- 2';
    }
    
    /**
     * 
     *   @description    :   Method 3 to display on client side. 
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 09/02/2022 - Mrinal Das
     *		              
     * 
     **/

    @AuraEnabled
    public static String getTextMethod3(){
        return 'Method- 3';
    }
}