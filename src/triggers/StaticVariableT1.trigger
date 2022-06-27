//Trigger for first run method
trigger StaticVariableT1 on Account (before delete, after delete, after undelete) {
    if(Trigger.isBefore){
        if(Trigger.isBefore){
            if(StaticMethodsAndVariables.firstRun){
                Trigger.old[0].addError('Before Account Delete Error');
                StaticMethodsAndVariables.firstRun=false;
            }
        }
    }

}