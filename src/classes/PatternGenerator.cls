public with sharing class PatternGenerator {

    //1. Left Triangle Printing pattern
    public static void createLeftTriangle(){
        for (Integer i = 1; i<=5; i++){
            String s = ' ';

            for (Integer j =1 ; j<=5; j++){
                if (j >= 6-i) {

                    s = s + '*';
                }

                else {
                    s = s + '_';
                }
            }

            System.debug(s);
        }
    }

    //2. Downward Traingle Printing pattern
    public static void createDownwardTraingle(){
        for (Integer i=1; i<=5; i++){
            String s = ' ';

            for (Integer j=1; j<=5; j++){
                if(j>6-i){
                    s = s + '_';
                }

                else{
                    s = s + '*';
                }
            }

            System.debug(s);
        }
    }

    //3. Reversed Pyramid Printing Pattern
    public static void createReversedPyramid(){
        for(Integer i=1; i<= 5; i++){
            String s = ' ';

            for (Integer j=1; j<= 5 ; j++){

                if (j >= i){
                    s = s + '*_';
                }
                 
                else {
                    s = s + '_';
                 }
            }

            System.debug(s);
        }
    }

    // 4. Pyramid Printing Pattern
    public static void createPyramid(){
        for (Integer i =1; i<=5; i++){
            String s = ' ';

            for (Integer j=1; j<=5; j++){
                if (j >= 6-i){
                    s = s + '*_';
                }

                else {
                    s = s+ '_';
                }
            }

            System.debug(s);
        }
    }

    //5. Left Pascal's Triangle  Printing Pattern
    public static void createLeftPascalTriangle(){
        Integer k =6;
        for (Integer i=1; i<= 9; i++){

            if(i<=5){
                k--;
            }
            else {
                k++;
            }

            String s = ' '; 

            for (Integer j=1; j<= 5; j++){
                if (j >=k){
                    s = s + '*';
                }

                else {
                    s = s + '_';
                }
            }

            System.debug(s);
        }
    }

    // 6. Triangle Printing Pattern
    public static void createTriangle(){

        for (Integer i=1; i<=5; i++){
            String s = ' ';
            for(Integer j=1; j<=(5-i); j++){
                s = s+ '_';
            } 
            
            for (Integer k=1; k<=2*i-1; k++){
                if(k==1|| k== 2*i-1 || i==5){
                    s = s + '*';
                } else {
                    s = s + '_';
                }
            }
            
            System.debug(s);
        }
    }

    // 7. Down Triangle Printing Pattern
    public static void createDownTriangle(){

        for (Integer i=5; i>=1; i--){
            String s = ' ';
            for(Integer j=1; j<=(5-i); j++){
                s = s+ '_';
            } 
            
            for (Integer k=1; k<=2*i-1; k++){
                if(k==1|| k== 2*i-1 || i==5){
                    s = s + '*';
                } else {
                    s = s + '_';
                }
            }
            
            System.debug(s);
        }
    }
}