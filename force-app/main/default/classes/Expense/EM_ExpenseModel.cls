public with sharing class EM_ExpenseModel {
    public static List<EM_ExpenseEntity.ExpenseWrapper> getExpenses() {
        List<EM_Expense__c> expensesList = [SELECT Name, EM_Reimbursement_Status__c, EM_Report__r.Name FROM EM_Expense__c WITH SECURITY_ENFORCED];

        List<EM_ExpenseEntity.ExpenseWrapper> expenses = new List<EM_ExpenseEntity.ExpenseWrapper>();
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
            EM_ExpenseEntity.ExpenseWrapper expense = new EM_ExpenseEntity.ExpenseWrapper(reportId, reportName, expenseId, expenseName, expenseStatus);
            expenses.add(expense);
        }
        return expenses;
    }

}
