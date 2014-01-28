/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/28/14
 * Time: 7:37 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components.layout {
	import flash.display.DisplayObject;

	public class TileLayout implements ILayout{

		protected var _columns : int;
		protected var _tileWidth : int;
		protected var _tileHeight : int;


		public function TileLayout(columns:int, tileWidth:int, tileHeight:int)
		{
			_columns = columns;
			_tileWidth = tileWidth;
			_tileHeight = tileHeight;
		}

		public function updateLayout(children:Vector.<DisplayObject>):void
		{
			var i:int;
			for each(var displayObject:DisplayObject in children) {

				displayObject.x = (i % _columns) * _tileWidth + .5 * _tileWidth;
				displayObject.y = (Math.floor(i / _columns)) * _tileHeight + .5 * _tileHeight;
				i ++;
			}
		}


	}
}
