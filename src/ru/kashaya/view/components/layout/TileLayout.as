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

	import ru.plod.math.MeasureQueue;

	public class TileLayout extends AbstractCellLayout {

		protected var _columns:int;
		protected var _measuredCell:Rectangle = new Rectangle();


		protected var columns:MeasureQueue = new MeasureQueue();
		protected var rows:MeasureQueue = new MeasureQueue();

		public function TileLayout(columns:int, tileWidth:int, tileHeight:int, alignType:String = null)
		{
			_columns = columns;
			_measuredCell.width = tileWidth;
			_measuredCell.height = tileHeight;

			super(alignType);
		}


		override protected function measure(children:Vector.<DisplayObject>):void
		{
			var index:int = 0;
			for each (var element:DisplayObject in children) {

				var columnIndex:int = index % _columns;
				var rowIndex:int = index / _columns;

				columns.put(columnIndex, element.width);
				rows.put(rowIndex, element.height);

				index++;
			}
		}

		/*private function getColRect(colIndex:int):Rectangle
		{
			if (columns.length <= colIndex) {
				columns[colIndex] = new Rectangle(colIndex * _measuredCell.width, 0, _measuredCell.width, _measuredCell.height)
			}
			return columns[colIndex]
		}

		private function getRowRect(rowIndex:int):Rectangle
		{
			if (rows.length <= rowIndex) {
				rows[rowIndex] = new Rectangle(0, rowIndex * _measuredCell.height, _measuredCell.width, _measuredCell.height)
			}
			return rows[rowIndex]
		}*/


		/*override protected function getRectangle(i : int, element : DisplayObject) : Rectangle
		 {
		 _measuredCell.x = (i % _columns) * _measuredCell.width;
		 _measuredCell.y =  int(i / _columns) * _measuredCell.height;
		 return _measuredCell;
		 }*/


		override protected function getRectangle(index:int, element:DisplayObject):Rectangle
		{
			var result:Rectangle = new Rectangle();

			var columnIndex:int = index % _columns;
			var rowIndex:int = index / _columns;

			result.x = columns.positions[columnIndex];
			result.width =  columns.sizes[columnIndex];
			result.y = rows.positions[rowIndex];
			result.height = rows.sizes[rowIndex];

			trace(result)

			return result;
		}


	}
}
