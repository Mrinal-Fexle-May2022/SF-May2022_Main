/**
*  Description     :   This Class is to display the discounts for purchase order
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/29/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				      
*
**/

public class ProcessPurchaseOrder {
    /**
     * 
     *   @description    :   Method to assign the instance of the Purchaseorder classes
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/29/2022 - Mrinal Das
     *		              
     * 
     **/

    public ProcessPurchaseOrder() {

        PurchaseOrder order1 = new CustomerPurchaseOrder();
        PurchaseOrder order2 = new EmployeePurchaseOrder();

        //Customer Order
        processOrder(order1);
        //Employee Order
        processOrder(order2);

    }

    /**
     * 
     *   @description    :   Method to display the discount
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/29/2022 - Mrinal Das
     *		              
     * 
     **/

    public void processOrder(PurchaseOrder order){
        System.debug('check discount :::'+ order.discount());
    }
}