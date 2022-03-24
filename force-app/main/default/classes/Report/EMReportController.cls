public with sharing class EMReportController {
	@AuraEnabled(cacheable=true)
	public static List<ReportWrapper> getReport() {
		List<EM_Report__c> reportsData = [
			SELECT
				Id,
				Name,
				Status__c,
				EM_Total_Amount__c,
				(
					SELECT
						Id,
						Name,
						EM_Expense_Label__c,
						EM_Transaction_Amount__c,
						EM_Reimbursement_Amount__c,
						EM_Currency__c,
						EM_Reimbursement_Status__c,
						EM_Purchase_Date__c,
						EM_Reimbursement_By__c
					FROM EM_Expenses__r
				)
			FROM EM_Report__c
			WITH SECURITY_ENFORCED
		];

		List<ReportWrapper> reports = new List<ReportWrapper>();

		for (EM_Report__c rep : reportsData) {
			List<ExpenseWrapper> expenses = new List<ExpenseWrapper>();

			for (EM_Expense__c exp : rep.EM_Expenses__r) {
				ExpenseWrapper expense = new ExpenseWrapper(
					exp.id,
					exp.Name,
					exp.EM_Reimbursement_Status__c,
					exp.EM_Expense_Label__c,
					exp.EM_Transaction_Amount__c,
					exp.EM_Reimbursement_Amount__c,
					exp.EM_Currency__c,
					exp.EM_Purchase_Date__c,
					exp.EM_Reimbursement_By__c
				);
				expenses.add(expense);
			}

			ReportWrapper report = new ReportWrapper(rep.id, rep.Name, rep.Status__c, rep.EM_Total_Amount__c, expenses);
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
		public Decimal totalAmount { get; set; }
		@AuraEnabled
		public List<ExpenseWrapper> expenses { get; set; }
		ReportWrapper(Id id, String name, String status, Decimal totalAmount, List<ExpenseWrapper> expenses) {
			this.id = id;
			this.name = name;
			this.status = status;
			this.totalAmount = totalAmount;
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
		@AuraEnabled
		public String expenseLabel { get; set; }
		@AuraEnabled
		public Decimal transactionAmount { get; set; }
		@AuraEnabled
		public Decimal reimbursementAmount { get; set; }
		@AuraEnabled
		public String expenseCurrency { get; set; }
		@AuraEnabled
		public Date purchaseDate { get; set; }
		@AuraEnabled
		public String reimbursementBy { get; set; }

		ExpenseWrapper(
			Id id,
			String name,
			String status,
			String expenseLabel,
			Decimal transactionAmount,
			Decimal reimbursementAmount,
			String expenseCurrency,
			Date purchaseDate,
			String reimbursementBy
		) {
			this.expenseId = id;
			this.expenseName = name;
			this.expenseStatus = status;
			this.expenseLabel = expenseLabel;
			this.transactionAmount = transactionAmount;
			this.reimbursementAmount = reimbursementAmount;
			this.expenseCurrency = expenseCurrency;
			this.purchaseDate = purchaseDate;
			this.reimbursementBy = reimbursementBy;
		}
	}
}
