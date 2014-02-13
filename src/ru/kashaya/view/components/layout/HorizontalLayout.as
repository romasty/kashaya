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

		protected var _measuredCell:Rectangle = new Rectangle();

		public function HorizontalLayout(alignType:String = null)
		{
			super(alignType);
		}


		//TODO:
		override protected function measure(children:Vector.<DisplayObject>):void
		{
			for each (var displayObject:DisplayObject in children) {
				_measuredCell.width = Math.max(_measuredCell.width, displayObject.width);
				_measuredCell.height = Math.max(_measuredCell.height, displayObject.width);
			}
		}

		protected function measureWidth(element : DisplayObject) : uint
		{
			return _measuredCell.width = Math.max(_measuredCell.width, element.width);
		}

		protected function measureHeight(element : DisplayObject) : uint
		{
			return _measuredCell.height = Math.max(_measuredCell.width, element.width);
		}


		/*override protected function getRectangle(index:int, element:DisplayObject):Rectangle
		{
			_measuredCell.x = i * _measuredCell.width;
			return _measuredCell;
		}


		//relative
		override protected function getRectangle(index:int, element:DisplayObject):Rectangle
		{
			_measuredCell.x += _measuredCell.width;
			_measuredCell.width = element.width;
			return _measuredCell;
		}*/


	}
}
