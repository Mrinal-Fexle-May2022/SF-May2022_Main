/**
*  Description     :  This Class Handle Country State Trigger
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  08/15/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public with sharing class StateTriggerHandler {

     /**
     * 
     *   @description    :  This method Handles Updating the Number of State and District in Country Object
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 08/16/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public static void updateNumberOfState(List<State__c>stateList, List<State__c>stateOldList){
        //Set of Country Id
        set<Id> countrySet = new Set<Id>();
        if(stateList != null){ 						// new State List
        	for(State__c state : stateList){
                countrySet.add(state.Country_Name__c);
        	}
        }
        if(stateOldList != null){ 					// old State List
            for(State__c stateOld : stateOldList){
                countrySet.add(stateOld.Country_Name__c);
            }
        }
        
        Map<Id, Country__c> countryMap = new Map<Id, Country__c>([SELECT Id, Name, Total_Number_Of_States__c, Total_Number_Of_Districts__c FROM Country__c WHERE Id IN: countrySet]);
        
        //Aggeregate Funtion Query on State
        AggregateResult[] stateAggregateResultForCountry= [SELECT Count(Id) total_State, Sum(Total_Number_Of_Districts__c)sumOfTotalDistricts, Country_Name__c
                                                          FROM State__c GROUP BY Country_Name__c]; 
        for(AggregateResult ar : stateAggregateResultForCountry){
            Id countryId = (Id)ar.get('Country_Name__c');
            
            // If countrymap contains same country Id
            if(countryMap.containsKey(countryId)){
                countryMap.get(countryId).Id = countryId;       
                countryMap.get(countryId).Total_Number_Of_States__c = (Decimal)ar.get('total_State');
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
     *   @description    :  Generate JSON feild while updating state object or state feild.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 08/16/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public static void countryJSONGenerator(List<State__c>stateList, List<State__c>stateOldList){
        set<Id> countryIdSet = new Set<Id>();
        if(stateList != null){
            for(State__c state: stateList){
                countryIdSet.add(state.Country_Name__c);
            }
        }
        
        if(stateOldList != null){
            for(State__c stateOld : stateOldList){
                countryIdSet.add(stateOld.Country_Name__c);
            }
        }
        
        Map<Id, Country__c> countries = new Map<Id, Country__c>([SELECT Id, Name, Country_Code__c, Total_Number_Of_States__c, Total_Number_Of_Districts__c, Country_JSON_Data__c 
                                                                 FROM Country__c WHERE Id IN: countryIdSet]);
        Map<Id, State__c> States = new Map<Id, State__c>([SELECT Id, Name, Total_Number_Of_Districts__c, Country_Name__c 
                                                           FROM State__c WHERE Country_Name__c IN: CountryIdSet]);
        Map<Id, District__c> Districts = new Map<Id, District__c>([SELECT Id, Name, State_Name__c, State_Name__r.Country_Name__c 
                                                                     FROM District__c  WHERE State_Name__r.Country_Name__c IN: countryIdSet]);
        
        if(countries.Values().size() > 0){
            for(Country__c country : countries.values()){
                List<StateWrapper> stateWrapperObjectList = new List<StateWrapper>();
                for(State__c state : States.values()){
                    if(state.Country_Name__c == country.Id){
                        StateWrapper stateWrapperObject = new StateWrapper();
                        stateWrapperObject.stateName = state.Name;
                        
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
                
                //Passing value to the objects of Country Wrapper Class
                CountryWrapper countryWrapperObject = new CountryWrapper();
                countryWrapperObject.countryName = country.Name;
                countryWrapperObject.countryCode = country.Country_Code__c;
                countryWrapperObject.totalStates = (Integer)country.Total_Number_Of_States__c;
                countryWrapperObject.totalDistricts = (Integer)country.Total_Number_Of_Districts__c;
                countryWrapperObject.States = stateWrapperObjectList;
                // Serialize JSON Data
                country.Country_JSON_Data__c = JSON.serialize(countryWrapperObject);
            } 
            
            if(countries.size() > 0){
                update countries.values();
            }
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