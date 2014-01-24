package ru.kashaya.model {
    public class ExternalLink extends AbstractDataModel implements IContentDataModel {



        public var linkURL : String;

        public function ExternalLink(parent : IContentDataModel) {
            super (ContentDataModelFactory.LINK, parent);
        }

        override public function parseData(xml:XML):void
        {
            super.parseData(xml);

            linkURL = xml.@body.toXMLString();

        }
    }
}