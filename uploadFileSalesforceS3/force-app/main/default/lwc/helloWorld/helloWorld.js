import { LightningElement, track } from 'lwc';
export default class HelloWorld extends LightningElement {
    @track isTrueTemplate = false;
    greeting = 'Tran minh Quan lose your eyes';
    @track lastName = 'Tran';
    contacts = [
        {
            Id: 'M',
            Name: 'Amy Taylor',
            Title: 'COO',
           
        },
        {
            Id: 'G',
            Name: 'Michael Jones',
            Title: 'CTO',
           
        },
        {
            Id: 'C',
            Name: 'Jennifer Wu',
            Title: 'CEO',
            
        },
    ];

    changeHandler(event) {
        this.greeting = event.target.value;
    }
    changeHandler1(event){
        this.lastName = event.target.value;
    }
    get propertyName() {
        return 1;
    }
        firstName = 'Web';
        version = '47.0' ;
    get uppercasedFullName() {
        const fullName = `${this.firstName} ${this.lastName} ${this.version}`;
        // eslint-disable-next-line no-unused-expressions
        this.lastName === 'Tran Minh Quan' ? this.isTrueTemplate = true : this.isTrueTemplate =false;
        return fullName.trim().toUpperCase();
    }
           
        
}