public with sharing class EM_ExpenseController {
    @AuraEnabled(cacheable=true)
    public static List<EM_ExpenseEntity.ExpenseWrapper> getExpenses(){
        List<EM_ExpenseEntity.ExpenseWrapper> expenses = EM_ExpenseModel.getExpenses();
        return expenses;
    }
}
