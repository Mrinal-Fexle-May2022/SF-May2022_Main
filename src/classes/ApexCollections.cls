/**
*  Description     :  Class for Practising Apex Collections
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/24/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				   
*
**/

public with sharing class ApexCollections {
    
    /**
     * 
     *   @description    :   practising of declaring a list, acessing elements from a list and adding value to One dimensional list
     *
     *   @args           :   
     *
     *   @return         :   Void
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Mrinal Das
     *		          
     * 
     **/

    public static void listInApex(){
        //Create an empty list of String
        List<String> my_list = new List<String>();
        // Create a nested list
        List<List<Set<Integer>>> my_list_2 = new List<List<Set<Integer>>>();
        
        //To access elements in a list, use the List methods provided by Apex
        List<Integer> myList = new List<Integer>(); // Define a new list
        mylist.add(47);    // Adds a second element of value 47 to the end of the list
        Integer i = myList.get(0); // Retrieves the element at index 0
        myList.set(0, 1);   // Adds the integer 1 to the list at index 0
        myList.clear();   // Removes all elements from the list
        
        system.debug(i);
        //Using Array Notation for One Dimentional Array
        List<String> colors = new String[1];
        colors[0] = 'Green';
        System.debug(colors);
    }

    /**
     * 
     *   @description    :   Practicing Set in Apex. Defining a set, adding elements to a set and removing elements from a set
     *
     *   @args           :   
     *
     *   @return         :   Void
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Mrinal Das
     *		          
     * 
     **/
    
    public static void setInApex(){
        //Define a New Set with Two Hardcoded Elements
        Set<String> myStringSet = new Set<String>{'New York', 'Paris'};
        
        // Define a new set
		Set<Integer> mySet = new Set<Integer>();
		// Add two elements to the set
		mySet.add(1);
		mySet.add(3);
		// Assert that the set contains the integer value we added
		System.assert(mySet.contains(1)); 
		// Remove the integer value from the set
		mySet.remove(3);
        System.debug(mySet);
        
    }

    /**
     * 
     *   @description    :   Practising Maps in Apex 
     *
     *   @args           :   
     *
     *   @return         :   Void
     *
     *   @revision Log   :   V1.1 - Created  - 06/24/2022 - Mrinal Das
     *		          
     * 
     **/
    
    public static void mapInApex(){
        Map<Integer, String> m = new Map<Integer, String>();
        m.put(1, 'First Entry');
        m.put(2, 'Second Entry');
        System.assert(m.containskey(1));
        String value = m.get(2);
        System.assertEquals('Second Entry', value);
        Set<Integer> s = m.keySet(); 
        System.debug('Keys of the value:::' + s);
        System.debug(m);
    }
}