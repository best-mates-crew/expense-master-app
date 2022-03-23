import { LightningElement } from 'lwc';
import getReport from "@salesforce/apex/EMReportController.getReport";

const columns = [
    { label: 'Report', fieldName: "name"},
    { label: 'Status', fieldName: "status"},
];

export default class EmAllReports extends LightningElement {

    data;
    columns= columns;
    selectedRows;
    expenseName;
    expenseStatus;
    

    async connectedCallback() {
        this.data = await getReport();
        console.log('data: ', this.data) ;
    }

    getSelectedRows(event){
        const rows = event.detail.selectedRows;
        this.selectedRows = JSON.parse(JSON.stringify(rows));
        console.log('this.selectedRows:',JSON.parse(JSON.stringify(rows))); 
        
        this.expenseName = this.selectedRows.map(e => e.expenses.map(el => " " + el.expenseName ));
        this.expenseStatus = this.selectedRows.map(e => e.expenses.map(el => el.expenseStatus));
        console.log('this.expenseName:', this.expenseName);
    }

}