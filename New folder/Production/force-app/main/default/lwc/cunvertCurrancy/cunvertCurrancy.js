import { LightningElement,api,track} from 'lwc';
import getCurrencySymbols from '@salesforce/apex/CurrencyConverterController.getCurrencySymbols';
import getLatestRate from '@salesforce/apex/CurrencyConverterController.getLatestRate';

export default class CunvertCurrancy extends LightningElement {
    @track currencyOptions = [];
    @track fromValue;
    @track toValue;
    @track latestRate;
    @track amount = 1;
    @track baseAmount;
    connectedCallback(){
        console.log('connectedCallback');
        this.fetchCurrencySymbole();
    }
    fetchCurrencySymbole(){
        console.log('fetchCurrencySymbole');
        getCurrencySymbols()
        .then(result =>{            
            console.log('result',result);
            this.currencyOptions = result.map(currency=>{
                const [symbol, name] = currency.split('-');
                return { label: `${symbol} - ${name}`, value: symbol};

            });
            // if(this.currencyOptions.length > 0){
            //     this.fromValue = this.currencyOptions[0].value;
            //     this.toValue = this.currencyOptions[1].value;
            // }
        })
        .catch(error =>{
            console.log(error);

        })

    }
    handleFromChange(event) {
        this.fromValue = event.target.value;

    }
    handleAmountChange(event) {
        this.amount = event.target.value;
    }
    handleToChange(event) {
        this.toValue = event.target.value;
    }
    handleLatestRateClick(){
        console.log('handleLatestRateClick');
        getLatestRate({fromCurrency :this.fromValue, toCurrency: this.toValue, amount: this.amount})
        .then(result =>{
            this.latestRate = result.convertedAmount;
            this.baseAmount = result.baseAmount;
        })
         .catch(error =>{
            console.log(error);
        })
    }
    // testing
    // testing
    // testning
    
}