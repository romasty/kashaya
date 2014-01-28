/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/28/14
 * Time: 8:01 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components.helpers {
	import flash.display.Graphics;

	public class SolidFill extends FillMode {

		private var _alpha:Number;
		private var _color:uint;


		public function SolidFill(color:uint, alpha:Number)
		{
			_color = color;
			_alpha = alpha;
		}

		override public function fill(graphics:Graphics):void
		{
			graphics.beginFill(_color, _alpha);
		}
	}
}
