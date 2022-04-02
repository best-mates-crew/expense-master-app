public with sharing class EM_ExpenseEntity {

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
    	// @AuraEnabled
    	// public Decimal reimbursementAmount { get; set; }
    	@AuraEnabled
    	public String expenseCurrency { get; set; }
    	@AuraEnabled
    	public Date purchaseDate { get; set; }
    	@AuraEnabled
    	public String reimbursementBy { get; set; }
    	public ExpenseWrapper(Id id, String name, String status, String expenseLabel, Decimal transactionAmount, String expenseCurrency, Date purchaseDate, String reimbursementBy) {
    		this.expenseId = id;
    		this.expenseName = name;
    		this.expenseStatus = status;
    		this.expenseLabel = expenseLabel;
    		this.transactionAmount = transactionAmount;
    		// this.reimbursementAmount = reimbursementAmount;
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
