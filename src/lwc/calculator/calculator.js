import { LightningElement, track} from 'lwc';
export default class Calculator extends LightningElement {
    firstNumber;
    secondNumber;
    total;

    handleClickOne(event) {
        this.firstNumber = parseInt(event.target.value);
    }
    handleClickTwo(event){
        this.secondNumber = parseInt(event.target.value);
    }

    addition(){
        this.total = this.firstNumber + this.secondNumber;
    }
    subtraction(){
        this.total = this.firstNumber - this.secondNumber;
    }
    multiplication(){
        this.total = (this.firstNumber * this.secondNumber).toFixed(2);
    }
    division(){
        this.total = (this.firstNumber / this.secondNumber).toFixed(2);
    }
}