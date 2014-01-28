/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/28/14
 * Time: 7:58 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components.helpers {
	import ru.kashaya.view.components.ComponentBase;

	public class DrawRectComponent extends ComponentBase {

		protected var _fillMode : FillMode;

		public function DrawRectComponent(width : int, height : int, fill : FillMode = null)
		{
			_fillMode = fill ? fill : new SolidFill(0, 0);
			this.width = width;
			this.height = height;
		}


		override public function draw():void
		{
			graphics.clear();
			_fillMode.fill(graphics);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}


	}
}
