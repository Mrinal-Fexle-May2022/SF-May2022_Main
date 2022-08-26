@isTest
private class MixedDMLFutureTest {
    @isTest static void test1() {
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        
        System.runAs(thisUser) {
            Test.startTest();        
            MixedDMLFuture.useFutureMethod();
            Test.stopTest();
        }
        
        Account[] accts = [SELECT Id from Account WHERE Name='Acme'];
        System.assertEquals(1, accts.size());
        User[] users = [SELECT Id from User where username='mruiz562@awcomputing.com'];
        System.assertEquals(1, users.size());
    }
}