import { LightningElement } from 'lwc';
import getReport from "@salesforce/apex/EMReportController.getReport";

const columns = [
    { label: 'Report', fieldName: "name"},
    { label: 'Status', fieldName: "status"},
];

export default class EmAllReports extends LightningElement {

    data = [];
    columns= columns;

    async connectedCallback() {
        this.data = await getReport();
        console.log('data: ', this.data) ;
    }
}