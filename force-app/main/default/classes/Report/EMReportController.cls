public with sharing class EMReportController {

	@AuraEnabled(cacheable=true)
	public static List<ReportWrapper> getReport() {
		List<EM_Report__c> reportsData = [
			SELECT Id, Name, Status__c, (SELECT Id, Name, EM_Reimbursement_Status__c FROM EM_Expenses__r)
			FROM EM_Report__c
			WITH SECURITY_ENFORCED
		];

		List<ReportWrapper> reports = new List<ReportWrapper>();

		for (EM_Report__c rep : reportsData) {
			List<ExpenseWrapper> expenses = new List<ExpenseWrapper>();

			for (EM_Expense__c exp : rep.EM_Expenses__r) {
				ExpenseWrapper expense = new ExpenseWrapper(exp.id, exp.Name, exp.EM_Reimbursement_Status__c);
				expenses.add(expense);
			}

			ReportWrapper report = new ReportWrapper(rep.id, rep.Name, rep.Status__c, expenses);
			reports.add(report);
		}
		return reports;
	}

	class ReportWrapper {
		@AuraEnabled
		public Id id { get; set; }
		@AuraEnabled
		public String name { get; set; }
		@AuraEnabled
		public String status { get; set; }
		@AuraEnabled
		public List<ExpenseWrapper> expenses { get; set; }
		ReportWrapper(Id id, String name, String status, List<ExpenseWrapper> expenses) {
			this.id = id;
			this.name = name;
			this.status = status;
			this.expenses = expenses;
		}
	}

	class ExpenseWrapper {
		@AuraEnabled
		public Id expenseId { get; set; }
		@AuraEnabled
		public String expenseName { get; set; }
		@AuraEnabled
		public String expenseStatus { get; set; }
		ExpenseWrapper(Id id, String name, String status) {
			this.expenseId = id;
			this.expenseName = name;
			this.expenseStatus = status;
		}
	}
}
