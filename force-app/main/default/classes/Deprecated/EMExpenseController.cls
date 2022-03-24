public with sharing class EMExpenseController {
    
    @AuraEnabled(cacheable=true)
    public static List<ExpenseWrapper> getExpenses() {
        List<EM_Expense__c> expensesList = [SELECT Name, EM_Reimbursement_Status__c, EM_Report__r.Name FROM EM_Expense__c WITH SECURITY_ENFORCED];

        List<ExpenseWrapper> expenses = new List<ExpenseWrapper>();
        Id reportId;
        String reportName;
        Id expenseId;
        String expenseName;
        String expenseStatus;
        for (EM_Expense__c exp : expensesList) {
            reportId = exp.EM_Report__r.Id;
            reportName = exp.EM_Report__r.Name;
            expenseId = exp.Id;
            expenseName = exp.Name;
            expenseStatus = exp.EM_Reimbursement_Status__c;
            ExpenseWrapper expense = new ExpenseWrapper(reportId, reportName, expenseId, expenseName, expenseStatus);
            expenses.add(expense);
        }
        return expenses;
    }



    public class ExpenseWrapper {
        @AuraEnabled
        public Id reportId { get; set; }
        @AuraEnabled
        public String reportName { get; set; }
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
    	public ExpenseWrapper(Id id, String name, String status, String expenseLabel, Decimal transactionAmount, Decimal reimbursementAmount, String expenseCurrency, Date purchaseDate, String reimbursementBy) {
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
        public ExpenseWrapper(Id reportId, String reportName, Id expId, String name, String status) {
            this.reportId = reportId;
            this.reportName = reportName;
            this.expenseId = expId;
            this.expenseName = name;
            this.expenseStatus = status;
        }
    }
}
