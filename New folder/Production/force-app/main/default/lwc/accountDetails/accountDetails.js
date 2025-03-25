import { api, LightningElement,wire } from 'lwc';
import getAccountDetails from '@salesforce/apex/AccountDetailsHandler.getAccountDetails';
import updateAccountDetails from '@salesforce/apex/AccountDetailsHandler.updateAccountDetails';
export default class AccountDetails extends LightningElement {
    account;
    error;
    @api recordId;
    accountName;
    rating;
    type;
    industry;
    contactPhone;
    isEditMode = false;
    ratingOptions = [
    { label: 'Hot', value: 'Hot' },
    { label: 'Warm', value: 'Warm' },
    { label: 'Cold', value: 'Cold' },
   ];

    @wire(getAccountDetails,{accountId:'$recordId'})
    getAccounts({error,data}){
        if(data){
            this.account = data;
            this.accountName = data.Name;
            this.rating = data.Rating;
            this.type = data.Type;
            this.industry = data.Industry;
            this.contactPhone = data.Contacts && data.Contacts.length > 0 ? data.Contacts[0].Phone : 'No Contact Phone';  // Get the Contact's Phone
        }else if(error){
            this.error = error;
            this.account = null;
        }
    }

    handleEditClick(){
        console.log('Edit Clicked');
        this.isEditMode = true;
    }
    handleInputChange(event) {
    this.rating = event.target.value; 
    }
    handleSaveClick() {
    console.log('Save Clicked');
    updateAccountDetails({
        accountId: this.recordId,
        accountName: this.accountName,
        rating: this.rating,  // Ensure this is the updated rating value
        type: this.type,
        industry: this.industry,
        phone: this.contactPhone  
    })
    .then((updatedAccount) => {
        this.account = updatedAccount;
        console.log(this.account);  // Verify updated account
        this.isEditMode = false;
    })
    .catch((error) => {
        this.error = error.body.message;
    });
}

}