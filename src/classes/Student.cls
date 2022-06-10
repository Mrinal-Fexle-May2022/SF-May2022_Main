public class Student {
    public static void insertStudent() {
        Student__c student1 = new Student__c();

        // Student Personal Info
        student1.Roll_Number__c = 025;
		student1.Name = 'Tom Hamilton';
        student1.Phone_Number__c = '23587456228';
        student1.Father_Name__c = 'Mr. Hamilton';
        student1.Father_Mobile_Number__c = '65895231558';
        student1.Mobile_Number__c = '65823256455';
		student1.Overall_Grade__c = 'B';
		student1.Email__c = 'htom326@gmail.com';
        student1.Address__c = 'Hemilton Street NY - 26587';

        // Fees Details
		student1.Exam_Fees_Submitted__c = true;
        student1.Fees_Submitted__c = true;
        student1.Pending_Fees_Amount__c = 0;
        student1.Pending_Exam_Fees__c = 0;
        student1.Is_Donation__c = false;
        student1.X1st_Sem_Back__c = false;

        // Semester Details
        student1.Stream__c = 'Science';
        student1.Class__c = '12';
        student1.Section__c = 'A';
        student1.Current_Year__c = '4th Year';
        student1.X1st_Sem_Percentage__c = 70;
        student1.X2nd_Sem_Percent__c = 65;
        student1.X3rd_Sem_Back__c = false;
        student1.X4th_Sem_Back__c = false;
        student1.X4th_Sem_Percentage__c = 85;

        //Bank Details
        student1.Subjects_in_Which_Back__c = 'N/A';
        student1.Subjects_in_Which_Back_3rd_sem__c = 'N/A';
        student1.Subjects_in_Which_Back_4th_sem__c = 'N/A';
        student1.Bank_Name__c = 'Am Bank';
        student1.IFSC_Code__c = 'amcb12658';
        student1.Account_Number__c = 925658; 
        student1.City__c = 'New York';
        student1.State__c = 'New York';

        insert student1;
        
        List<Student__c>studentList = [select Id, Name, Roll_Number__c, Overall_Grade__c, Email__c, Exam_Fees_Submitted__c, Address__c, Stream__c, Class__c,
                                       Section__c, Current_Year__c, Fees_Submitted__c, Is_Donation__c from Student__c limit 5];
        for(Student__c studentdata : studentList) {
        system.debug('check Student Data :::' + studentdata);
        }
    }
}