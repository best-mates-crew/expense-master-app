import { LightningElement, wire } from "lwc";
import getReports from "@salesforce/apex/EM_ReportController.getReports";

import { publish, MessageContext } from "lightning/messageService";
import RECORD_SELECTED_CHANNEL from "@salesforce/messageChannel/Record_Selected__c";

const columns = [
	{ label: "Report", fieldName: "name" },
	{ label: "Status", fieldName: "status" },
	{ label: "Total Amount", fieldName: "totalAmount" }
];

export default class EmAllReports extends LightningElement {
	data;
	columns = columns;

	@wire(MessageContext)
	messageContext;

	async connectedCallback() {
		this.data = await getReports();
		console.log("data: ", this.data);
	}

	getSelectedRows(event) {
		const rows = event.detail.selectedRows;

        const payload = { data : rows};
		publish(this.messageContext, RECORD_SELECTED_CHANNEL, payload);
	}

}
