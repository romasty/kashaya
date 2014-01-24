package ru.kashaya.model {
    import ru.kashaya.utils.HTMLStringUtil;

    public class TextDataModel extends AbstractDataModel implements IContentDataModel {


        private var _body : String;

        public function TextDataModel(parent : IContentDataModel) {
			super (ContentDataModelFactory.TEXT, parent)
        }



        override public function parseData(xml:XML):void
        {
            super.parseData(xml);

            var bodyXML : XML = xml.child("body")[0];
            if(bodyXML) {
                _body = HTMLStringUtil.getString(bodyXML.text());
               // _body = _body.replace("[br/]", "<br/>")
            }
        }


        public function get body():String {
            return _body;
        }
    }
}