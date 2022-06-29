/**
*  Description     :  This Class is for Practising Apex Classes, Methods, Constructors and its Implementation
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/27/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public with sharing class ApexClassesAssignment13 {

    /**
     * 
     *   @description    :   Passing Primitive Data Type Arguments
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void debugStatusMessage() {
        String msg = 'Original Value';
        processString(msg);

        System.assertEquals(msg, 'Original Value');
        System.debug(msg);
    }

    public static void processString(String str) {
        str = 'Modified Value';
    
    }

    /**
     * 
     *   @description    :   Passing Non-Primitive Data Type Arguments
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    public static void createTemperatureHistory() {
        List<Integer> fillMe = new List<Integer>();
        reference(fillMe);
        //The list is modified and contails five items
        System.assertEquals(fillMe.size(),6);
        System.debug(fillMe);

        List<Integer> createMe = new List<Integer>();
        createMe=referenceNew(createMe);
        // The list is modified after passing the reference value
        System.assertEquals(createMe.size(),5);
        System.debug(createMe);
    }

    public static void reference(List<Integer> listOfTemps) {
        //Add rounded temperaturea for the last five days
        listOfTemps.add(70);
        listOfTemps.add(68);
        listOfTemps.add(52);
        listOfTemps.add(75);
        listOfTemps.add(80);
        listOfTemps.add(82);
    }

    public static List<Integer> referenceNew(List<Integer> listOfTemps2) {
        listOfTemps2 = new List<Integer>{55, 59, 62, 60, 63};
        return listOfTemps2;
    }

    /**
     * 
     *   @description    :   example of passing a Constructor with arguments and without arguments
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    //Constructor
    private static final Integer DEFAULT_SIZE = 10;

    Integer size;

    //Constructor with no arguments
    public ApexClassesAssignment13() {
        this(DEFAULT_SIZE);
    }

    // Constructor with one argument
    public ApexClassesAssignment13(Integer ObjectSize) {
        size = ObjectSize;
    }
    

}