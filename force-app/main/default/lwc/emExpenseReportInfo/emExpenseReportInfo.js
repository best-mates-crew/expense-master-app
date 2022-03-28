import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import RECORD_SELECTED_CHANNEL from '@salesforce/messageChannel/Record_Selected__c';

export default class EmExpenseReportInfo extends LightningElement {
    subscription = null;
    reportsInfo;
    reportDetail;
    selectedReportsAmount;


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
        this.reportsInfo = message.data;
        console.log('this.reportsInfo', this.reportsInfo);
        this.selectedReportsAmount = this.reportsInfo.reduce((a, b)=> a + b.totalAmount, 0);
    }


}

