/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/28/14
 * Time: 7:49 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components.scroll {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import ru.kashaya.view.components.ComponentBase;
	import ru.kashaya.view.components.helpers.DrawRectComponent;
	import ru.kashaya.view.components.helpers.SolidFill;

	public class ScrollContainerBase extends ComponentBase{

		private var _content : Sprite;
		protected var _mask : DrawRectComponent;
		private var _scrollPosition : Point = new Point();

		public function ScrollContainerBase()
		{

		}


		override protected function createChildren():void
		{
			super.createChildren();

			_content = new Sprite();
			addChild(_content);

			_mask = new DrawRectComponent(0, 0, new SolidFill(0, 0));
			addChild(_mask);

			_content.mask = _mask;
		}


		override public function draw():void
		{
			super.draw();

			_mask.width = width;
			_mask.height = height;

			//TODO:
			var bounds : Rectangle = _content.getBounds(this);
			_content.x = _scrollPosition.x * (width - _content.width);
			_content.y = _scrollPosition.y * (height - _content.height);
		}


		public function get scrollPosition():Point
		{
			return _scrollPosition;
		}

		public function set scrollPosition(value:Point):void
		{
			if(value == null) throw new ArgumentError();
			if(_scrollPosition.equals(value)) return;
			_scrollPosition.x = value.x;
			_scrollPosition.y = value.y;
			if(_scrollPosition.x < 0 || !horizontalScrollAvailabe) _scrollPosition.x = 0;
			if(_scrollPosition.y < 0 || !verticalScrollAvailabe) _scrollPosition.y = 0;
			if(_scrollPosition.x > 1) _scrollPosition.x = 1;
			if(_scrollPosition.y > 1) _scrollPosition.y = 1;
			invalidate();
			dispatchEvent(new Event(Event.CHANGE));
		}


		public function get horizontalScrollAvailabe() : Boolean
		{
			return width < _content.width;
		}

		public function get verticalScrollAvailabe() : Boolean
		{
			return height < _content.height;
		}


		//TODO: refactor;
		public function setContent(child : DisplayObject) : void
		{
			_content.addChild(child);
		}


		public function get content():Sprite
		{
			return _content;
		}
	}
}
