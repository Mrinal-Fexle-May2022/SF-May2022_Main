/**
*  Description     :   This Class is an example of using 'this' keyword. 
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/29/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				      
*
**/

public with sharing class ThisKeyWord {

    String str;

    //The initialization code populates the variable using the this keyword
    
    {
        this.str = 'TestString';
    }
    public ThisKeyWord(string s2) {

    }

    // Second constructor for the class. It does not require a parameter.
    // This constructor calls the first constructor using the this keyword.

    public ThisKeyWord() {
        this('None') ;
    }
}