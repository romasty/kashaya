/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/28/14
 * Time: 8:02 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components.helpers {
	import flash.display.BitmapData;

	public class LaticeFill extends BitmapFill {


		public function LaticeFill(color1:uint, color2:uint)
		{
			var bitmapData:BitmapData = new BitmapData(2, 2, true, color1);
			bitmapData.setPixel32(0, 0, color2);
			bitmapData.setPixel32(1, 1, color2);
			super(bitmapData);
		}
	}
}
