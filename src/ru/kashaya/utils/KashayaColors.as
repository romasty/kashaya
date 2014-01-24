package ru.kashaya.utils {
    public class KashayaColors {


        public static const COLOR_1:uint = 0x29A89B;
        public static const COLOR_2:uint = 0x60D8CF;
        public static const COLOR_3:uint = 0xC97E6F;
        public static const COLOR_4:uint = 0xEFE0BF;
        public static const COLOR_5:uint = 0xB3F4F1;

        public static const SECOND_COLOR_1:uint = 0x209183;
        public static const SECOND_COLOR_2:uint = 0x4ABAAF;
        public static const SECOND_COLOR_3:uint = 0xC97E6F;
        public static const SECOND_COLOR_4:uint = 0xEFE0BF;
        public static const SECOND_COLOR_5:uint = 0xB3F4F1;

        public static const GRAY_1:uint = 0xB2B2B2;
        public static const GRAY_2:uint = 0x514F4F;
        public static const GRAY_3:uint = 0x666666;


        public static function getColor(colorId:String):uint {

            switch (colorId) {
                
                case "c1" :  return KashayaColors.COLOR_1;
                case "c2" :  return KashayaColors.COLOR_2;
                case "c3" :  return KashayaColors.COLOR_3;
                case "c4" :  return KashayaColors.COLOR_4;
                case "c5" :  return KashayaColors.COLOR_5;

                case "sc1" :  return KashayaColors.SECOND_COLOR_1;
                case "sc2" :  return KashayaColors.SECOND_COLOR_2;
                case "sc3" :  return KashayaColors.SECOND_COLOR_3;
                case "sc4" :  return KashayaColors.SECOND_COLOR_4;
                case "sc5" :  return KashayaColors.SECOND_COLOR_5;

                case "g1" :  return KashayaColors.GRAY_1;
                case "g2" :  return KashayaColors.GRAY_2;
                case "g3" :  return KashayaColors.GRAY_3;
            }

            return 0;
        }
    }
}