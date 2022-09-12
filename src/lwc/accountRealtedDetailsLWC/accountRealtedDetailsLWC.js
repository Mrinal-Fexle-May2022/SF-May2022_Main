import { LightningElement } from 'lwc';
import getAccountDetails from '@salesforce/apex/AccountRelatedDataLWC.getAccountDetails';
import getContactDetails from '@salesforce/apex/AccountRelatedDataLWC.getContactDetails';
import getOpportunityDetails from '@salesforce/apex/AccountRelatedDataLWC.getOpportunityDetails';
import getCaseDetails from '@salesforce/apex/AccountRelatedDataLWC.getCaseDetails';
export default class AccountRealtedDetailsLWC extends LightningElement {
    accountTable;
    contactTable;
    opportunityTable;
    caseTable;
    recordId = '';

    searchRecordId(event){
        this.recordId = event.target.value;
    }

    searchAccountId(){
        if(this.recordId !== ''){

            getAccountDetails({
                recordKey: this.recordId
            })
            .then(result => {
                this.accountTable = result;
                getContactDetails({
                    recordKey: this.recordId
                })
                .catch(error =>{
                    this.error= error;
                })
                .then(result1 => {
                    this.contactTable = result1;
                    getOpportunityDetails({
                        recordKey: this.recordId
                    })
                    .catch(error =>{
                        this.error= error;
                    })
                    .then(result2 => {
                        this.opportunityTable = result2;
                        getCaseDetails({
                            recordKey: this.recordId
                        })
                        .catch(error =>{
                            this.error= error;
                        })
                        .then(result3 => {
                            this.caseTable = result3;
                        })
                        .catch(error =>{
                            this.error= error;
                        })

                    })
                })
            })
        } 
    }
}