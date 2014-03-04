package ru.kashaya.model {
    import flash.events.Event;
    import flash.events.EventDispatcher;

    public class Model extends EventDispatcher implements IModel{


        private var _data : DataGroupModel;

		private var _currentData : IContentDataModel;

		private var _locale : String = KashayaLocale.RU;

        public function Model() {
        }

        public function setData(data : DataGroupModel) : void
        {
            _data = data;
        }


        public function get data():DataGroupModel {
            return _data;
        }


		public function get currentData():IContentDataModel
		{
			return _currentData;
		}

		public function set currentData(value:IContentDataModel):void
		{
			if(_currentData != value || value is PictureDataModel) {
				_currentData = value;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}


		public function get locale():String
		{
			return _locale;
		}

		public function set locale(value:String):void
		{
			if(_locale != value) {
				_locale = value;
				dispatchEvent(new Event(KashayaLocale.LOCALE_CHANGE));
			}
		}
	}
}