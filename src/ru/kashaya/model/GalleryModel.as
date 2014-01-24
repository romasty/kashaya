package ru.kashaya.model {
    public class GalleryModel extends DataGroupModel implements IContentDataModel {

        private const cols : int = 3;
        private const rows : int = 2;

        private var _currentIndex : int;
        private var _maxIndex : int;


        public function GalleryModel(parent : IContentDataModel) {
			super (parent);
			_type = ContentDataModelFactory.GALLERY
        }


        override public function parseData(xml:XML):void {
            //_id = xml.@id.toXMLString();

            super.parseData(xml);


            _maxIndex = Math.round((length - cols * rows) / rows)  ;
            if(_maxIndex <0 ) _maxIndex = 0;

        }


        public function get maxIndex():int {
            return _maxIndex;
        }

        public function get currentIndex():int {
            return _currentIndex;
        }

        public function set currentIndex(value:int):void {
            _currentIndex = value;
            if(_currentIndex < 0) _currentIndex = 0;
            if(_currentIndex > _maxIndex) _currentIndex = _maxIndex;

            trace("currentIndex:", _currentIndex, _maxIndex)
        }

        /*public function getKeysForIndex() : Array
        {
            var keys : Array = new Array();
            for(var i : int = _currentIndex; i<=_maxIndex; i++) {
                var key = _keys[i];
                if(getData(key)) {
                    keys.push(key);
                }
            }
            return keys;
        }*/
    }
}