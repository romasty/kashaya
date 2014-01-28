/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/28/14
 * Time: 8:01 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components.helpers {
	import flash.display.BitmapData;
	import flash.display.Graphics;

	public class BitmapFill extends FillMode {
		protected var _bitmapData:BitmapData;

		public function BitmapFill(bitmapData:BitmapData)
		{
			_bitmapData = bitmapData;
		}

		override public function fill(graphics:Graphics):void
		{
			graphics.beginBitmapFill(_bitmapData, null, true);
		}
	}
}
