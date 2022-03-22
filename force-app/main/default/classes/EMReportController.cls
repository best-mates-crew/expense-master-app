public with sharing class EMReportController {
	@AuraEnabled(cacheable=true)
	public static List<ReportsListWrapper> gerReports() {
		
		List<EM_Report__c> reportList = [
			SELECT Name, (SELECT Name, EM_Reimbursement_Status__c FROM EM_Expenses__r)
			FROM EM_Report__c
			WITH SECURITY_ENFORCED
		];

        List<ReportsListWrapper> reportsWrapperList = new List<ReportsListWrapper>();
        for(Integer i = 0; i < reportList.size(); i++){
            
            // for(EM_Report__c rep : reportList){
            
            String expenseName;
            String expenseStatus;
            String reportName = reportList[i].Name;

            for(EM_Expense__c exp : rep.EM_Expenses__r){
                expenseName = exp.Name;
                expenseStatus = exp.EM_Reimbursement_Status__c;
            }
        

            ReportsListWrapper allRep = new ReportsListWrapper(reportName, expenseName, expenseStatus);
            reportsWrapperList.add(allRep);
        }
        // }
        return reportsWrapperList;
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
