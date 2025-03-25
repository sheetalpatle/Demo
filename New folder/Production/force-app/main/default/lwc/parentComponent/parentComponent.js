import { api, LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    lightManage;
    childComponent;
    // subjectnew = 'Maths';
    // handleChangeSubject(){
    //     console.log('changeSubject');
    //     this.subjectnew = 'Science';
    //     console.log('subjectnew', this.subjectnew);
    // handleTurnOn(){
    //     console.log('turnOn');
    //     this.lightManage = this.template.querySelector('c-child-component').TurnOn();
    //     console.log('lightManage', this.lightManage);
    // }
    // handleTurnOff(){
    //     console.log('turnOff');
    //     this.lightManage = this.template.querySelector('c-child-component');
    //     this.lightManage.TurnOff();
    //     console.log('lightManage', this.lightManage);
    // }
    handleSwich(event){
        const status = event.target.dataset.status;
        console.log('status', status);
        this.childComponent = this.template.querySelector('c-child-component');
        this.childComponent.toggleLight(status);
    }
}