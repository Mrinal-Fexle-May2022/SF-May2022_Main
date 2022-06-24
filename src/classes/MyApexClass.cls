//Cast the object to an integer
public class MyApexClass {
    public void ObjectMethod() {
        Object obj = 10;
        Integer i = (Integer)obj;
        System.assertEquals(obj,i);
        System.debug(i);
        
    }
    
	// Cast the object to the MyApexClass custom type
    public Static void CastObjectToClass(){
        Object obj = new MyApexClass();
        MyApexClass mc = (MyApexClass)obj;
        mc.ObjectMethod();
    }
    
    public Static void PrimitiveTypes() {
        Boolean isWinner = true;
        Double d=3.14159;
        ID id='00300000003T2PGAA0';
        Integer i = 1;
        Long l = 21475698452L;
        String s = 'The quick brown fox jumped over the lazy dog.';
    }
    
    //Date Class
    public Static void AddingDates(){
        date myDate = date.newInstance(1990, 11, 21);
        
        //Adding Days
    	date newDays = myDate.addDays(2);
        System.debug('Adding Two Days From (1990, 11, 17)' + newDays);
        
        //adding Months
        date newMonths = myDate.addMonths(3);
        date expectedDate = date.newInstance(1991, 2, 21);
        system.assertEquals(expectedDate, newMonths);
        System.debug('Adding Three Months From (1990, 11, 17)' + newMonths);
        
        //adding Years
        date newYears = myDate.addYears(2);
        System.debug('Adding Three Months From (1990, 11, 17)' + newYears);
        
        //check day
        Integer day = myDate.day();
        system.assertEquals(21,day);
        system.debug(day);
        
        //valueOf(stringDate)
        string year = '2008';
        string month = '10';
        string days = '5';
        string hour = '12';
        string minute = '20';
        string second = '20';
        string stringDate = year + '-' + month
         + '-' + days + ' ' + hour + ':' + 
        minute + ':' + second;
        
        Date myDates = date.valueOf(stringDate);
        system.debug(myDates);
        
    }
    
    public Static void DateTimeClass(){
        //addDays
        Datetime myDateTime = Datetime.newInstance(1960, 2, 17);
        Datetime newDateTime = myDateTime.addDays(2);
        Datetime expected = Datetime.newInstance(1960, 2, 19);
        System.assertEquals(expected, newDateTime);
    }

    public Static void StringClass() {
        String s = 'Hello Maximillian';
        String s2 = s.abbreviate(8);
        String s3 = s.abbreviate(9,6);
        String s4 = s.Capitalize();
        System.assertEquals('Hello...', s2);
        System.assertEquals(8, s2.length());
        
        System.debug(s2);
        System.debug(s3);
        System.debug(s4);

        //codePointAt(index)
        String str = '\u03A9 is Ω (Omega), and \uD835\uDD0A ' + 
                    ' is Fraktur Capital G.';
        System.assertEquals(937, str.codePointAt(0));
        System.assertEquals(120074, str.codePointAt(20));
        // Escaped or unescaped forms of the same character have the same code point
        System.assertEquals(str.codePointAt(0), str.codePointAt(5));
        
        System.debug(str);
    }
    
    static final Integer PRIVATE_INT_CONST = 200; // Using Static Keywords
    static final Integer PRIVATE_INT_CONST2;
    
    public Static Integer ApexConstants(){        
        return 2+7;
    }
    
    static {
        PRIVATE_INT_CONST2 = ApexConstants();
        System.debug(PRIVATE_INT_CONST2);
    }
    
}