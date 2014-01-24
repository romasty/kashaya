package ru.kashaya.resources {

	import ru.plod.assets.SmartResourceStorage;

	public class Resources {

        public static const DATA_PATH : String = "data/data.xml";

        public static const PIC_PATH : String = "pics/";

        //public static var storage : SourceStorage = new SourceStorage();
        public static var storage : SmartResourceStorage = new SmartResourceStorage();
    }
}