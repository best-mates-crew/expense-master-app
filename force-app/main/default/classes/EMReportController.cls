public with sharing class EMReportController {
	// @AuraEnabled(cacheable=true)
	// public static List<ReportsListWrapper> gerReports() {
		
	// 	List<EM_Report__c> reportList = [
	// 		SELECT Name, (SELECT Name, EM_Reimbursement_Status__c FROM EM_Expenses__r)
	// 		FROM EM_Report__c
	// 		WITH SECURITY_ENFORCED
	// 	];

    //     List<ReportsListWrapper> reportsWrapperList = new List<ReportsListWrapper>();
 
    //         for(EM_Report__c rep : reportList){            
    //             String expenseName;
    //             String expenseStatus;
    //             String reportName = rep.Name;

    //         for(EM_Expense__c exp : rep.EM_Expenses__r){
    //             expenseName = exp.Name;
    //             expenseStatus = exp.EM_Reimbursement_Status__c;
    //         }
        

    //         ReportsListWrapper allRep = new ReportsListWrapper(reportName, expenseName, expenseStatus);
    //         reportsWrapperList.add(allRep);
    //     }
        
    //     return reportsWrapperList;
	// }

    @AuraEnabled(cacheable=true)
	public static List<ReportsListWrapper> gerReports() {
		
		List<EM_Expense__c> expensesList = [
			SELECT Name, EM_Reimbursement_Status__c, EM_Report__r.Name
			FROM EM_Expense__c
			WITH SECURITY_ENFORCED
		];

        List<ReportsListWrapper> expensesWrapperList = new List<ReportsListWrapper>();
 
            for(EM_Expense__c expense : expensesList){            
                String expenseName = expense.Name;
                String expenseStatus = expense.EM_Reimbursement_Status__c;
                String reportName = expense.EM_Report__r.Name;
        

            ReportsListWrapper allRep = new ReportsListWrapper(reportName, expenseName, expenseStatus);
            expensesWrapperList.add(allRep);
        }
        
        return expensesWrapperList;
	}

	class ReportsListWrapper {
		@AuraEnabled
		public String reportName { get; set; }
		@AuraEnabled
		public String expenseName { get; set; }
		@AuraEnabled
		public String expenseStatus { get; set; }

        ReportsListWrapper(String repName, String expName, String expStatus){
            reportName = repName;
            expenseName = expName;
            expenseStatus = expStatus;
        }
	}
}
