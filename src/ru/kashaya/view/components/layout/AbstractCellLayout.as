/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/9/14
 * Time: 1:54 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components.layout {
	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;
	import flash.geom.Rectangle;

	public class AbstractCellLayout implements ILayout {

		protected var _alignType : String;
		public var checkBounds : Boolean = true;

		public function AbstractCellLayout(alignType : String)
		{
			_alignType = alignType ? alignType : AlignType.TOP_LEFT;
		}

		public function updateLayout(children:Vector.<DisplayObject>):void
		{
			var i:int;
			for each(var displayObject:DisplayObject in children) {
				var placementRect : Rectangle = getRectangle(i, displayObject);
				arrange(displayObject, placementRect);
				if(checkBounds) validateBounds(displayObject);
				i++;
			}
		}
		protected function getRectangle(i : int, element : DisplayObject) : Rectangle
		{
			throw new IllegalOperationError("method must be overriden")
		}

		protected function validateBounds(object:DisplayObject) : void
		{
			if (object.parent) {
				var bounds:Rectangle = object.getRect(object.parent);
				object.x += (object.x - bounds.x);
				object.y += (object.y - bounds.y);
			}
		}

		protected function arrange(object:DisplayObject, r : Rectangle):void
		{
			switch (_alignType) {
				case AlignType.LEFT:
				case AlignType.TOP_LEFT:
				case AlignType.BOTTOM_LEFT:
					object.x = r.x;
					break;
				case AlignType.TOP :
				case AlignType.CENTER :
				case AlignType.BOTTOM :
					object.x = r.x + .5 * (r.width - object.width);
					break;
				case AlignType.RIGHT:
				case AlignType.TOP_RIGHT:
				case AlignType.BOTTOM_RIGHT:
					object.x = r.x + (r.width - object.width);
					break;
				default : //
			}

			switch (_alignType) {
				case AlignType.TOP_LEFT:
				case AlignType.TOP:
				case AlignType.TOP_RIGHT:
					object.y = r.y;
					break;
				case AlignType.LEFT :
				case AlignType.CENTER :
				case AlignType.RIGHT :
					object.y = r.y + .5 * (r.height - object.height);
					break;
				case AlignType.BOTTOM_LEFT:
				case AlignType.BOTTOM:
				case AlignType.BOTTOM_RIGHT:
					object.y = r.y + (r.height - object.height);
					break;
				default : //
			}
		}
	}
}
