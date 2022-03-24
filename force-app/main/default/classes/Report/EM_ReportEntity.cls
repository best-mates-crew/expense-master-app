public with sharing class EM_ReportEntity {

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
