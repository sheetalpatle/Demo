import { LightningElement,api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api lightSatus = 'off';
    // @api TurnOn(){
    //     this.lightSatus = 'on';

    // }
    // @api TurnOff(){
    //     this.lightSatus = 'off';
    // }
    @api toggleLight(status){
        this.lightSatus = status;
        console.log('lightSatus', this.lightSatus);
    }
}