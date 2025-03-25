import {LightningElement, api, wire, track} from 'lwc';
import getRelatedContacts from '@salesforce/apex/ContactController.getRelatedContacts';
import updateContacts from '@salesforce/apex/ContactController.updateContacts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import{refreshApex} from '@salesforce/apex';
const columns = [
    { label: 'First Name', fieldName: 'FirstName',editable: true },
    { label: 'Last Name', fieldName: 'LastName',editable: true },
    { label: 'Phone', fieldName: 'Phone',editable: true },
    { label: 'Email', fieldName: 'Email',editable: true }
];
export default class AccountReletedContacts extends LightningElement {
    @api recordId; 
    @track contacts; 
    error;
    @track draftValues = []; 
    @track columns = columns; 
    @track wireResult;
    @track selectedRow = [];
    @wire(getRelatedContacts, { accountId: '$recordId' })
    wiredContacts({ data, error }) {
        if (data) {
            this.contacts = data; 
            this.wireResult = data;
            this.error = undefined; 
        } else if (error) {
            this.contacts = undefined; 
            console.error('Error retrieving contacts:', error); 
            this.error = error.body.message; 
        }
    }
    handleSave(event) {
        let draftValues = event.detail.draftValues;
        //call apex method to call update records //
        updateContacts({ contacts: draftValues })
            .then(() => {
                //this.ShowToast('Success','Contact Update','success')
                //let draftValues = [];
                console.log('draftValues', draftValues);
                // let temp = this.contacts.filter(x=> draftValues.map(x=>x.Id).includes(x.Id));
                // temp.forEach((record) => {
                //     let drftRec = draftValues.find(x=> x.Id == record.Id);
                //     record.FirstName = drftRec.FirstName?drftRec.FirstName: record.FirstName;
                //     record.LastName = drftRec.LastName?drftRec.LastName: record.LastName;
                //     record.Phone = drftRec.Phone?drftRec.Phone: record.Phone;
                //     record.Email = drftRec.Email?drftRec.Email: record.Email;
                // });
                // this.contacts = [...temp];
                this.contacts = this.contacts.map(record => {
                    
                    let drftRec = draftValues.find(x => x.Id === record.Id);

                    // If a draft record is found, update the fields
                    if (drftRec) {
                            return {
                            ...record,
                            FirstName: drftRec.FirstName || record.FirstName,
                            LastName: drftRec.LastName || record.LastName,
                            Phone: drftRec.Phone || record.Phone,
                            Email: drftRec.Email || record.Email
                        };
                    }

                    return record; 
                });
                this.draftValues = [];
                this.ShowToast('Success','Contact Update','success');
            })
            .catch(error => {
                this.ShowToast('Error',error,'error');
            });
    }
    handleRowSelection(event){
        this.selectedRow = event.detail.selectedRows;
        console.log('selectedRow',this.selectedRow);
    }
    handleDelete(){
        if (this.selectedRow.length === 0) {
            this.ShowToast('Error', 'You need to select at least one record to delete', 'error');
            return;
        }
        const deleteEvent = new CustomEvent('delete', {
            detail: this.selectedRow.map(row => row.Id) // Send only the IDs of selected rows
        });
        this.dispatchEvent(deleteEvent);
    }
    
    @api refreshData() {
        console.log('Refreshing data in child component...');
        
        getRelatedContacts({ accountId: this.recordId })
            .then((data) => {
                // Update the contacts list with the new data
                this.contacts = data;
                console.log('Contacts refreshed:', this.contacts);
            })
            .catch((error) => {
                // Show a toast message if there is an error fetching the data
                this.showToast('Error', 'Error refreshing contacts data.', 'error');
                console.error('Error refreshing data:', error);
            });
    }
    ShowToast(title,message,variant){
        this.dispatchEvent(new ShowToastEvent({title,message,variant}));
    }
}