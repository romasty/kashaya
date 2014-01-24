package ru.kashaya.model {
    import ru.kashaya.resources.Resources;


    public class PictureDataModel extends AbstractDataModel implements IContentDataModel {




        public var previewUrl : String;
        public var picUrl : String;

        public function PictureDataModel(parent : IContentDataModel) {
			super (ContentDataModelFactory.PICTURE, parent);
        }


        override public function parseData(xml:XML):void
        {
            super.parseData(xml);

            previewUrl = Resources.PIC_PATH + xml.@preview.toXMLString();
            picUrl = Resources.PIC_PATH + xml.@src.toXMLString();

        }
    }
}