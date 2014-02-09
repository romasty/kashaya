/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/28/14
 * Time: 7:37 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components.layout {

	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	public class TileLayout extends AbstractCellLayout {

		protected var _columns:int;
		protected var _measuredCell : Rectangle = new Rectangle();

		public function TileLayout(columns:int, tileWidth:int, tileHeight:int, alignType:String = null)
		{
			_columns = columns;
			_measuredCell.width = tileWidth;
			_measuredCell.height = tileHeight;

			super (alignType);
		}

		override protected function getRectangle(i : int, element : DisplayObject) : Rectangle
		{
			_measuredCell.x = (i % _columns) * _measuredCell.width;
			_measuredCell.y =  int(i / _columns) * _measuredCell.height;
			return _measuredCell;
		}
	}
}
