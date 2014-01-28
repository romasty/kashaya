/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/28/14
 * Time: 10:17 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.controls {
	import flash.display.Sprite;

	import ru.kashaya.view.components.helpers.DrawRectComponent;
	import ru.kashaya.view.components.helpers.SolidFill;

	import ru.kashaya.view.components.scroll.ScrollBarComponentBase;

	public class KashayaScrollBar extends ScrollBarComponentBase {


		override protected function createScroller():Sprite
		{
			return new DrawRectComponent(12, 20, new SolidFill(0xF4E98C, 1));
		}

		override protected function createScrollArea():Sprite
		{
			return new DrawRectComponent(16, 20, new SolidFill(0x222322, 1));
		}


		override protected function createChildren():void
		{
			super.createChildren();
			_scroller.x = 2;
		}
	}
}
