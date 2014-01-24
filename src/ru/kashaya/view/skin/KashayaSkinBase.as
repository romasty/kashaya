/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/8/14
 * Time: 9:11 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.skin {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public class KashayaSkinBase extends MovieClip {

		protected var _skinClassMap : Dictionary = new Dictionary();
		protected var _currentSkin : MovieClip;

		protected var _state : String;
		protected var _locale : String;

		protected var _skinInvalid : Boolean;

		private var _updateTimeout : uint;

		public function KashayaSkinBase()
		{
		}

		public function assignSkinClass(locale : String, skinClass : Class) : void
		{
			_skinClassMap[locale] = skinClass;
		}


		public function get state():String
		{
			return _state;
		}

		public function set state(value:String):void
		{
			if(_state != value) {
				_state = value;
				update();
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
				_skinInvalid = true;
				update();
			}
		}

		public function cleanUp() : void
		{
			if(_currentSkin) {
				removeChild(_currentSkin);
				_currentSkin = null;
			}
		}


		protected function draw() : void
		{
			if(_skinInvalid || _currentSkin == null) {
				cleanUp();

				var skinClass : Class = _skinClassMap[_locale];
				if(skinClass == null) throw new Error("Skin class not registered");

				_currentSkin = new skinClass();
				addChild(_currentSkin);

				_skinInvalid = true;
			}

			_currentSkin.gotoAndStop(_state);
		}


		protected final function update() : void
		{
			clearTimeout(_updateTimeout);
			_updateTimeout = setTimeout(draw, 10);
		}

	}
}
