/**
*  Description     :   This Class is to override the SuperClass. 
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/29/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				      
*
**/
public class SubClass extends SuperClass {

    /**
     * 
     *   @description    :   Method to ovverride the PrintName method from SuperClass. 
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/29/2022 - Mrinal Das
     *		              
     * 
     **/

    public override void printName() {
        super.printName();
        System.debug('But you can call me' + super.getFirstName());
    }
}