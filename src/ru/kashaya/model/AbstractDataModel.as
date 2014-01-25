package ru.kashaya.model {
    import ru.kashaya.utils.HTMLStringUtil;
    import ru.kashaya.utils.KashayaColors;

    public class AbstractDataModel implements IContentDataModel {

        protected var _id:String;
        protected var _type:String;

		private var _parent : IContentDataModel;

        protected var _title:String;
        private var _style:Object = new Object();

		private var _menuData : MenuItemData = new MenuItemData();

        public function AbstractDataModel(type : String, parent : IContentDataModel) {
			_type = type;
			_parent = parent;
        }




        public function get id():String {
            return _id;
        }

        public function get type():String {
            return _type;
        }

		public function get parent():IContentDataModel
		{
			return _parent;
		}

		public function get title():String {
            return _title;
        }

        public function parseData(xml:XML):void {
            _id = xml.@id.toXMLString();

            var titleXML:XML = xml.child("title")[0];
            if (titleXML) {
                _title = HTMLStringUtil.getString(titleXML.text());
                //_title = _title.replace("[br/]", '<br/>');
                parseStyle(titleXML)
            }

			var menuXML : XML = xml.menu[0];
			if(menuXML) _menuData.parseData(menuXML);
            trace("TITLE:", _title, xml.name())

        }


		public function get menuData():MenuItemData
		{
			return _menuData;
		}

		private function parseStyle(titleXML:XML):void {

            var colorId:String = titleXML.@color.toXMLString();
            if (colorId != null && colorId != "") {
                if (isNaN(Number(colorId))) {
                    _style.color = KashayaColors.getColor(colorId);
                } else {
                    _style.color = Number(colorId);
                }
            }




            var secondColorId:String = titleXML.@color2.toXMLString();
            if (secondColorId != null && secondColorId != "") {
                if (isNaN(Number(secondColorId))) {
                    _style.secondColor = KashayaColors.getColor(secondColorId);
                } else {
                    _style.secondColor = Number(secondColorId);
                }
            }
        }


        public function get style():Object {
            return _style;
        }


    }
}