/**
*  Description     :   Class for practising Super KeyWord by declaring a virtual class and then overriding it to a subclass. 
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/29/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				      
*
**/

public virtual class SuperClass {
    public string mySalutaion;
    public String myFirstName;
    public String myLastName;

    public SuperClass() {

        mySalutaion = 'Mr.';
        myFirstName = 'Mrinal';
        myLastName = 'Das';
    }

    public SuperClass(String salutation, string firstName, String lastName) {
        mySalutaion = salutation;
        myFirstName = firstName;
        myLastName = lastName;
    }

    /**
     * 
     *   @description    :   Method to Print salutation and lastname
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/29/2022 - Mrinal Das
     *		              
     * 
     **/

    public virtual void printName() {
        system.debug('My Name is ' + mySalutaion + myLastName);
    }

    /**
     * 
     *   @description    :   Method to return first name
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/29/2022 - Mrinal Das
     *		              
     * 
     **/

    public virtual String getFirstName() {
        return myFirstName;
    }
}