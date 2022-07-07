/**
*  Description     :  This class implements apexinterface class
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/30/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				      
*
**/

public with sharing class Fridge implements  ApexInterfacesProductExample {
    private String modelNumber;
    public Fridge(String model){
        modelNumber=model;
        system.debug(model);
    }
    
         /**
         * 
         *   @description    :   Method to return modelnumber
         *
         *   @args           :   
         *
         *   @return         :   void
         *
         *   @revision Log   :   V1.1 - Created  - 06/30/2022 - Mrinal Das
         *		              
        * 
        **/
    
    public String getModelNumber(){
        return modelNumber;
    }
}