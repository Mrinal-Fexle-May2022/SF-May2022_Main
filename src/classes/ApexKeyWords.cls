/**
*  Description     :  Class to practice Apex keyWords
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/30/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				      
*
**/

public with sharing class ApexKeyWords {
   
    final Integer speedLimit = 40;

    /*public void run(){
        speedlimit = 100;
    }*/
         /**
         * 
         *   @description    :   Method to try final keyword
         *
         *   @args           :   
         *
         *   @return         :   void
         *
         *   @revision Log   :   V1.1 - Created  - 06/30/2022 - Mrinal Das
         *		              
        * 
        **/
    
    Public void apexfinalKeyWord(){
        ApexKeyWords bike = new ApexKeyWords();
        // bike.run();
    }

    public static void apexIntanceOfKeyword() {
        sObject instance = new Account();

        if(instance instanceOf Account) {
            Account acc = (Account)instance;
        } else if(instance instanceOf Contact) {
            Contact con = (Contact)instance;
        }
        
        //instanceof returns false if the left operand is a null object
        Object o = null;
		Boolean result = o instanceof Account;
		System.assertEquals(false, result);
    }

    String str;

    //The initialization code populates the variable using the this keyword
    
    {
        this.str = 'TestString';
    }
    public ApexKeyWords(string s2) {

    }

    // Second constructor for the class. It does not require a parameter.
    // This constructor calls the first constructor using the this keyword.

    public ApexKeyWords() {
        this('None') ;
    }
    
    /**
    *  Description     :  Class to practice Apex keyWords
    *
	*  Created By      :  Mrinal Das
	*
	*  Created Date    :  06/30/2022
	*
	*  Revision Logs   :    V1.0 - Created - Mrinal Das
	*				      
	*
	**/

    class Student {
        String name;
        Integer age;
        
         /**
         * 
         *   @description    :   method to print the class variables
         *
         *   @args           :   
         *
         *   @return         :   void
         *
         *   @revision Log   :   V1.1 - Created  - 06/30/2022 - Mrinal Das
         *		              
        * 
        **/

        public void printInfo(){
            system.debug(this.name);
            system.debug(this.age);
        }

        public Student(String name, Integer age) {
            this.name = name;
            this.age = age;
        }
    }
    
         /**
         * 
         *   @description    :   Method to make object of student class and call printinfo function. 
         *
         *   @args           :   
         *
         *   @return         :   void
         *
         *   @revision Log   :   V1.1 - Created  - 06/30/2022 - Mrinal Das
         *		              
        * 
        **/

    public void makeStudentObject() {
        Student student1 = new Student('Mrinal', 24);
        student1.printInfo();
    }
}