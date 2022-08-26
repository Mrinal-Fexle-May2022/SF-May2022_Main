/**
*  Description     :  This Class Handle Country District Trigger
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  08/15/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public with sharing class DistrictTriggerHandler {

    /**
     * 
     *   @description    :  This method Handles Updating the Number of District in State and Country Object
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 08/16/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public static void updateNumberOfDistrict(List<District__c>districtList, List<District__c>districtOldList){
        //set of State Id
        set<Id> distSet = new Set<Id>();
        if(districtList != null){    				//new District List
            for(District__c dist: districtList){
                distSet.add(dist.State_Name__c);
        	}
        }
        if(districtOldList != null){				//old District List
            for(District__c distOld : districtOldList){
                distSet.add(distold.State_Name__c);
            }
        }
        
        //Map of State Where Related District Id matches. 
        Map<Id, State__c> stateMap = new Map<Id, State__c>([SELECT Id, Name, Total_Number_Of_Districts__c, Country_Name__c FROM State__c WHERE Id IN: distSet]);
        set<Id> countrySet = new Set<Id>();
        for(State__c stateIds : stateMap.values()){
            countrySet.add(stateIds.Country_Name__c);
        }
        
        //Map of Country
        Map<Id, Country__c> countryMap = new Map<Id, Country__c>([SELECT Id, Name, Total_Number_Of_Districts__c FROM Country__c WHERE Id IN: countrySet]);
        
        //Aggregate Function Query on district
        AggregateResult[] districtAggregateResultForState = [SELECT Count(Id) Total_District, State_Name__c FROM District__c GROUP BY State_Name__c];
        
        for(AggregateResult ar : districtAggregateResultForState){
            Id stateId  = (Id)ar.get('State_Name__c');
            
            //If stateMap contains same state Id
            if(stateMap.containsKey(stateId)){
                stateMap.get(stateId).Id  = stateId;
                stateMap.get(stateId).Total_Number_Of_Districts__c = (Integer)ar.get('Total_District');
            }
        }

        if(stateMap.size() > 0){
            update stateMap.values();
        }
        
        //Aggeregate Funtion Query on State
        AggregateResult[] stateAggregateResultForCountry= [SELECT Count(Id) total_State, Sum(Total_Number_Of_Districts__c)sumOfTotalDistricts, Country_Name__c
                                                          FROM State__c GROUP BY Country_Name__c]; 
        
        for(AggregateResult ar: stateAggregateResultForCountry){
            Id countryId = (Id)ar.get('Country_Name__c');
            
            // If countrymap contains same country Id
            if(countryMap.containsKey(countryId)){
                countryMap.get(countryId).Id = countryId;
                countryMap.get(countryId).Total_Number_Of_Districts__c = (Decimal)ar.get('sumOfTotalDistricts');
            }
            
        }
        
        //Update Map
        if(countryMap.size()>0){
            update countryMap.values();
        }
    }
    
     /**
     * 
     *   @description    :  Generate JSON feild while updating State or District Object.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 08/16/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public static void countryJSONGenerator(List<District__c>districtList, List<District__c>districtOldList){
        //set<Id> StateIdSet = new Set<Id>();
        set<Id> countryIdSet = new Set<Id>();
        if(districtList != null){
            for(District__c dist: districtList){
                //StateIdSet.add(dist.State_Name__c);
                countryIdSet.add(dist.State_Name__r.Country_Name__c);
        	}
        }
        if(districtOldList != null){
            for(District__c distOld : districtOldList){
                //StateIdSet.add(distold.State_Name__c);
                countryIdSet.add(distOld.State_Name__r.Country_Name__c);
            }
        }
        
        // Map of country, states and Districts to fill Country JSON Data
        
        Map<Id, Country__c> countries = new Map<Id, Country__c>([SELECT Id, Name, Country_Code__c, Total_Number_Of_States__c, Total_Number_Of_Districts__c, Country_JSON_Data__c 
                                                                 FROM Country__c WHERE Id IN: countryIdSet]);
        Map<Id, State__c> States = new Map<Id, State__c>([SELECT Id, Name, Total_Number_Of_Districts__c, Country_Name__c 
                                                           FROM State__c WHERE Country_Name__c IN: CountryIdSet]);
        Map<Id, District__c> Districts = new Map<Id, District__c>([SELECT Id, Name, State_Name__c, State_Name__r.Country_Name__c 
                                                                     FROM District__c  WHERE State_Name__r.Country_Name__c IN: countryIdSet]);
        
        if(countries.size() > 0){
            //State Wrapper Object
            List<StateWrapper> stateWrapperObjectList = new List<StateWrapper>();
            
            for(Country__c country : countries.values()){
                //Passing value to the objects of Country Wrapper Class
                CountryWrapper countryWrapperObject = new CountryWrapper();
                countryWrapperObject.countryName = country.Name;
                countryWrapperObject.countryCode = country.Country_Code__c;
                countryWrapperObject.totalStates = (Integer)country.Total_Number_Of_States__c;
                countryWrapperObject.totalDistricts = (Integer)country.Total_Number_Of_Districts__c;
                countryWrapperObject.States = stateWrapperObjectList;
            	for(State__c state : States.values()){
                    if(state.Country_Name__c == country.Id){
                		StateWrapper stateWrapperObject = new StateWrapper();
                		stateWrapperObject.stateName = state.Name;
                        
                        //District Wrapper object
                		List<DistrictWrappper> districtWrappperObjectList = new List<DistrictWrappper>();
                		for(District__c dist : Districts.values()){
                    		if(dist.State_Name__c == state.Id){
                    			DistrictWrappper districtWrapperObject = new DistrictWrappper();
                				districtWrapperObject.district = dist.Name;
                				districtWrappperObjectList.add(districtWrapperObject);
                    		}
            			}
                		stateWrapperObject.districts = districtWrappperObjectList;
                		stateWrapperObjectList.add(stateWrapperObject);
                    }
                }
                
                // Serializing JSON Data
                country.Country_JSON_Data__c = JSON.serialize(countryWrapperObject);
            }
            
            //Update Country
            update countries.values();
            
        }
    }
    
    /**
    *  Description     :  Country Wrapper Class
    *
    *  Created By      :  Mrinal Das
    *
    *  Created Date    :  08/07/2022
    *
    *  Revision Logs   :    V1.0 - Created - Mrinal Das
    *				    
    *
    **/

    public class CountryWrapper{
        public String countryName;
        public String countryCode;
        public Integer totalStates;
        public Integer totalDistricts;
        public List<StateWrapper> States;
    }

    /**
    *  Description     :  State Wrapper Class
    *
    *  Created By      :  Mrinal Das
    *
    *  Created Date    :  08/07/2022
    *
    *  Revision Logs   :    V1.0 - Created - Mrinal Das
    *				    
    *
    **/

    public class StateWrapper{
        public String stateName;
        public List<DistrictWrappper> districts;
    }

    /**
    *  Description     :  District Wrapper Class
    *
    *  Created By      :  Mrinal Das
    *
    *  Created Date    :  08/07/2022
    *
    *  Revision Logs   :    V1.0 - Created - Mrinal Das
    *				    
    *
    **/

    public class DistrictWrappper{
        public String district;
    }
}