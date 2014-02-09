/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/9/14
 * Time: 12:35 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components.layout {
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	import ru.kashaya.view.components.layout.AbstractCellLayout;

	import spark.primitives.Rect;

	public class HorizontalLayout extends AbstractCellLayout implements ILayout {

		protected var _measuredCell : Rectangle = new Rectangle();

		public function HorizontalLayout(alignType:String = null)
		{
			super (alignType);
		}


		//TODO:
		protected function measure(children:Vector.<DisplayObject>):void
		{

			for each (var displayObject:DisplayObject in children) {
				_measuredCell.width = Math.max(_measuredCell.width , displayObject.width);
				_measuredCell.height = Math.max(_measuredCell.height , displayObject.width);
			}
		}

		/*override protected function getRectangle(i:int, element:DisplayObject):Rectangle
		{
			return new Rectangle(i*_tileWidth, 0, _tileWidth, _tileHeight);
		}*/


		//relative
		/*override protected function getRectangle(i:int, element:DisplayObject):Rectangle
	 {
	 var measuredWidth : int; //TODO
	 var result : Rectangle = new Rectangle(measuredWidth, 0, _tileWidth, _tileHeight);
	 measuredWidth += element.width;
	 return result;
	 }*/


	}
}
