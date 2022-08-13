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
        Map<String, Automobile_Sensor__c> InsertAuSensorMap = new Map<String, Automobile_Sensor__c>();
        Map<String, Automobile_Presence_Sensor__c> InsertApSensorMap = new Map<String, Automobile_Presence_Sensor__c>();
        Map<String, Automobile_TDU__c> InsertATDUSensorMap = new Map<String, Automobile_TDU__c>();
        Map<String, Automobile_Tag__c> InsertATagSensorMap = new Map<String, Automobile_Tag__c>();
        //Update Map
        Map<String, Automobile_Sensor__c> updateAuSensorMap = new Map<String, Automobile_Sensor__c>();
        Map<String, Automobile_Presence_Sensor__c> updateApSensorMap = new Map<String, Automobile_Presence_Sensor__c>();
        Map<String, Automobile_TDU__c> updateATDUSensorMap = new Map<String, Automobile_TDU__c>();
        Map<String, Automobile_Tag__c> updateATagSensorMap = new Map<String, Automobile_Tag__c>();
        
        //Set of Sensors from automobile tag details
        set<String> sensorSet = new set<String>();
        for(Opportunity opp : oppList){
            if((opp.Automobile_Tag_Details_1__c != null || opp.Automobile_Tag_Details_2__c != null || opp.Automobile_Tag_Details_3__c != null)){
                String tagDetailsSplit = opp.Automobile_Tag_Details_1__c + '\n' + opp.Automobile_Tag_Details_2__c + '\n' + opp.Automobile_Tag_Details_3__c;
                for(String sensor : tagDetailsSplit.split('\n')){
                    sensorSet.add(sensor.trim());
                }
            }
        }
        
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
        set<String> hQtagSet = new set<String>();
        
        for(Opportunity opp : oppList){

            if((opp.StageName == 'Shipped To Customer' || opp.StageName == 'Return To HQ' || opp.StageName == 'Return To Customer') && (oldOppMap == null || opp.StageName != oldOppMap.get(opp.Id).StageName)){
                	
                for(String sensorTag : sensorSet){
                    
                    //If Stage Changes to Shipped To Customer in Opportunity   
                    if(opp.StageName == 'Shipped To Customer'){
                        if(sensorTag.length() > 18){
                            sensorTag = sensorTag.substring(0, 18);
                        }
                        if(sensorTag.startsWith('00:11:CE:00') && !auSensorOldSet.contains(sensorTag)){
                            Automobile_Sensor__c auSensor = new Automobile_Sensor__c();
                            auSensor.Name = sensorTag;
                            auSensor.Opportunity__c = opp.Id;
                            auSensor.Account__c = opp.Installation_Account__c;
							InsertAuSensorMap.put(sensorTag, auSensor);
							System.debug(InsertAuSensorMap);   
                        }
                        if(sensorTag.startsWith('00:11:CE:D') && !apSensorOldSet.contains(sensorTag)){
                            Automobile_Presence_Sensor__c apSensor = new Automobile_Presence_Sensor__c();
                            apSensor.Name = sensorTag;
                            apSensor.Opportunity__c = opp.Id;
                            apSensor.Account__c = opp.Installation_Account__c;
                            InsertApSensorMap.put(sensorTag, apSensor);
                        }
                        if(sensorTag.startsWith('00:11:CE:E') && !aTDUSensorOldSet.contains(sensorTag)){
                            Automobile_TDU__c aTDUSensor = new Automobile_TDU__c();
                            aTDUSensor.Name = sensorTag;
                            aTDUSensor.Opportunity__c = opp.Id;
                            aTDUSensor.Account__c = opp.Installation_Account__c;
                            InsertATDUSensorMap.put(SensorTag, aTDUSensor);
                        }
                        if(sensorTag.substring(1,3).isNumeric() && !aTagSensorOldSet.contains(sensorTag)){
                            Automobile_Tag__c aTagSensor = new Automobile_Tag__c();
                            aTagSensor.Name = sensorTag;
                            aTagSensor.Opportunity__c = opp.Id;
                            aTagSensor.Account__c = opp.Installation_Account__c;
                            InsertATagSensorMap.put(sensorTag, aTagSensor);
                        }
                    }
                    
                    //If Stage Changes to Return To Customer in Opportunity   
                    if(opp.StageName == 'Return To Customer'){
                        if(sensorTag.length() > 18){
                            sensorTag = sensorTag.substring(0, 18);
                        }
                        if(sensorTag.startsWith('00:11:CE:00')){
                            if(!auSensorOldSet.contains(sensorTag)){
                                Automobile_Sensor__c auSensor = new Automobile_Sensor__c();
                            	auSensor.Name = sensorTag;
                            	auSensor.Opportunity__c = opp.Id;
                            	auSensor.Account__c = opp.Installation_Account__c;
                                InsertAuSensorMap.put(sensorTag, auSensor);
                                System.debug(InsertAuSensorMap);
                            }
                            else if(auSensorOldSet.contains(sensorTag)){
                                for(Automobile_Sensor__c oldAusensor : oldAuSensorMap.values()){
                                    if(oldAusensor.Name == sensorTag &&  oldAuSensor.Opportunity__c == opp.Id){
                                        oldAuSensor.Account__c = opp.Installation_Account__c;
                                        updateAuSensorMap.put(sensorTag, oldAusensor);
                                        System.debug(updateAuSensorMap);
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
                                InsertApSensorMap.put(sensorTag, apSensor);
                            }
                            else if(apSensorOldSet.contains(sensorTag)){
                                for(Automobile_Presence_Sensor__c oldApSensor : oldApSensorMap.values()){
                                    if(oldApSensor.Name == sensorTag &&  oldApSensor.Opportunity__c == opp.Id){
                                        oldApSensor.Account__c = opp.Installation_Account__c;
                                        updateApSensorMap.put(sensorTag, oldApSensor);
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
                                InsertATDUSensorMap.put(SensorTag, aTDUSensor);
                            }
                            else if(aTDUSensorOldSet.contains(sensorTag)){
                                for(Automobile_TDU__c oldATDUSensor : oldATDUSensorMap.values()){
                                    if(oldATDUSensor.Name == sensorTag &&  oldATDUSensor.Opportunity__c == opp.Id){
                                        oldATDUSensor.Account__c = opp.Installation_Account__c;
                                        updateATDUSensorMap.put(sensorTag, oldATDUSensor);
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
                                InsertATagSensorMap.put(sensorTag, aTagSensor);
                            }
                            else if(aTagSensorOldSet.contains(sensorTag)){
                                for(Automobile_Tag__c oldATagSensor : oldATagSensorMap.values()){
                                    if(oldATagSensor.Name == sensorTag &&  oldATagSensor.Opportunity__c == opp.Id){
                                        oldATagSensor.Account__c = opp.Installation_Account__c;
                                        updateATagSensorMap.put(sensorTag, oldATagSensor);
                                    }
                                }
                            }
                        }
                    }
                }
                
                // If Stage changes to Return To HQ in Opportunity   
                if(opp.StageName == 'Return To HQ'){
                    for(String hQSensorTags : opp.Return_To_HQ__c.split('\n')){
                        hQtagSet.add(hQSensorTags.trim());
                    }
                    for(String hQSensorTags : hQtagSet){
                        if(hQSensorTags.length() > 18){
                            hQSensorTags = hQSensorTags.substring(0,18);
                        }
                       
                        if(hQSensorTags.startsWith('00:11:CE:00') && auSensorOldSet.contains(hQSensorTags)){
                            for(Automobile_Sensor__c oldAuSensor : oldAuSensorMap.values()){
                                if(oldAusensor.Name == hQSensorTags &&  oldAuSensor.Opportunity__c == opp.Id){
                                    oldAuSensor.Account__c = opp.Shipment_Account__c;
                                    updateAuSensorMap.put(hQSensorTags, oldAuSensor);
                                }
                            }
                        }
                        if(hQSensorTags.startsWith('00:11:CE:D') && apSensorOldSet.contains(hQSensorTags)){
                            for(Automobile_Presence_Sensor__c oldApSensor : oldApSensorMap.values()){
                                if(oldApSensor.Name == hQSensorTags && oldApSensor.Opportunity__c == opp.Id){
                                    oldApSensor.Account__c = opp.Shipment_Account__c;
                                    updateApSensorMap.put(hQSensorTags, oldApSensor);
                                }
                            }
                        }   
                        if(hQSensorTags.startsWith('00:11:CE:E') && aTDUSensorOldSet.contains(hQSensorTags)){
                            for(Automobile_TDU__c oldATDUSensor : oldATDUSensorMap.values()){
                                if(oldATDUSensor.Name == hQSensorTags && oldATDUSensor.Opportunity__c == opp.Id){
                                    oldATDUSensor.Account__c = opp.Shipment_Account__c;
                                    updateATDUSensorMap.put(hQSensorTags, oldATDUSensor);
                                }
                            }
                        }   
                        if(hQSensorTags.substring(0,3).isNumeric() && aTagSensorOldSet.contains(hQSensorTags)){
                            for(Automobile_Tag__c oldATagSensor : oldATagSensorMap.values()){
                                if(oldATagSensor.Name == hQsensorTags &&  oldATagSensor.Opportunity__c == opp.Id){
                                    oldATagSensor.Account__c = opp.Shipment_Account__c;
                                    updateATagSensorMap.put(hQSensorTags, oldATagSensor);
                                }
                            }
                        }
                    }
                }
            }
        }
        
        //Insert and Update DML Perform
        if(InsertAuSensorMap.size() > 0){
            insert InsertAuSensorMap.values();
        }
        if(updateAuSensorMap.size() > 0){
            update updateAuSensorMap.values();
        }
        if(InsertApSensorMap.size() > 0){
            insert InsertApSensorMap.values();
        }
        if(updateApSensorMap.size() > 0){
            update updateApSensorMap.values();
        }
        if(InsertATDUSensorMap.size() > 0){
            insert InsertATDUSensorMap.values();
        }
        if(updateATDUSensorMap.size() > 0){
            update updateATDUSensorMap.values();
        }
        if(InsertATagSensorMap.size() > 0){
            insert InsertATagSensorMap.values();
        }
        if(updateATagSensorMap.size() > 0){
            update updateATagSensorMap.values();
        }
        
        //Email Send Method values pass on the parameters
        opportunityEmailHandler(oppList, InsertAuSensorMap, updateAuSensorMap, InsertApSensorMap, updateApSensorMap, InsertATDUSensorMap, updateATDUSensorMap, InsertATagSensorMap, updateATagSensorMap,hQtagSet);
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
    
    public static void opportunityEmailHandler(List<Opportunity>oppList, Map<String, Automobile_Sensor__c>InsertAuSensorMap, Map<String, Automobile_Sensor__c>updateAuSensorMap,
    Map<String, Automobile_Presence_Sensor__c>InsertApSensorMap, Map<String, Automobile_Presence_Sensor__c>updateApSensorMap,
    Map<String, Automobile_TDU__c>InsertATDUSensorMap, Map<String, Automobile_TDU__c>updateATDUSensorMap,
    Map<String, Automobile_Tag__c>InsertATagSensorMap, Map<String, Automobile_Tag__c>updateATagSensorMap, set<String> hQtagSet){
        
        //Single Email Message email List
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        
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
                    if(sensorTag.startsWith('00:11:CE:00')){
                    	if(opp.StageName == 'Shipped To Customer'){
                        	if(InsertAuSensorMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile Sensor</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + opp.Installation_Account__c + '</td></tr>';
                        	}
                    	}
                        
                    	else if(opp.StageName == 'Return To HQ'){
                        	if(updateAuSensorMap.keySet().contains(sensorTag) && 
                               updateAuSensorMap.get(sensorTag).Account__c == opp.Shipment_Account__c){
                                   for(String hqTag: hQtagSet){
                                       if(hqTag == sensorTag){
                                           body += '<tr><td>AutoMobile Sensor</td><td>' + sensorTag + '</td> </td> Moved Under Shipment Account ' + opp.Shipment_Account__c + '</td></tr>';
                                       }
                                   }
                        	}
                    	}
                    	else if(opp.StageName == 'Return To Customer'){
                            if(InsertAuSensorMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile Sensor</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + opp.Installation_Account__c + '</td></tr>';
                        	}
                            if(updateAuSensorMap.keySet().contains(sensorTag)){
                        		if(updateAuSensorMap.get(sensorTag).Account__c == opp.Installation_Account__c){
                                    for(String hqTag: hQtagSet){
                                        if(hqTag == sensorTag){
                            				body += '<tr><td>Automobile </td><td>' + sensorTag + '</td> </td> Sensor is moved from Shipment Account to Installation Account ' + opp.Installation_Account__c + '</td></tr>';
                                        }
                                    }
                        		}
                            }
                    	}
                	}
                    else if(sensorTag.startsWith('00:11:CE:D')){
                    	if(opp.StageName == 'Shipped To Customer'){
                        	if(InsertApSensorMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile Presence</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + opp.Installation_Account__c + '</td></tr>';
                        	}
                    	}
                    
                    	else if(opp.StageName == 'Return To HQ'){
                        	if(updateApSensorMap.keySet().contains(sensorTag) && 
                               updateApSensorMap.get(sensorTag).Account__c == opp.Shipment_Account__c){
                                   for(String hqTag: hQtagSet){
                                       if(hqTag == sensorTag){
                                           body += '<tr><td>AutoMobile Presence</td><td>' + sensorTag + '</td> </td> Moved Under Shipment Account ' + opp.Shipment_Account__c + '</td></tr>';
                                       }
                                   }
                        	}
                    	}
                    	else if(opp.StageName == 'Return To Customer'){
                            if(InsertApSensorMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile Presence</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + opp.Installation_Account__c + '</td></tr>';
                        	}
                            if(updateApSensorMap.keySet().contains(sensorTag)){
                        		if(updateApSensorMap.get(sensorTag).Account__c == opp.Installation_Account__c){
                            		body += '<tr><td>Automobile Presence</td><td>' + sensorTag + '</td> </td> Sensor is moved from Shipment Account to Installation Account ' + opp.Installation_Account__c + '</td></tr>';
                        		}
                            }
                    	}
                	}
                    else if(sensorTag.startsWith('00:11:CE:E')){
                    	if(opp.StageName == 'Shipped To Customer'){
                        	if(InsertATDUSensorMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile TDU</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + opp.Installation_Account__c + '</td></tr>';
                        	}
                    	}
                    
                    	else if(opp.StageName == 'Return To HQ'){
                        	if(updateATDUSensorMap.keySet().contains(sensorTag) && 
                               updateATDUSensorMap.get(sensorTag).Account__c == opp.Shipment_Account__c){
                                   for(String hqTag: hQtagSet){
                                       if(hqTag == sensorTag){
                                           body += '<tr><td>AutoMobile TDU Sensor</td><td>' + sensorTag + '</td> </td> Moved Under Shipment Account ' + opp.Shipment_Account__c + '</td></tr>';
                                       }
                                   }
                        	}
                    	}
                    	else if(opp.StageName == 'Return To Customer'){
                            if(InsertATDUSensorMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile TDU</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + opp.Installation_Account__c + '</td></tr>';
                        	}
                            if(updateATDUSensorMap.keySet().contains(sensorTag)){
                        		if(updateATDUSensorMap.get(sensorTag).Account__c == opp.Installation_Account__c){
                            		body += '<tr><td>Automobile TDU</td><td>' + sensorTag + '</td> </td> Sensor is moved from Shipment Account to Installation Account ' + opp.Installation_Account__c + '</td></tr>';
                        		}
                            }
                    	}
                	}
                    else if(sensorTag.substring(0,3).isNumeric()){
                    	if(opp.StageName == 'Shipped To Customer'){
                        	if(InsertATagSensorMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile Tag</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + opp.Installation_Account__c + '</td></tr>';
                        	}
                    	}
                    
                    	else if(opp.StageName == 'Return To HQ'){
                        	if(updateATagSensorMap.keySet().contains(sensorTag) && 
                               updateATagSensorMap.get(sensorTag).Account__c == opp.Shipment_Account__c){
                                   for(String hqTag: hQtagSet){
                                       if(hqTag == sensorTag){
                                           body += '<tr><td>AutoMobile Tag Sensor</td><td>' + sensorTag + '</td> </td> Moved Under Shipment Account ' + opp.Shipment_Account__c + '</td></tr>';
                                       }
                                   }
                        	}
                    	}
                    	else if(opp.StageName == 'Return To Customer'){
                            if(InsertATagSensorMap.keySet().contains(sensorTag)){
                            	body += '<tr><td>Automobile Tag</td><td>' + sensorTag + '</td> </td> Sensor Inserted Under Installation Account ' + opp.Installation_Account__c + '</td></tr>';
                        	}
                            if(updateATagSensorMap.keySet().contains(sensorTag)){
                        		if(updateATagSensorMap.get(sensorTag).Account__c == opp.Installation_Account__c){
                            		body += '<tr><td>Automobile Tag</td><td>' + sensorTag + '</td> </td> Sensor is moved from Shipment Account to Installation Account ' + opp.Installation_Account__c + '</td></tr>';
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
                    if(!sensorTag.startsWith('00:11:CE:00')&& !sensorTag.startsWith('00:11:CE:D') && !sensorTag.startsWith('00:11:CE:E') && !SensorTag.substring(0,3).isNumeric()){
                    	body += '<tr><td> Sensor </td><td>' + sensorTag + '</td> </td> tag Is not valid' + sensorTag + '</td></tr>';
                	}
                    else{
                        if(sensorTag.startsWith('00:11:CE:00')){
                            if(!updateAuSensorMap.keySet().contains(sensorTag) && !InsertAuSensorMap.keySet().contains(sensorTag)){
                                System.debug(updateAuSensorMap);
                                System.debug(InsertAuSensorMap);
                                body += '<tr><td>Automobile Sensor</td><td>' + sensorTag + '</td> </td> Already Exists Under Installation Account ' + opp.Installation_Account__c + '</td></tr>';
                            }
                        }
                        else if(sensorTag.startsWith('00:11:CE:D')){
                            if(!updateApSensorMap.keySet().contains(sensorTag) && !InsertApSensorMap.keySet().contains(sensorTag)){
                                body += '<tr><td>Automobile Presence Sensor</td><td>' + sensorTag + '</td> </td> Already Exists Under Installation Account ' + opp.Installation_Account__c + '</td></tr>';
                            }
                            
                        }
                        else if(sensorTag.startsWith('00:11:CE:E')){
                            if(!updateATDUSensorMap.keySet().contains(sensorTag) && !InsertATDUSensorMap.keySet().contains(sensorTag)){
                                body += '<tr><td>Automobile TDU Sensor</td><td>' + sensorTag + '</td> </td> Already Exists Under Installation Account ' + opp.Installation_Account__c + '</td></tr>';
                            }
                        }
                        else if(sensorTag.substring(0,3).isNumeric()){
                            if(!updateATagSensorMap.keySet().contains(sensorTag) && !InsertATagSensorMap.keySet().contains(sensorTag)){
                                body += '<tr><td>Automobile Tag Sensor</td><td>' + sensorTag + '</td> </td> Already Exists Under Installation Account ' + opp.Installation_Account__c + '</td></tr>';
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