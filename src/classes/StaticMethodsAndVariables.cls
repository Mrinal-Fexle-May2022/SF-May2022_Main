/**
*  Description     :  Static and Instance Methods, Variables, and Initialization Code
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/27/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

public with sharing class StaticMethodsAndVariables {
    public static boolean firstRun = true;

/**
*  Description     :  Using Instance Methods and Variables. The following skeleton class uses member variables 
*                     to hold the list of points and an inner class to manage the two-dimensional list of points.
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/27/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/
    class Point {
        Double x;
        Double y;

        Point(Double x, Double y) {
             this.x = x;
             this.y = y;
        }

    /**
     * 
     *   @description    :   Returns The Value of x
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

        Double getXCoordinate() {
             return x;
        }

    /**
     * 
     *   @description    :   Returns the Value of Y
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

        Double getYCoordinate() {
             return y;
        }
    }

    List<Point> points = new List<Point>();

    /**
     * 
     *   @description    :   Adding Points to the list
     *
     *   @args           :   
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 06/27/2022 - Mrinal Das
     *		              
     * 
     **/

    public void plot(Double x, Double y) {
        points.add(new Point(x, y));
    }

/**
*  Description     :  Using Initialization Code
*
*  Created By      :  Mrinal Das
*
*  Created Date    :  06/27/2022
*
*  Revision Logs   :    V1.0 - Created - Mrinal Das
*				    
*
**/

    class RGB {

        Integer red;
        Integer green;
        Integer blue;

        RGB(Integer red, Integer green, Integer blue) {
            this.red = red;
            this.green = green;
            this.blue = blue;
        }
     }

   static Map<String, RGB> colorMap = new Map<String, RGB>();

   //Static initialization code is a block of code preceded with the keyword static.

    static {
        colorMap.put('red', new RGB(255, 0, 0));
        colorMap.put('cyan', new RGB(0, 255, 255));
        colorMap.put('magenta', new RGB(255, 0, 255));
    }
}