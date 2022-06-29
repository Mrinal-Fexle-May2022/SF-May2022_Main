/**
*  Description     :   This Class Implements PurchaseOrder Interface to Provide discount to Customers
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/29/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				      
*
**/
public class CustomerPurchaseOrder implements PurchaseOrder {

    /**
     * 
     *   @description    :   Method to Provide Discount to Customers
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

        return .05; //Flat 5% discount
    }
}