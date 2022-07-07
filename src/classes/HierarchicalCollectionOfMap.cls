/**
*  Description     :  This Class shows mapoflist type hierarchy to map out country code with country and country with state and state with list of districts
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  07/04/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public with sharing class HierarchicalCollectionOfMap {
    
    //Heirarchical Map
     Map<String, Map<String, Map<String, List<String>>>> mapOfCountryCodeWithCountryWithStateAndDistrict = new Map<String, Map<String, Map<String, List<String>>>>();
    
    public HierarchicalCollectionOfMap() {
        //List Of District Rajasthan
        List<String> listOfDistrictRajasthan = new list<String>();
        listOfDistrictRajasthan.add('Ajmer');
        listOfDistrictRajasthan.add('Jaipur');
        listOfDistrictRajasthan.add('Udaipur');
        
        //List Of District Karnataka
        List<String> listOfDistrictKarnataka = new list<String>();
        listOfDistrictKarnataka.add('BgalKot');
        listOfDistrictKarnataka.add('Ballari');
        listOfDistrictKarnataka.add('Belagavi');
        
        //List Of District San Francisco
        List<String> listOfDistrictSanFrancisco = new list<String>();
        listOfDistrictSanFrancisco.add('Richmond');
        listOfDistrictSanFrancisco.add('SunSet');
        listOfDistrictSanFrancisco.add('Upper Market');

        //List Of District Sweden-Scania
        List<String> listOfDistrictScania = new list<String>();
        listOfDistrictScania.add('Skogome');
        listOfDistrictScania.add('Stampen');
        listOfDistrictScania.add('Sanna');


        
        //Map of State with District list
        Map<String, List<String>> mapOfDistrictWithListIndia = new Map<String, List<String>>();
        mapOfDistrictWithListIndia.put('Rajasthan', listOfDistrictRajasthan);
        mapOfDistrictWithListIndia.put('Karnataka', listOfDistrictKarnataka);

        Map<String, List<String>> mapOfDistrictWithListUS = new Map<String, List<String>>();
        mapOfDistrictWithListUS.put('San Francisco', listOfDistrictSanFrancisco);
        
        Map<String, List<String>> mapOfDistrictWithListSweden = new Map<String, List<String>>();
        mapOfDistrictWithListSweden.put('Scania', listOfDistrictScania);

        //Map of Country with State
        Map<String, Map<String, List<String>>> mapOfIndiaWithState = new Map<String, Map<String, List<String>>>();
        mapOfIndiaWithState.put('India', mapOfDistrictWithListIndia);
        Map<String, Map<String, List<String>>> mapOfUSWithState = new Map<String, Map<String, List<String>>>();
        mapOfUSWithState.put('US', mapOfDistrictWithListUS);
        Map<String, Map<String, List<String>>> mapOfSwedenWithState = new Map<String, Map<String, List<String>>>();
        mapOfSwedenWithState.put('Sweden', mapOfDistrictWithListSweden);

        //Map of Country with country code
        mapOfCountryCodeWithCountryWithStateAndDistrict.put('+91', mapOfIndiaWithState);
        mapOfCountryCodeWithCountryWithStateAndDistrict.put('+1', mapOfUSWithState);
        mapOfCountryCodeWithCountryWithStateAndDistrict.put('+46', mapOfSwedenWithState);
        
        for (String key: mapOfCountryCodeWithCountryWithStateAndDistrict.keySet()){
            //System.debug(mapOfCountryCodeWithCountryWithStateAndDistrict);
            System.debug(key + ' => ' + mapOfCountryCodeWithCountryWithStateAndDistrict.get(key));
        }
        
        
    }
    
    /**
     * 
     *   @description    :   Method to Process data to print the length of district more than 7 and country, state and district starts with s. 
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/04/2022 - Mrinal Das
     *		              
     * 
     **/

    public void processMapData(){

        //Searching District which length is more or equal to some number
        
        System.debug('====District which length is more or equal 7====');

        for (String countryCode: mapOfCountryCodeWithCountryWithStateAndDistrict.keySet()) {
            for(String country: mapOfCountryCodeWithCountryWithStateAndDistrict.get(countryCode).keySet()){
                for(String state:mapOfCountryCodeWithCountryWithStateAndDistrict.get(countryCode).get(country).keySet()){
                    for(String district: mapOfCountryCodeWithCountryWithStateAndDistrict.get(countryCode).get(country).get(state)){
                        if (district.length() >= 7) {
                            System.debug(countryCode + '=>' + country + '=>' + state + '=>' + district);
                        }
                    }
                }
            }
        }

        //searching combination of Country, state and districts where it starts with 's'
        
        System.debug('====Country, state and districts where it starts with s====');

        for(String countryCode: mapOfCountryCodeWithCountryWithStateAndDistrict.keySet()){
            for(String country: mapOfCountryCodeWithCountryWithStateAndDistrict.get(countryCode).keySet()){
                if (country.startsWithIgnoreCase('S')){
                    for(String state: mapOfCountryCodeWithCountryWithStateAndDistrict.get(countryCode).get(country).keySet()){
                        if(state.startsWithIgnoreCase('S')){
                            for(String district: mapOfCountryCodeWithCountryWithStateAndDistrict.get(countryCode).get(country).get(state)){
                                if(district.startsWithIgnoreCase('S')){
                                    System.debug(countryCode + '=>' + country + '=>' + state + '=>' + district);
                                }
                            }
                        }
                    }
                }
            }
        }
    }  
   
}