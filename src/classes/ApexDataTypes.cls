/**
*  Description     :  Class For Practising Apex DataTypes and Variables
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/24/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*			 
*
**/

public with sharing class ApexDataTypes {
    /**
     * 
     *   @description    :   Creating an Object Method and Type-Casting It To Integer
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Mrinal Das
     *		          
     * 
     **/

    public void objectMethod() {
        Object obj = 10;
        Integer i = (Integer)obj;
        System.assertEquals(obj,i);
        System.debug(i);
        
    }

    /**
     * 
     *   @description    :    Cast the object to the ApexDataTypes custom type
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Mrinal Das
     *		          
     * 
     **/
    
    public Static void castObjectToClass(){
        Object obj = new ApexDataTypes();
        ApexDataTypes mc = (ApexDataTypes)obj;
        mc.objectMethod();
    }

    /**
     * 
     *   @description    :   Examples of few Data Types
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Mrinal Das
     *		          
     * 
     **/
    
    public Static void primitiveTypes() {
        Boolean isWinner = true;
        Double point = 3.14159;
        ID id='00300000003T2PGAA0';
        Integer num = 1;
        Long num2 = 21475698452L;
        String str = 'The quick brown fox jumped over the lazy dog.';
    }

    /**
     * 
     *   @description    :  Practising Primitive Data Types
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Mrinal Das
     *		          
     * 
     **/
    
    //Date Class
    public Static void addingDates(){
        date myDate = date.newInstance(1990, 11, 21);
        
        //Adding Days
    	date newDays = myDate.addDays(2);
        System.debug('Adding Two Days From (1990, 11, 17)' + newDays);
        
        //adding Months
        date newMonths = myDate.addMonths(3);
        date expectedDate = date.newInstance(1991, 2, 21);
        system.assertEquals(expectedDate, newMonths);
        System.debug('Adding Three Months From (1990, 11, 17)' + newMonths);
        
        //adding Years
        date newYears = myDate.addYears(2);
        System.debug('Adding Three Months From (1990, 11, 17)' + newYears);
        
        //check day
        Integer day = myDate.day();
        system.assertEquals(21,day);
        system.debug(day);
        
        //valueOf(stringDate)
        string year = '2008';
        string month = '10';
        string days = '5';
        string hour = '12';
        string minute = '20';
        string second = '20';
        string stringDate = year + '-' + month
         + '-' + days + ' ' + hour + ':' + 
        minute + ':' + second;
        
        Date myDates = date.valueOf(stringDate);
        system.debug(myDates);
        
    }

    /**
     * 
     *   @description    :    Datetime Methods
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Mrinal Das
     *		          
     * 
     **/
    
    public Static void dateTimeMethod(){
        //addDays
        Datetime myDateTime = Datetime.newInstance(1960, 2, 17);
        Datetime newDateTime = myDateTime.addDays(2);
        Datetime expectedDateTime = Datetime.newInstance(1960, 2, 19);
        System.assertEquals(expectedDateTime, newDateTime);
    }

    /**
     * 
     *   @description    :   Different String Methods
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Mrinal Das
     *		          
     * 
     **/

    public Static void stringMethod() {
        String str = 'Hello Maximillian';
        String str1 = str.abbreviate(8);
        String str2 = str.abbreviate(9,6);
        String str3 = str.Capitalize();
        System.assertEquals('Hello...', str1);
        System.assertEquals(8, str1.length());
        
        System.debug(str1);
        System.debug(str2);
        System.debug(str3);

        //codePointAt(index)
        String str4 = '\u03A9 is Ω (Omega), and \uD835\uDD0A ' + 
                    ' is Fraktur Capital G.';
        System.assertEquals(937, str4.codePointAt(0));
        System.assertEquals(120074, str4.codePointAt(20));
        // Escaped or unescaped forms of the same character have the same code point
        System.assertEquals(str4.codePointAt(0), str4.codePointAt(5));
        
        System.debug(str4);
    }
    
    static final Integer PRIVATE_INT_CONST = 200; // Using Static Keywords
    static final Integer PRIVATE_INT_CONST2;

    /**
     * 
     *   @description    :   Example of Apex Consstant
     *
     *   @args           :   
     *
     *   @return         :   Integer
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Mrinal Das
     *		          
     * 
     **/
    
    public Static Integer apexConstants(){        
        return 2+7;
    }
    
    static {
        PRIVATE_INT_CONST2 = apexConstants();
        System.debug(PRIVATE_INT_CONST2);
    }
}