public with sharing class EM_ReportModel {
    public static List<EM_ReportEntity.ReportWrapper> getReport() {
        List<EM_Report__c> reportsData = [SELECT Id, Name, Status__c, EM_Total_Amount__c, 
											(SELECT Id, Name, EM_Expense_Label__c, EM_Transaction_Amount__c, EM_Reimbursement_Amount__c, EM_Currency__c, EM_Reimbursement_Status__c, EM_Purchase_Date__c, EM_Reimbursement_By__c FROM EM_Expenses__r) 
											FROM EM_Report__c WITH SECURITY_ENFORCED];
        List<EM_ReportEntity.ReportWrapper> reports = new List<EM_ReportEntity.ReportWrapper>();
        for (EM_Report__c rep : reportsData) {
            List<EM_ExpenseEntity.ExpenseWrapper> expenses = new List<EM_ExpenseEntity.ExpenseWrapper>();
            for (EM_Expense__c exp : rep.EM_Expenses__r) {
				Id id = exp.id;
				String name = exp.Name;
				String status = exp.EM_Reimbursement_Status__c;
				String expLbl = exp.EM_Expense_Label__c;
				Decimal trnsAm = exp.EM_Transaction_Amount__c;
				Decimal reimAm = exp.EM_Reimbursement_Amount__c;
				String exCur = exp.EM_Currency__c;
				Date purDt = exp.EM_Purchase_Date__c;
				String reimBy = exp.EM_Reimbursement_By__c;
                EM_ExpenseEntity.ExpenseWrapper expense = new EM_ExpenseEntity.ExpenseWrapper(id, name, status, expLbl, trnsAm, reimAm, exCur, purDt, reimBy);
                expenses.add(expense);
			}
			Id id = rep.id;
			String name = rep.Name;
			String status = rep.Status__c;
			Decimal total = rep.EM_Total_Amount__c;
            EM_ReportEntity.ReportWrapper report = new EM_ReportEntity.ReportWrapper(id, name, status, total, expenses);
            reports.add(report);
        }
        return reports;
    }

	public static void getReportsTotalAmount() {
        List<EM_Report__c> lstRep = [SELECT Id, Name, EM_Total_Amount__c, 
                                        (SELECT id, EM_Transaction_Amount__c FROM EM_Expenses__r) 
                                    FROM EM_Report__c WITH SECURITY_ENFORCED];
        EM_ReportService.recalculateReportsTotalAmount(lstRep);
    }
}
