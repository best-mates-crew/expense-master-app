import { LightningElement } from 'lwc';
import getReports from "@salesforce/apex/EMReportController.gerReports";


    const columns = [
        { label: 'Report', fieldName: "reportName"},
        { label: 'Expense', fieldName: "expenseName"},
        { label: 'Status', fieldName: "expenseStatus"}
    ];

export default class EmReport extends LightningElement {

    data = [];
    columns= columns;

    async connectedCallback() {
        this.data = await getReports();
        console.log('data: ', this.data) ;
    }


}