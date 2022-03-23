import { LightningElement } from 'lwc';
import getExpenses from "@salesforce/apex/EMExpenseController.getExpenses";


    const columns = [
        { label: 'Report', fieldName: "reportName"},
        { label: 'Expense', fieldName: "expenseName"},
        { label: 'Expense Status', fieldName: "expenseStatus"},
    ];

export default class EmReport extends LightningElement {

    data = [];
    columns= columns;

    async connectedCallback() {
        this.data = await getExpenses();
        console.log('data: ', this.data) ;
    }
}

