/**
*  Description     :  using get, set properties. Apply initialization logic
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/27/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public with sharing class ApexProperties {
    public integer prop{
        get {return prop; }
        set {prop = value; }
    }

    public static Student__c stData{
        get{
            if(stData == null){
                stData = [select id, name from Student__c where name != NULL];
            }
            return stData;
        }

        set{

            stData.Name = stData.Name + DateTime.now();
            system.debug('check stData.Name' + stData.Name);
        }
    }

    /**
     * 
     *   @description    :   AUraEnabled Method
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    @AUraEnabled
	public static Student__c getStData(){
		
		Student__c stLocal;
		
		if(stLocal == null){
			
			stLocal = [select id, name from Student__c where name != NULL];
		}
		
		return stLocal;
	}

    /**
     * 
     *   @description    :   AUraEnabled Method
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/
	
	@AUraEnabled
	public static Student__c getStData1(){
		Student__c stData;
        if(stData == null){
			stData = [select id, name from Student__c where name != NULL];
			
		}
		
		return stData;
	}

/**
*  Description     :  Applying Getter and Setter Method
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/27/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/
    
    class ProcessStudentData{
        public Student__c ProcessStudentData(){
            //Getter method
            Student__c st = ApexProperties.stData;
            return st;
        }
    
        public void saveStudentData(){
            Student__c stu = ProcessStudentData();
            Student__c studentData = stu;
            //Setter Method
            ApexProperties.stData = stu;
        }
    }
}