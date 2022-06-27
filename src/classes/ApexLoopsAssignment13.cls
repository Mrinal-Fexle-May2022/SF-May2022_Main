/**
*  Description     :  Practicing all types of loops in Apex
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/27/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				     
*
**/

public with sharing class ApexLoopsAssignment13 {

    /**
     * 
     *   @description    :   Example of Do While loop
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void apexDoWhileLoop(){
        Integer count = 1;

        do {
            System.debug(count);
            count++;
        } while (count < 11);

        System.debug(count);
    }

    /**
     * 
     *   @description    :   Example of While loop
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void apexWhileLoop() {
        Integer count = 1;

        while (count < 11) {
            System.debug(count);
            count++ ;
        }
    }

    /**
     * 
     *   @description    :   Example of For loop
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void apexTraditionalForLoop(){
        for (Integer i = 0, j = 0; i < 10; i++) {
            System.debug(i+1);
        }
    }

    /**
     * 
     *   @description    :   Example of List Iteration
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void apexListIteration() {
        Integer[] myInts = new Integer[] {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

        for (Integer i:myInts) {
            System.debug(i);
        }
    }

    /**
     * 
     *   @description    :   Examples of Apex Conditional (if-else) Statements
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void apexConditionalStatements(){
        Integer place = 2;
        String medal_color;
        if (place == 1) {
            medal_color = 'gold';
        } else if (place == 2) {
            medal_color = 'silver';
        } else if (place == 3) {
            medal_color = 'bronze';
        } else {
            medal_color = null;
        }
        
        System.debug(medal_color);
    }

}