/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/13/14
 * Time: 11:06 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components.layout {
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	import ru.plod.gui.layout.AlignType;

	import ru.plod.gui.layout.ILayout;

	public class SimpleTileLayout implements ILayout {

		protected var _alignType:String;
		protected var _columns:int;
		protected var _measuredCell:Rectangle = new Rectangle();
		public var checkBounds:Boolean = true;

		public function SimpleTileLayout(columns:int, tileWidth:int, tileHeight:int, alignType:String = null)
		{
			_columns = columns;
			_measuredCell.width = tileWidth;
			_measuredCell.height = tileHeight;
			_alignType = alignType ? alignType : AlignType.CENTER;
		}


		public function arrange(children:Vector.<DisplayObject>):void
		{
			var i:int;
			for each(var displayObject:DisplayObject in children) {
				var placementRect:Rectangle = getRectangle(i, displayObject);
				arrangeChild(displayObject, placementRect);
				if (checkBounds) validateBounds(displayObject);
				i++;
			}
		}

		protected function getRectangle(i:int, element:DisplayObject):Rectangle
		{
			_measuredCell.x = (i % _columns) * _measuredCell.width;
			_measuredCell.y = int(i / _columns) * _measuredCell.height;
			return _measuredCell;
		}

		protected function validateBounds(object:DisplayObject):void
		{
			if (object.parent) {
				var bounds:Rectangle = object.getRect(object.parent);
				object.x += (object.x - bounds.x);
				object.y += (object.y - bounds.y);
			}
		}

		protected function arrangeChild(object:DisplayObject, r:Rectangle):void
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
