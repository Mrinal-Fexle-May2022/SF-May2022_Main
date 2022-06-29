/**
*  Description     :   This Class Implements PurchaseOrder Interface to Provide discount to Employees
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/29/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				      
*
**/
public class EmployeePurchaseOrder implements PurchaseOrder{
    
    /**
     * 
     *   @description    :   Method to Provide Discount to Employee
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/29/2022 - Mrinal Das
     *		              
     * 
     **/

    public Double discount() {

        return .10; // It's worth it being an employee! 10% discount
    }
}