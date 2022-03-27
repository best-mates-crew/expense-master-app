trigger EM_ExpenseTrigger on EM_Expense__c (before insert, before update, before delete, after insert, after update, after delete) {

    if(Trigger.isUpdate || Trigger.isInsert){
        EM_ReportController.recalculateReportsTotalAmount();
    }
}