package ru.kashaya.utils {
    public class HTMLStringUtil {
        public static function getString(source : String) : String
        {
            var k : int

            while(source.indexOf("[br/]") != -1) {
                source = source.replace("[br/]", "<br/>")

                /*k++
                if(k>1000) {
                    break;
                }*/

                //trace("sssssssssssssssssssssssssssss", k)
            }

            return source;
        }
    }
}