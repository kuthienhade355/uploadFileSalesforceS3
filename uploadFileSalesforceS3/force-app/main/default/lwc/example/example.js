import { LightningElement , api} from 'lwc';
export default class Example extends LightningElement {
    @api name = 'Tran Minh Quan';
    changeHanler(event){
        this.name = event.target.value;
    }
}