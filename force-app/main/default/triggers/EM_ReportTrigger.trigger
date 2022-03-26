trigger EM_ReportTrigger on EM_Report__c (before insert, before update, before delete, after insert, after update, after delete) {

    EM_ReportTriggerHandler reportsHandler = new EM_ReportTriggerHandler();

    if(Trigger.isBefore && Trigger.isInsert){
        


        
    }
}