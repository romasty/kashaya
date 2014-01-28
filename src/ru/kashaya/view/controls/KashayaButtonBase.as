/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/8/14
 * Time: 8:58 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.controls {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;

	import ru.kashaya.view.skin.KashayaButtonSkin;

	public class KashayaButtonBase extends Sprite {

		public static const UP : String = "up";
		public static const OVER : String = "over";
		public static const DOWN : String = "down";

		protected var _skin : KashayaButtonSkin;
		protected var _state : String;
		protected var _locale : String;



		public function KashayaButtonBase(skin : KashayaButtonSkin)
		{
			this.buttonMode = true;

			_state = UP;

			_skin = skin;
			addChild(_skin);
			_skin.mouseChildren = _skin.mouseEnabled = false;

			addEventListener(MouseEvent.MOUSE_OVER, onMouseEvent);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseEvent);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
			addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);

			update();
		}

		private function onMouseEvent(event:MouseEvent):void
		{
			switch(event.type) {
				case MouseEvent.MOUSE_OVER : state = OVER; break;
				case MouseEvent.MOUSE_OUT : state = UP; break;
				case MouseEvent.MOUSE_DOWN : state = DOWN; break;
				case MouseEvent.MOUSE_UP : state = OVER; break;
			}
		}


		public function get state():String
		{
			return _state;
		}

		public function set state(value:String):void
		{
			if(_state == value) return;
			_state = value;
			update();
		}




		public function get locale():String
		{
			return _locale;
		}

		public function set locale(value:String):void
		{
			if(_locale == value) return;
			_locale = value;
			update();
		}



		protected function update() : void
		{
			if(_skin == null) return;
			_skin.locale = _locale;
			_skin.state = _state;
		}

	}
}
