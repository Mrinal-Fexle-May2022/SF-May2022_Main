public class MixedDMLFuture {
    public static void useFutureMethod() {
        // First DML operation
        Account a = new Account();
        a.Name = 'Acme';
        a.Email__c = 'dfda123@gmail.com';
        a.IFSC_Code__c = '5845620';
        a.Phone = '6258710';
        a.Type = 'FD Account';
        insert a;
        
        Util.insertUserWithRole(
            'mruiz562@awcomputing.com', 'mruiz', 
            'mruiz562@awcomputing.com', 'Ruiz');        
    }
}