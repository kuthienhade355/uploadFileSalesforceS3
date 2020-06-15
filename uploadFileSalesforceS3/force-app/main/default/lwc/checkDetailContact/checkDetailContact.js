import { LightningElement, track, api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import readCSV from '@salesforce/apex/LWCExampleController1.getAccountDetail';
const columns = [
    { label: 'Name', fieldName: 'Name' }, 
    { label: 'Industry', fieldName: 'Industry' },
    { label: 'Rating', fieldName: 'Rating'}, 
    { label: 'Type', fieldName: 'Type'}, 
    { label: 'Website', fieldName: 'Website', type:'url'}
];
export default class CheckDetailContact extends LightningElement {
    @api recordId;
    @track error;
    @track columns = columns;
    @track data;
    @track dataDetail;

    connectedCallback(){
    readCSV()
        .then(result => {
            window.console.log('result ===> '+result);
            this.data = result;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success!!',
                    message: 'Accounts are created based CSV file!!!',
                    variant: 'success',
                }),
            );
        })
        .catch(error => {
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error!!',
                    message: JSON.stringify(error),
                    variant: 'error',
                }),
            );     
        })
    }

    getSelectedName(event) {
        const selectedRows = event.detail.selectedRows;
        // Display that fieldName of the selected rows
        for (let i = 0; i < selectedRows.length; i++){
            // alert("You selected: " + selectedRows[i].Id);
            this.dataDetail = selectedRows[i].Id;
        }
    }
}