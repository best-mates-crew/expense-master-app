public with sharing class EM_ReportService {
    
    public static void recalculateReportsTotalAmount(List<EM_Report__c> listReports) {
        Map<Id, List<Decimal>> expensesAmoutn = new Map<Id, List<Decimal>>();

        for (EM_Report__c rep : listReports) {
            List<Decimal> expsAmount = new List<Decimal>();
            Decimal totalAmount = 0.00;
            for (EM_Expense__c exp : rep.EM_Expenses__r) {
                expsAmount.add(exp.EM_Transaction_Amount__c);
            }
            System.debug('expsAmount: ' + expsAmount);
            for (Integer i = 0; i < expsAmount.size(); i++) {
                totalAmount = totalAmount + expsAmount[i];
            }

            expensesAmoutn.put(rep.id, expsAmount);

            rep.EM_Total_Amount__c = totalAmount;
        }
        update listReports;
    }
}
