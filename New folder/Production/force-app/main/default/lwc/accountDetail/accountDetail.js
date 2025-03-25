// accountDetail.js
import { LightningElement, api, track, wire } from 'lwc';
import getAccountDetails from '@salesforce/apex/AccountController.getAccountDetails';
import updateAccount from '@salesforce/apex/AccountController.updateAccount';
import deleteContacts from '@salesforce/apex/AccountController.deleteContacts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';

export default class AccountDetail extends LightningElement {
    @api recordId;
    @track account;
    @track isEditMode = false;
    @track originalAccount;
    @track ratingOptions = [];
    @track typeOptions = [];
    @track industryOptions = [];
    @track contactPhone;
    @track showModal = false;
    @track modalMessage = '';
    @track modalButtonLabel = '';
    @track modalHeader = '';
    @track modalActionType = '';
    @track showModal = false;
    @track isSave = false;
    @track isEdited = false; 

    @wire(getAccountDetails, { accountId: '$recordId' })
    wiredAccount({ error, data }) {
        if (data) {
            this.account = { ...data };
            console.log('wiredAccount',data);
            this.originalAccount = { ...data };
            console.log('Contacts:', this.account.Contacts);
            if(this.account.Contacts && this.account.Contacts.length > 0) {
               this.contactPhone = this.account.Contacts[0].Phone;
                
            }else{
                console.log('No contacts found');
            }
            
        } else if (error) {
            this.showToast('Error', 'Error fetching account details', 'error');
        }
    }

    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: RATING_FIELD })
    wiredPicklistValues({ error, data }) {
        if (data) {
            this.ratingOptions = data.values;
        } else if (error) {
            this.showToast('Error', 'Error loading rating picklist values', 'error');
        }
    }
    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: TYPE_FIELD })
    wiredTypePicklistValues({ error, data }) {
        if (data) {
            this.typeOptions = data.values;
        } else if (error) {
            this.showToast('Error', 'Error loading type picklist values', 'error');
        }
    }
    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: INDUSTRY_FIELD })
    wiredIndustryPicklistValues({ error, data }) {
        if (data) {
            this.industryOptions = data.values;
        } else if (error) {
            this.showToast('Error', 'Error loading Industry picklist values', 'error');
        }
    }
    handleEdit() {
        this.isEditMode = true;
    }

    handleCancelClick() {
        this.modalMessage = 'Are you sure you want to cancel the changes?';
        this.modalButtonLabel = 'Cancel';
        this.modalHeader = 'Confirm Cancel';
        this.modalActionType = 'cancel';  
        this.showModal = true; 
        this.isSave = false;
    }

    handleChange(event) {
        const field = event.target.name;
        this.account[field] = event.target.value;

        if(JSON.stringify(this.account) !== JSON.stringify(this.originalAccount)) {
            this.isEdited = true;
        }else{
            this.isEdited = false;
        }
      }
    handleModalClose(){
        this.showModal = false;
    }
    handleSaveClick(){
        // handele boolean for modal buttons
        this.modalMessage = 'Are you sure you want to save the account?';
        this.modalButtonLabel = 'Save';
        this.modalHeader = 'Confirm Save';
        this.modalActionType = 'save';
        this.showModal = true; 
        this.isSave = true;
    }
    handleModalAction() {
        if (this.modalActionType === 'save') {
            this.handleConfirmSave();

        } else if (this.modalActionType === 'cancel') {
            this.handleConfirmCancel();
        }
        this.showModal = false;  // Close the modal
    }
    handleConfirmSave() {
        updateAccount({ account: this.account })
            .then(() => {
                this.showToast('Success', 'Account updated successfully', 'success');
                this.isEditMode = false;
                this.originalAccount = { ...this.account };
                this.isEdited = false;
            })
            .catch(() => {
                this.showToast('Error', 'Error updating account', 'error');
            });
             this.showModal = false;
    }
    handleConfirmCancel(){
        this.account = { ...this.originalAccount };
        this.isEditMode = false;
        this.isEdited = false;

    }
    handleDeleteRecords(event){
        const selectedRecordIds = event.detail;
        console.log('selectedRecordIds',selectedRecordIds);

        if(selectedRecordIds.length >0) {
            deleteContacts({contactIds : selectedRecordIds})
                .then(() => {
                    this.showToast('Success', 'Contacts deleted successfully', 'success');
                        this.refreshChildData();
                })
                .catch(() => {
                    this.showToast('Error', 'Error deleting contacts', 'error');
                });
        }
    }
    refreshChildData() {
        // Find the child component and refresh its data
        const childComponent = this.template.querySelector('c-account-related-contacts');
        if (childComponent) {
            childComponent.refreshData();  // Call a method on the child to refresh data
        }
    }
    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}