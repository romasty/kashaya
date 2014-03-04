package ru.kashaya.utils {
    public class HTMLStringUtil {
        public static function getString(source : String) : String
        {
            var k : int

            /*while(source.indexOf("[br/]") != -1) {
                source = source.replace("[br/]", "<br/>")
            }*/
			while(source.indexOf("[") != -1) {
				source = source.replace("[", "<")
			}

			while(source.indexOf("]") != -1) {
				source = source.replace("]", ">")
			}

            return source;
        }
    }
}