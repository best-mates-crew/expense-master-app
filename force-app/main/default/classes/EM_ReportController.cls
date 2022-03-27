public with sharing class EM_ReportController {
    @AuraEnabled
    public static List<EM_ReportEntity.ReportWrapper> getReports(){
        List<EM_ReportEntity.ReportWrapper> reports = EM_ReportModel.getReport();
        return reports;
    }

    public static void recalculateReportsTotalAmount(){
        EM_ReportModel.getReportsTotalAmount();
    }
}
