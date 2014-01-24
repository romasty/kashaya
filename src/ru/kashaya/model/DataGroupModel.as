package ru.kashaya.model {
    import flash.utils.Dictionary;

    public class DataGroupModel extends AbstractDataModel implements IContentDataModel {


        protected var _children : Vector.<IContentDataModel>;



        public function DataGroupModel(parent : IContentDataModel)
        {
			super(ContentDataModelFactory.GROUP, parent);
            _children = new Vector.<IContentDataModel>()
        }

        public function getList() : Vector.<IContentDataModel>
        {
            return _children;
        }

		public function contains(data : IContentDataModel) : Boolean
		{
			if(data == null || data.parent == null) return false;
			var parent : IContentDataModel = data.parent;
			while(parent) {
				if(parent == this) return true;
				parent = parent.parent;
			}
			return false;
		}


        override public function parseData(xml:XML):void
        {
            super.parseData(xml);

            trace("DataGroupModel:parseData___________", _id)

            var list : XMLList = xml.child("item");

            for each(var item : XML in list) {

                var model : IContentDataModel = ContentDataModelFactory.createDataModel(item.@type, this);
                model.parseData(item);
                _children.push(model);
            }





            trace("_______________DataGroupModel", id);

        }


        public function get length():int {
            return _children.length;
        }
    }
}