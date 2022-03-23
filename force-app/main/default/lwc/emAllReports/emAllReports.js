import { LightningElement, wire } from "lwc";
import getReport from "@salesforce/apex/EMReportController.getReport";

import { publish, MessageContext } from "lightning/messageService";
import RECORD_SELECTED_CHANNEL from "@salesforce/messageChannel/Record_Selected__c";

const columns = [
	{ label: "Report", fieldName: "name" },
	{ label: "Status", fieldName: "status" }
];

export default class EmAllReports extends LightningElement {
	data;
	columns = columns;

	@wire(MessageContext)
	messageContext;

	async connectedCallback() {
		this.data = await getReport();
		console.log("data: ", this.data);
	}

	getSelectedRows(event) {
		const selectedRows = event.detail.selectedRows;
        
        const payload = { reportsInformation: selectedRows };
		publish(this.messageContext, RECORD_SELECTED_CHANNEL, payload);
	}

}
