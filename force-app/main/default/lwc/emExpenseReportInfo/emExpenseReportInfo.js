import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import RECORD_SELECTED_CHANNEL from '@salesforce/messageChannel/Record_Selected__c';

export default class EmExpenseReportInfo extends LightningElement {
    subscription = null;
    _reportsInfo;

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel() {
        this.subscription = subscribe(
            this.messageContext,
            RECORD_SELECTED_CHANNEL,
            (message) => this.handleMessage(message)
            );
    }

    handleMessage(message) {
        this._reportsInfo = message;
        console.log('this.reportsInfo:', this.reportsInfo);
        console.log('message:', message);
    }
}

		// this._expensesInfo = this.selectedRows.map((e) => e.expenses.map((el) => " " + el.expenseName));
		// console.log('this._expensesInfo:', this._expensesInfo);