public with sharing class EM_ReportController {
    @AuraEnabled(cacheable=true)
    public static List<EM_ReportEntity.ReportWrapper> getReports(){
        List<EM_ReportEntity.ReportWrapper> reports = EM_ReportModel.getReport();
        return reports;
    }
}
