public with sharing class EMReportController {
    // MODEL
    //EM_ReportModel
    @AuraEnabled(cacheable=true)
    public static List<ReportWrapper> getReport() {
        List<EM_Report__c> reportsData = [SELECT Id, Name, Status__c, EM_Total_Amount__c, (SELECT Id, Name, EM_Expense_Label__c, EM_Transaction_Amount__c, EM_Reimbursement_Amount__c, EM_Currency__c, EM_Reimbursement_Status__c, EM_Purchase_Date__c, EM_Reimbursement_By__c FROM EM_Expenses__r) FROM EM_Report__c WITH SECURITY_ENFORCED];
        List<ReportWrapper> reports = new List<ReportWrapper>();
        for (EM_Report__c rep : reportsData) {
            List<EMExpenseController.ExpenseWrapper> expenses = new List<EMExpenseController.ExpenseWrapper>();
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
                EMExpenseController.ExpenseWrapper expense = new EMExpenseController.ExpenseWrapper(id, name, status, expLbl, trnsAm, reimAm, exCur, purDt, reimBy);
                expenses.add(expense);
			}
			Id id = rep.id;
			String name = rep.Name;
			String status = rep.Status__c;
			Decimal total = rep.EM_Total_Amount__c;
            ReportWrapper report = new ReportWrapper(id, name, status, total, expenses);
            reports.add(report);
        }
        return reports;
    }
    // ENTITY
    // EM_ReportEntity
    public class ReportWrapper {
        @AuraEnabled
        public Id id { get; set; }
        @AuraEnabled
        public String name { get; set; }
        @AuraEnabled
        public String status { get; set; }
        @AuraEnabled
        public Decimal totalAmount { get; set; }
        @AuraEnabled
        public List<EMExpenseController.ExpenseWrapper> expenses { get; set; }
        public ReportWrapper(
			Id id,
			String name,
			String status,
			Decimal totalAmount,
			List<EMExpenseController.ExpenseWrapper> expenses
			) {
            this.id = id;
            this.name = name;
            this.status = status;
            this.totalAmount = totalAmount;
            this.expenses = expenses;
        }
    }
}
