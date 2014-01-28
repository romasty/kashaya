/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/27/14
 * Time: 8:36 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components {
	import flash.display.Sprite;
	import flash.events.Event;

	public class ComponentBase extends Sprite{

		private var _width : int;
		private var _height : int;

		private var _invalidated : Boolean;

		public function ComponentBase()
		{
			init();
		}


		final protected function init() : void
		{
			createChildren();
			invalidate();
		}


		protected function createChildren() : void
		{
			//to override
		}


		public function draw() : void
		{
		  	//to override
		}


		final public function invalidate() : void
		{
			if(_invalidated) return;
			_invalidated = true;
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}


		override public function get width():Number
		{
			return _width;
		}


		override public function set width(value:Number):void
		{
			if(_width == value) return;
			_width = value;
			invalidate();
		}

		override public function get height():Number
		{
			return _height;
		}


		override public function set height(value:Number):void
		{
			if(_height == value) return;
			_height = value;
			invalidate();
		}

		private function enterFrameHandler(event:Event):void
		{
			_invalidated = false;
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			draw();
		}

	}
}
