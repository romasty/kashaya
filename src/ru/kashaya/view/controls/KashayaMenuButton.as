/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/8/14
 * Time: 10:55 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.controls {
	import ru.kashaya.model.IContentDataModel;
	import ru.kashaya.view.skin.KashayaButtonSkin;

	public class KashayaMenuButton extends KashayaButtonBase{

		protected var _selected : Boolean;

		public var data : IContentDataModel;

		public function KashayaMenuButton(skin:KashayaButtonSkin)
		{
			super(skin);
		}

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{    if(_selected == value) return;
			_selected = value;
			update();
		}

		override protected function update():void
		{
			if(_skin == null) return;
			_skin.locale = _locale;
			_skin.state = _selected ? DOWN : _state;
		}
	}
}
