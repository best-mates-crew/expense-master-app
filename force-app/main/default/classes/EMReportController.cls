public with sharing class EMReportController {

    @Auraenabled(cacheable=true)
    public static List<EM_Report__c> gerReports(){
        return [SELECT Name, (SELECT Name FROM EM_Expenses__r) FROM EM_Report__c WITH SECURITY_ENFORCED];
    }
}
