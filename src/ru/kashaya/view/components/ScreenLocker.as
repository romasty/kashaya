/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 1/18/14
 * Time: 7:37 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;





	public class ScreenLocker extends Sprite {

		//TODO:
		//public static const FILL_DEFAULT : Object = {type : "fill", color : 0xAA000000};
		//public static const BLACK_LATICE : Object = {type : "latice", color1:0xFF000000, color2:0xCC000000};

		private var _fillMode : FillMode;

		public function ScreenLocker()
		{
			mouseChildren = mouseEnabled = false;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);

			_fillMode = new BitmapLaticeFill(0xFF000000, 0xCC000000);
		}


		//TODO:
		/*private function getFillMode(param : Object) : FillMode
		{
			if(param is BitmapData) {
				return new BitmapFill(param as BitmapData);
			} else {

			}
		}*/

		private function draw():void
		{
			if (stage == null) return;
			graphics.clear();


			_fillMode.fill(graphics);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
		}

		private function addedToStageHandler(event:Event):void
		{
			draw();
			stage.addEventListener(Event.RESIZE, stage_resizeHandler);
		}

		private function removedFromStageHandler(event:Event):void
		{
			stage.removeEventListener(Event.RESIZE, stage_resizeHandler);
		}

		private function stage_resizeHandler(event:Event):void
		{
			draw();
		}
	}
}

import flash.display.BitmapData;
import flash.display.Graphics;

class FillMode {
	public function fill(graphics:Graphics):void
	{

	}
}

class SolidFill extends FillMode {

	private var _alpha:Number;
	private var _color:uint;


	public function SolidFill(alpha:Number, color:uint)
	{
		_alpha = alpha;
		_color = color;
	}

	override public function fill(graphics:Graphics):void
	{
		graphics.beginFill(_color, _alpha);
	}
}


class BitmapFill extends FillMode {
	protected var _bitmapData:BitmapData;

	public function BitmapFill(bitmapData:BitmapData)
	{
		_bitmapData = bitmapData;
	}

	override public function fill(graphics:Graphics):void
	{
		graphics.beginBitmapFill(_bitmapData, null, true);
	}
}

class BitmapLaticeFill extends BitmapFill {


	public function BitmapLaticeFill(color1:uint, color2:uint)
	{
		var bitmapData:BitmapData = new BitmapData(2, 2, true, color1);
		bitmapData.setPixel32(0, 0, color2);
		bitmapData.setPixel32(1, 1, color2);
		super(bitmapData);
	}
}