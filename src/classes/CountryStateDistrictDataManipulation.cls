/**
*  Description     :  This Class Used to fill Map Data Dynamically from Country, State and Districts. 
*                     Aggregate Functions used to query and update total number of district and states on Country Object.
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  07/13/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public with sharing class CountryStateDistrictDataManipulation {
    
    // Global Map
    Map<String,Map<String,List<String>>> mapOfCountryWithStateAndDistrict = new Map<String,Map<String,List<String>>>();
    List<District__c> listOfdistrict = [SELECT Name, State_Name__r.Name, State_Name__r.Country_Name__r.Name FROM District__c];
    
        public CountryStateDistrictDataManipulation(){
        
        // List to Update Feilds
        List<State__c> StatesRollUpToUpdate = new List<State__c>();
        List<Country__c> countrytRollUpToUpdate = new List<Country__c>();
        
        // Aggregate function Query on District
        AggregateResult[] districtAggregateResultForState = [SELECT Count(Id) Total_District, State_Name__c FROM District__c GROUP BY State_Name__c];
        for(AggregateResult ar : districtAggregateResultForState){
            State__c state = new State__c();
    		state.Id = (Id)ar.get('State_Name__c');
    		state.Total_Number_Of_Districts__c = (Integer)ar.get('Total_District');
    		StatesRollUpToUpdate.add(state);
        }
        
        // Updating Total Number of Districts in State
        System.debug('listOfStatesToUpdate ->' + StatesRollUpToUpdate);
        if(StatesRollUpToUpdate.size() > 0){
            update StatesRollUpToUpdate;
        }
        
        // Aggregate function Query on State
        AggregateResult[] stateAggregateResultForCountry= [SELECT Count(Id) total_State, Sum(Total_Number_Of_Districts__c)sumOfTotalDistricts,Country_Name__c
                                                          FROM State__c GROUP BY Country_Name__c];
        for(AggregateResult ar : stateAggregateResultForCountry){
            Country__c country = new Country__c();
            country.Id = (Id)ar.get('Country_Name__c');
            country.Total_Number_Of_States__c = (Integer)ar.get('total_State');
            country.Total_Number_Of_Districts__c = (Decimal)ar.get('sumOfTotalDistricts');
            countrytRollUpToUpdate.add(country);
        }
        
        // Updating total Number Of District and States in Country
        System.debug('listOfCountriesToUpdate -> ' + countrytRollUpToUpdate);
        if(countrytRollUpToUpdate.size()>0){
            update countrytRollUpToUpdate;
        }

        if(listOfDistrict.size()>0){
            for(District__c district : listOfDistrict){

                //Filling the Global Map
                if(!mapOfCountryWithStateAndDistrict.containsKey(district.State_Name__r.Country_Name__r.Name)){
                    mapOfCountryWithStateAndDistrict.put(district.State_Name__r.Country_Name__r.Name, new Map<String,List<String>>());
                }
                if(!mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).containsKey(district.state_Name__r.Name)){
                    mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).put(district.State_Name__r.Name, new List<String>());
                }
                if(!mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).get(district.State_Name__r.Name).contains(district.Name)){
                    mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).get(district.State_Name__r.Name).add(district.Name);
                }
            }
        }

        System.debug('Map -> ' + mapOfCountryWithStateAndDistrict);
        
    }
    
    //Method to Map Districts, States and Countries
    public CountryStateDistrictDataManipulation(String word) {
        
        List<String> listOfCountryStateDistrict = new List<String>();
        if(listOfdistrict.size()> 0){
            
            for(District__c district : listOfDistrict){
                    
                    //Country, State and District starts with a particular Keyword
                    if(district.State_Name__r.Country_Name__r.Name.startsWithIgnoreCase(word)){
                        if(district.State_Name__r.Name.startsWithIgnoreCase(word)){
                            listOfCountryStateDistrict.add(district.State_Name__r.Country_Name__r.Name + '-' + district.State_Name__r.Name + '-' + district.Name);
                        }
                    }
                }
    	    }
        System.debug('List Of Country State and District -> ' + listOfCountryStateDistrict);
    	}


    /**
     * 
     *   @description    :  This method runs JSON Logic on global map.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/14/2022 - Mrinal Das
     *		              
     * 
     **/

    public void countryJSONGenerator(String countryName){
        
        List<Country__c> countries = [SELECT Name, Total_Number_Of_Districts__c, Total_Number_Of_States__c,Country_Code__c, Country_JSON_Data__c
                                        FROM Country__c WHERE Name =: countryName];
        
        if(countries.size() > 0){
            
            List<StateWrapper> stateWrapperObjectList = new List<StateWrapper>();
            for(String state : mapOfCountryWithStateAndDistrict.get(countryName).keySet()){
                StateWrapper stateWrapperObject = new StateWrapper();
                stateWrapperObject.stateName = state;
                
                List<DistrictWrappper> districtWrappperObjectList = new List<DistrictWrappper>();
                for(string district : mapOfCountryWithStateAndDistrict.get(countryName).get(state)){
                    DistrictWrappper districtWrapperObject = new DistrictWrappper();
                    districtWrapperObject.district = district;
                    districtWrappperObjectList.add(districtWrapperObject);
                }
                stateWrapperObject.districts = districtWrappperObjectList;
                stateWrapperObjectList.add(stateWrapperObject);
            }
            
            //Passing value to the objects of Country Wrapper Class
            CountryWrapper countryWrapperObject = new CountryWrapper();
            countryWrapperObject.countryName = countries[0].Name;
            countryWrapperObject.countryCode = countries[0].Country_Code__c;
            countryWrapperObject.totalStates = (Integer)countries[0].Total_Number_Of_States__c;
            countryWrapperObject.totalDistricts = (Integer)countries[0].Total_Number_Of_Districts__c;
            countryWrapperObject.state = stateWrapperObjectList;

            System.debug(countryWrapperObject);
            system.debug(JSON.serialize(countryWrapperObject));
            countries[0].Country_JSON_Data__c = JSON.serialize(countryWrapperObject);
            update countries[0];
        }
        
    }
    

    /**
    *  Description     :  Country Wrapper Class
    *
    *  Created By      :  Mrinal Das
    *
    *  Created Date    :  07/14/2022
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
        public List<StateWrapper> State;
    }

    /**
    *  Description     :  State Wrapper Class
    *
    *  Created By      :  Mrinal Das
    *
    *  Created Date    :  07/14/2022
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
    *  Created Date    :  07/14/2022
    *
    *  Revision Logs   :    V1.0 - Created - Mrinal Das
    *				    
    *
    **/

    public class DistrictWrappper{
        public String district;
    }
}