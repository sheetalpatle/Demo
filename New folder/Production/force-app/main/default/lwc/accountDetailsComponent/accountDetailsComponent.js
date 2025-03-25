import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class AccountDetailsComponent extends LightningElement {
    @api recordId; // The record ID passed to the component

    // Handle the success of saving the record
    handleSaveSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: 'Success',
            message: 'Account details updated successfully',
            variant: 'success',
        });
        this.dispatchEvent(toastEvent);
    }

    // Handle the cancel button click
    handleCancel() {
        // Optionally, refresh the page or reset data if needed
        console.log('Cancel clicked');
    }
}