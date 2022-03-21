import { LightningElement } from 'lwc';
import getReports from "@salesforce/apex/EMReportController.gerReports";


    const columns = [
        { label: 'Report', fieldName: "reportName"},
        { label: 'Expense', fieldName: "expenseName"},
    ];

export default class EmReport extends LightningElement {

    data = [];

    async connectedCallback() {
        this.data = await getReports();
        console.log('data: ', this.data) ;
    }
    


}