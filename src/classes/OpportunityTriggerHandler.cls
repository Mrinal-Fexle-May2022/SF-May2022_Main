/**
*  Description     :  This Class Handle Opportunity Trigger for Inserting and Updating Records
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  07/29/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public with sharing class OpportunityTriggerHandler {
     /**
     * 
     *   @description    :  This method Handle Insert and update of Automobile Objects Records.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/29/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public static void insertAndUpdateAutomobileRecords(List<Opportunity>oppList, Map<Id, Opportunity>oldOppMap){
        
        //Insert Map
        Map<String, SObject> insertRecordMap = new Map<String, SObject>();
        
        //Update Map
        Map<String, SObject> updateRecordMap = new Map<String, SObject>();
        
        //Set of Sensors from automobile tag details
        set<String> sensorSet = new set<String>();
        set<String> hQtagSet = new set<String>();
        
        //Set of account Ids
        Set<Id> accountIds = new Set<Id>();
        
        for(Opportunity opp : oppList){
            
            if((opp.Automobile_Tag_Details_1__c != null || opp.Automobile_Tag_Details_2__c != null || opp.Automobile_Tag_Details_3__c != null)){
                
                String tagDetailsSplit = opp.Automobile_Tag_Details_1__c + '\n' + opp.Automobile_Tag_Details_2__c + '\n' + opp.Automobile_Tag_Details_3__c;
                for(String sensor : tagDetailsSplit.split('\n')){
                    if(sensor.length() > 18){
                        sensor = sensor.substring(0, 18);
                     }
                    sensorSet.add(sensor.trim());
                }
                
                if(opp.Return_To_HQ__c != null){
                	for(String hQSensorTags : opp.Return_To_HQ__c.split('\n')){
                    	if(hQSensorTags.length() > 18){
                        	hQSensorTags = hQSensorTags.substring(0,18);
                    	}
                    	hQtagSet.add(hQSensorTags.trim());
                	}
                }
                
                //For Sending email with account name
                accountIds.add(opp.Shipment_Account__c);
                accountIds.add(opp.Installation_Account__c);
            }
        }
        
        //Map With Account Names
        Map<Id, Account> accountWithNames = new Map<Id, Account>([SELECT Id, Name FROM Account WHERE Id IN: accountIds]);
        
        //Old Maps of Automobile Sensor
        Map<Id, Automobile_Sensor__c> oldAuSensorMap = new Map<Id, Automobile_Sensor__c>([SELECT Id, Name, Account__c, Opportunity__c FROM Automobile_Sensor__c WHERE Name IN: sensorSet]);
        Map<Id, Automobile_Presence_Sensor__c> oldApSensorMap = new Map<Id, Automobile_Presence_Sensor__c>([SELECT Id, Name, Account__c, Opportunity__c FROM Automobile_Presence_Sensor__c  WHERE Name IN: sensorSet]);
        Map<Id, Automobile_TDU__c> oldATDUSensorMap = new Map<Id, Automobile_TDU__c>([SELECT Id, Name, Account__c, Opportunity__c FROM Automobile_TDU__c  WHERE Name IN: sensorSet]);
        Map<Id, Automobile_Tag__c> oldATagSensorMap = new Map<Id, Automobile_Tag__c>([SELECT Id, Name, Account__c, Opportunity__c FROM Automobile_Tag__c  WHERE Name IN: sensorSet]);
        
        //Set of Names from Automobile Sensors
        set<String> auSensorOldSet = new set<String>();
        for(Automobile_Sensor__c ausensor: oldAuSensorMap.values()){
            auSensorOldSet.add(ausensor.Name);
        }
        set<String> apSensorOldSet = new set<String>();
        for(Automobile_Presence_Sensor__c apSensor : oldApSensorMap.values()){
            apSensorOldSet.add(apSensor.Name);
        }
        set<String> aTDUSensorOldSet = new set<String>();
        for(Automobile_TDU__c aTDUSensor : oldATDUSensorMap.values()){
            aTDUSensorOldSet.add(aTDUSensor.Name);
        }
        set<String> aTagSensorOldSet = new set<String>();
        for(Automobile_Tag__c aTagSensor : oldATagSensorMap.values()){
            aTagSensorOldSet.add(aTagSensor.Name);
        }
        
        for(Opportunity opp : oppList){

            if((opp.StageName == 'Shipped To Customer' || opp.StageName == 'Return To HQ' || opp.StageName == 'Return To Customer') && (oldOppMap == null || opp.StageName != oldOppMap.get(opp.Id).StageName)){
                	
                for(String sensorTag : sensorSet){
                    
                    //If Stage Changes to Shipped To Customer in Opportunity   
                    if(opp.StageName == 'Shipped To Customer'){
                        
                        if(sensorTag.startsWith('00:11:CE:00') && !auSensorOldSet.contains(sensorTag)){
                            Automobile_Sensor__c auSensor = new Automobile_Sensor__c();
                            auSensor.Name = sensorTag;
                            auSensor.Opportunity__c = opp.Id;
                            auSensor.Account__c = opp.Installation_Account__c;
							insertRecordMap.put(sensorTag, auSensor);
							System.debug(insertRecordMap);   
                        }
                        if(sensorTag.startsWith('00:11:CE:D') && !apSensorOldSet.contains(sensorTag)){
                            Automobile_Presence_Sensor__c apSensor = new Automobile_Presence_Sensor__c();
                            apSensor.Name = sensorTag;
                            apSensor.Opportunity__c = opp.Id;
                            apSensor.Account__c = opp.Installation_Account__c;
                            insertRecordMap.put(sensorTag, apSensor);
                        }
                        if(sensorTag.startsWith('00:11:CE:E') && !aTDUSensorOldSet.contains(sensorTag)){
                            Automobile_TDU__c aTDUSensor = new Automobile_TDU__c();
                            aTDUSensor.Name = sensorTag;
                            aTDUSensor.Opportunity__c = opp.Id;
                            aTDUSensor.Account__c = opp.Installation_Account__c;
                            insertRecordMap.put(SensorTag, aTDUSensor);
                        }
                        if(sensorTag.substring(1,3).isNumeric() && !aTagSensorOldSet.contains(sensorTag)){
                            Automobile_Tag__c aTagSensor = new Automobile_Tag__c();
                            aTagSensor.Name = sensorTag;
                            aTagSensor.Opportunity__c = opp.Id;
                            aTagSensor.Account__c = opp.Installation_Account__c;
                            insertRecordMap.put(sensorTag, aTagSensor);
                        }
                    }
                    
                    //If Stage Changes to Return To Customer in Opportunity   
                    if(opp.StageName == 'Return To Customer'){
                        
                        if(sensorTag.startsWith('00:11:CE:00')){
                            if(!auSensorOldSet.contains(sensorTag)){
                                Automobile_Sensor__c auSensor = new Automobile_Sensor__c();
                            	auSensor.Name = sensorTag;
                            	auSensor.Opportunity__c = opp.Id;
                            	auSensor.Account__c = opp.Installation_Account__c;
                                insertRecordMap.put(sensorTag, auSensor);
                                System.debug(insertRecordMap);
                            }
                            else if(auSensorOldSet.contains(sensorTag)){
                                for(Automobile_Sensor__c oldAusensor : oldAuSensorMap.values()){
                                    if(oldAusensor.Name == sensorTag &&  oldAuSensor.Opportunity__c == opp.Id){
                                        oldAuSensor.Account__c = opp.Installation_Account__c;
                                        updateRecordMap.put(sensorTag, oldAusensor);
                                        System.debug(updateRecordMap);
                                    }
                                }
                            }
                        }
                        if(sensorTag.startsWith('00:11:CE:D')){
                            if(!apSensorOldSet.contains(sensorTag)){
                                Automobile_Presence_Sensor__c apSensor = new Automobile_Presence_Sensor__c();
                            	apSensor.Name = sensorTag;
                            	apSensor.Opportunity__c = opp.Id;
                            	apSensor.Account__c = opp.Installation_Account__c;
                                insertRecordMap.put(sensorTag, apSensor);
                            }
                            else if(apSensorOldSet.contains(sensorTag)){
                                for(Automobile_Presence_Sensor__c oldApSensor : oldApSensorMap.values()){
                                    if(oldApSensor.Name == sensorTag &&  oldApSensor.Opportunity__c == opp.Id){
                                        oldApSensor.Account__c = opp.Installation_Account__c;
                                        updateRecordMap.put(sensorTag, oldApSensor);
                                    }
                                }
                            }
                        }
                        if(sensorTag.startsWith('00:11:CE:E')){
                            if(!aTDUSensorOldSet.contains(sensorTag)){
                            	Automobile_TDU__c aTDUSensor = new Automobile_TDU__c();
                            	aTDUSensor.Name = sensorTag;
                            	aTDUSensor.Opportunity__c = opp.Id;
                            	aTDUSensor.Account__c = opp.Installation_Account__c;
                                insertRecordMap.put(SensorTag, aTDUSensor);
                            }
                            else if(aTDUSensorOldSet.contains(sensorTag)){
                                for(Automobile_TDU__c oldATDUSensor : oldATDUSensorMap.values()){
                                    if(oldATDUSensor.Name == sensorTag &&  oldATDUSensor.Opportunity__c == opp.Id){
                                        oldATDUSensor.Account__c = opp.Installation_Account__c;
                                        updateRecordMap.put(sensorTag, oldATDUSensor);
                                    }
                                }
                            }
                        }
                        if(sensorTag.substring(1,3).isNumeric()){
                            if(!aTagSensorOldSet.contains(sensorTag)){
                            	Automobile_Tag__c aTagSensor = new Automobile_Tag__c();
                            	aTagSensor.Name = sensorTag;
                            	aTagSensor.Opportunity__c = opp.Id;
                            	aTagSensor.Account__c = opp.Installation_Account__c;
                                insertRecordMap.put(sensorTag, aTagSensor);
                            }
                            else if(aTagSensorOldSet.contains(sensorTag)){
                                for(Automobile_Tag__c oldATagSensor : oldATagSensorMap.values()){
                                    if(oldATagSensor.Name == sensorTag &&  oldATagSensor.Opportunity__c == opp.Id){
                                        oldATagSensor.Account__c = opp.Installation_Account__c;
                                        updateRecordMap.put(sensorTag, oldATagSensor);
                                    }
                                }
                            }
                        }
                    }
                }
                
                // If Stage changes to Return To HQ in Opportunity   
                if(opp.StageName == 'Return To HQ'){
                    for(String hQSensorTags : hQtagSet){
                        if(hQSensorTags.startsWith('00:11:CE:00') && auSensorOldSet.contains(hQSensorTags)){
                            for(Automobile_Sensor__c oldAuSensor : oldAuSensorMap.values()){
                                if(oldAusensor.Name == hQSensorTags &&  oldAuSensor.Opportunity__c == opp.Id){
                                    oldAuSensor.Account__c = opp.Shipment_Account__c;
                                    updateRecordMap.put(hQSensorTags, oldAuSensor);
                                }
                            }
                        }
                        if(hQSensorTags.startsWith('00:11:CE:D') && apSensorOldSet.contains(hQSensorTags)){
                            for(Automobile_Presence_Sensor__c oldApSensor : oldApSensorMap.values()){
                                if(oldApSensor.Name == hQSensorTags && oldApSensor.Opportunity__c == opp.Id){
                                    oldApSensor.Account__c = opp.Shipment_Account__c;
                                    updateRecordMap.put(hQSensorTags, oldApSensor);
                                }
                            }
                        }   
                        if(hQSensorTags.startsWith('00:11:CE:E') && aTDUSensorOldSet.contains(hQSensorTags)){
                            for(Automobile_TDU__c oldATDUSensor : oldATDUSensorMap.values()){
                                if(oldATDUSensor.Name == hQSensorTags && oldATDUSensor.Opportunity__c == opp.Id){
                                    oldATDUSensor.Account__c = opp.Shipment_Account__c;
                                    updateRecordMap.put(hQSensorTags, oldATDUSensor);
                                }
                            }
                        }   
                        if(hQSensorTags.substring(0,3).isNumeric() && aTagSensorOldSet.contains(hQSensorTags)){
                            for(Automobile_Tag__c oldATagSensor : oldATagSensorMap.values()){
                                if(oldATagSensor.Name == hQsensorTags &&  oldATagSensor.Opportunity__c == opp.Id){
                                    oldATagSensor.Account__c = opp.Shipment_Account__c;
                                    updateRecordMap.put(hQSensorTags, oldATagSensor);
                                }
                            }
                        }
                    }
                }
            }
        }
        
        //Insert and Update DML Perform
        if(insertRecordMap.size() > 0){
            insert insertRecordMap.values();
        }
        if(updateRecordMap.size() > 0){
            update updateRecordMap.values();
        }
        
        //Email Send Method values pass on the parameters
        opportunityEmailHandler(oppList, insertRecordMap, updateRecordMap, accountWithNames, hQtagSet);
    }
    
     /**
     * 
     *   @description    :  This method Handle Email Send for each Successful and Unsuccessful records.
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 07/29/2022 - Mrinal Das
     *		              
     * 
     **/
    
    public static void opportunityEmailHandler(List<Opportunity>oppList, Map<String, SObject>insertRecordMap, Map<String, SObject>updateRecordMap, Map<Id, Account> accountWithNames, set<String> hQtagSet){
        
        //Single Email Message email List
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity opp : oppList){
            
        }
        
        for(Opportunity opp : oppList){

            if(opp.StageName == 'Shipped To Customer' || opp.StageName == 'Return To HQ' || opp.StageName == 'Return To Customer'){
                
                String tagDetailsSplit = opp.Automobile_Tag_Details_1__c + '\n' + opp.Automobile_Tag_Details_2__c + '\n' + opp.Automobile_Tag_Details_3__c;
            	set<String> sensorSet = new set<String>();
            	for(String sensor : tagDetailsSplit.split('\n')){
                	sensorSet.add(sensor.trim());
            	}
                
                //functions for sendinge Emails
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            	mail.setToAddresses(new String[] {opp.OwnerId});
            	mail.setSubject(Opp.Name + ' Sensor shipment is completed ' + date.today().format());
                
                //For Successful Email
            	String body = 'Successful<br>';
            	body += '<table style="width:100%" border = "1px solid black"> <tr> <th>Automobile Type</th> <th>Name</th> <th>Message</th></tr>';
                for(String sensorTag : sensorSet){
                    if(sensorTag.length() > 18){
                        sensorTag = sensorTag.substring(0, 18);
                    }
                    if(sensorTag.startsWith('00:11:CE:00')){
                    	if(opp.StageName == 'Shipped To Customer'){
                        	if(insertRecordMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile Sensor</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                        	}
                    	}
                        
                    	else if(opp.StageName == 'Return To HQ'){
                        	if(updateRecordMap.keySet().contains(sensorTag)){
                                for(String hqTag: hQtagSet){
                                    if(hqTag == sensorTag){
                                        body += '<tr><td>AutoMobile Sensor</td><td>' + sensorTag + '</td> </td> Moved Under Shipment Account ' + accountWithNames.get(opp.Shipment_Account__c).Name + '</td></tr>';
                                    }
                                }
                            }
                    	}
                    	else if(opp.StageName == 'Return To Customer'){
                            if(insertRecordMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile Sensor</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                        	}
                            if(updateRecordMap.keySet().contains(sensorTag)){
                                for(String hqTag: hQtagSet){
                                    if(hqTag == sensorTag){
                                        body += '<tr><td>Automobile </td><td>' + sensorTag + '</td> </td> Sensor is moved from Shipment Account to Installation Account ' + accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                                    }
                                }
                            }
                    	}
                	}
                    else if(sensorTag.startsWith('00:11:CE:D')){
                    	if(opp.StageName == 'Shipped To Customer'){
                        	if(insertRecordMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile Presence</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                        	}
                    	}
                    
                    	else if(opp.StageName == 'Return To HQ'){
                        	if(updateRecordMap.keySet().contains(sensorTag)){
                                for(String hqTag: hQtagSet){
                                    if(hqTag == sensorTag){
                                        body += '<tr><td>AutoMobile Presence</td><td>' + sensorTag + '</td> </td> Moved Under Shipment Account ' + accountWithNames.get(opp.Shipment_Account__c).Name + '</td></tr>';
                                    }
                                }
                        	}
                    	}
                    	else if(opp.StageName == 'Return To Customer'){
                            if(insertRecordMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile Presence</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                        	}
                            if(updateRecordMap.keySet().contains(sensorTag)){
                        		for(String hqTag: hQtagSet){
                                    if(hqTag == sensorTag){
                            			body += '<tr><td>Automobile Presence</td><td>' + sensorTag + '</td> </td> Sensor is moved from Shipment Account to Installation Account ' + accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                                    }
                        		}
                            }
                    	}
                	}
                    else if(sensorTag.startsWith('00:11:CE:E')){
                    	if(opp.StageName == 'Shipped To Customer'){
                        	if(insertRecordMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile TDU</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                        	}
                    	}
                    
                    	else if(opp.StageName == 'Return To HQ'){
                        	if(updateRecordMap.keySet().contains(sensorTag)){
                                for(String hqTag: hQtagSet){
                                    if(hqTag == sensorTag){
                                        body += '<tr><td>AutoMobile TDU Sensor</td><td>' + sensorTag + '</td> </td> Moved Under Shipment Account ' + accountWithNames.get(opp.Shipment_Account__c).Name + '</td></tr>';
                                    }
                                }
                        	}
                    	}
                    	else if(opp.StageName == 'Return To Customer'){
                            if(insertRecordMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile TDU</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                        	}
                            if(updateRecordMap.keySet().contains(sensorTag)){
                        		for(String hqTag: hQtagSet){
                                    if(hqTag == sensorTag){
                            			body += '<tr><td>Automobile TDU</td><td>' + sensorTag + '</td> </td> Sensor is moved from Shipment Account to Installation Account ' +accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                                    }
                        		}
                            }
                    	}
                	}
                    else if(sensorTag.substring(0,3).isNumeric()){
                    	if(opp.StageName == 'Shipped To Customer'){
                        	if(insertRecordMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile Tag</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                        	}
                    	}
                    
                    	else if(opp.StageName == 'Return To HQ'){
                        	if(updateRecordMap.keySet().contains(sensorTag)){
                                for(String hqTag: hQtagSet){
                                    if(hqTag == sensorTag){
                                        body += '<tr><td>AutoMobile Tag Sensor</td><td>' + sensorTag + '</td> </td> Moved Under Shipment Account ' + accountWithNames.get(opp.Shipment_Account__c).Name + '</td></tr>';
                                    }
                                }
                        	}
                    	}
                    	else if(opp.StageName == 'Return To Customer'){
                            if(insertRecordMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile Tag</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                        	}
                            if(updateRecordMap.keySet().contains(sensorTag)){
                        		for(String hqTag: hQtagSet){
                                    if(hqTag == sensorTag){
                            			body += '<tr><td>Automobile Tag</td><td>' + sensorTag + '</td> </td> Sensor is moved from Shipment Account to Installation Account ' +accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                                    }
                        		}
                            }
                    	}
                	}
                }
                body+= '</table>';
                
                //For Unsucessful Email Send
                body+= '<br>Unsuccessful<br>';
            	body += '<table style="width:100%" border = "1px solid black"> <tr> <th>Automobile Type</th> <th>Name</th> <th>Message</th></tr>';
                for(String sensorTag : sensorSet){
                    if(sensorTag.length() > 18){
                        sensorTag = sensorTag.substring(0, 18);
                    }
                    if(!sensorTag.startsWith('00:11:CE:00')&& !sensorTag.startsWith('00:11:CE:D') && !sensorTag.startsWith('00:11:CE:E') && !SensorTag.substring(0,3).isNumeric()){
                    	body += '<tr><td> Sensor </td><td>' + sensorTag + '</td> </td> tag Is not valid' + sensorTag + '</td></tr>';
                	}
                    else{
                        if(sensorTag.startsWith('00:11:CE:00')){
                            if(!updateRecordMap.keySet().contains(sensorTag) && !insertRecordMap.keySet().contains(sensorTag)){
                                System.debug(updateRecordMap);
                                System.debug(insertRecordMap);
                                body += '<tr><td>Automobile Sensor</td><td>' + sensorTag + '</td> </td> Already Exists Under Installation Account ' + accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                            }
                        }
                        else if(sensorTag.startsWith('00:11:CE:D')){
                            if(!updateRecordMap.keySet().contains(sensorTag) && !insertRecordMap.keySet().contains(sensorTag)){
                                body += '<tr><td>Automobile Presence Sensor</td><td>' + sensorTag + '</td> </td> Already Exists Under Installation Account ' + accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                            }
                            
                        }
                        else if(sensorTag.startsWith('00:11:CE:E')){
                            if(!updateRecordMap.keySet().contains(sensorTag) && !insertRecordMap.keySet().contains(sensorTag)){
                                body += '<tr><td>Automobile TDU Sensor</td><td>' + sensorTag + '</td> </td> Already Exists Under Installation Account ' + accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                            }
                        }
                        else if(sensorTag.substring(0,3).isNumeric()){
                            if(!updateRecordMap.keySet().contains(sensorTag) && !insertRecordMap.keySet().contains(sensorTag)){
                                body += '<tr><td>Automobile Tag Sensor</td><td>' + sensorTag + '</td> </td> Already Exists Under Installation Account ' + accountWithNames.get(opp.Installation_Account__c).Name + '</td></tr>';
                            }
                        }
                    }
            	}
                body+= '</table>';
                mail.setHtmlBody(body);
            	emailList.add(mail);
            }
        }
        
        if(emailList.size()>0){
            Messaging.SendEmail(emailList);
        }
    }
}