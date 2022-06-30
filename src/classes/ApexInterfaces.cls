public with sharing class ApexInterfaces {
    
    /**
    *  Description     :   An interface that defines what a purchase order looks like in general
    *
    *  Created By      :  Mrinal Das
    *
    *  Created Date    :  06/29/2022
    *
    *  Revision Logs   :    V1.0 - Created - Mrinal Das
    *				      
    *
    **/

    public interface PurchaseOrder {
        /**
         * 
         *   @description    :   Method of Interface to Provide a Discount
         *
         *   @args           :   
         *
         *   @return         :   void
         *
         *   @revision Log   :   V1.1 - Created  - 06/29/2022 - Mrinal Das
         *		              
        * 
        **/

        Double discount();
        
        
    }   

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
    class EmployeePurchaseOrder implements PurchaseOrder{
        
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
    class CustomerPurchaseOrder implements PurchaseOrder {

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

        public void ProcessPurchaseOrder() {

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
    
}