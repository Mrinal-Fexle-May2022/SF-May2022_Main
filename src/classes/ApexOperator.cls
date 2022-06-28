/**
*  Description     :  Class for Checking Different Apex Operators
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/24/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				   
*
**/

public with sharing class ApexOperator {

    /**
     * 
     *   @description    :   Methods Apex Expressions
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Mrinal Das
     *		            
     * 
     **/
        
        public static void apexExpression(){
            Account[] acc = [SELECT Id, Name FROM Account WHERE Name ='Acme'];
            Integer findLastName = [SELECT COUNT() FROM Contact WHERE LastName ='Weissman'];
            List<List<SObject>> searchList = [FIND 'map*' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
        }

     /**
     * 
     *   @description    :   Examples of Apex Expression Operator
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Mrinal Das
     *		            
     * 
     **/

        public static void apexExpressionOperators(){
            Integer num1 = 8, num2 = 10;
            boolean x = true;

            System.debug(num1 = num2);
            System.debug(num1 += num2);
            System.debug(num1 *= num2);
            System.debug(num1 += num2);
            System.debug(num1 -= num2);
            System.debug(num1 |= num2);
            System.debug(num1 &= num2);
            System.debug(num1 <<= num2);
            System.debug(num1 >>= num2);
            System.debug(num1 >>>= num2);
            System.debug(x ? num2 : num1);
        }

    /**
     * 
     *   @description    :   Using Safe Navigation operator for Checking a Null Statements
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Mrinal Das
     *		            
     * 
     **/

        public static void apexSafeNavigationOperator(){
            // code using the safe navigation operator
             String str1 = Null;
             String str2 = 'abc';
             System.debug(str1==Null?str2:str1);

             Contact con = new Contact();
             con.LastName='Das';
             insert con;
             System.debug([Select Id, LastName From Contact Where Id=:con.Id]?.LastName);

        }

    /**
     * 
     *   @description    :   Computing The Amount Of Milliseconds In a Year By Multiplying Long Numeric Values.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Mrinal Das
     *		            
     * 
     **/

        public static void multiplyingLongNumericValue(){
            Long MillsPerYear = 365L * 24L * 60L * 1000L;
            Long ExpectedValue = 31536000000L;
            System.assertEquals(MillsPerYear, ExpectedValue);
        }


}