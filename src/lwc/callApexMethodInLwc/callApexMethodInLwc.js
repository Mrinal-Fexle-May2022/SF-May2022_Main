import { LightningElement} from 'lwc';
import getTextMethod1 from '@salesforce/apex/ReturnStringToClientSide.getTextMethod1';
import getTextMethod2 from '@salesforce/apex/ReturnStringToClientSide.getTextMethod2';
import getTextMethod3 from '@salesforce/apex/ReturnStringToClientSide.getTextMethod3';
export default class CallApexMethodInLwc extends LightningElement {

    message1;
    message2;
    message3;


    handleClick(){

        getTextMethod1()
        .then(result1 => {
            this.message1 = 'Method1 result: ' + result1;

            getTextMethod2()
            .then(result2 => {
                this.message2 = 'Method2 result: ' + result1 + " " + result2;
                
                getTextMethod3()
                .then(result3 => {
                    this.message3 = 'Method3 result: ' + result1 + " " + result2+ " " + result3
                })
            })
        })
    }

}