/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/28/14
 * Time: 7:49 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components.scroll {
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import ru.kashaya.view.components.ComponentBase;
	import ru.kashaya.view.components.helpers.DrawRectComponent;
	import ru.kashaya.view.components.helpers.SolidFill;
	import ru.plod.helpers.Diapason;

	public class ScrollContainerBase extends ComponentBase {

		private var _content:Sprite;
		protected var _mask:DrawRectComponent;
		private var _horizontalDiapason = new Diapason();
		private var _verticalDiapason = new Diapason();

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
			var bounds:Rectangle = _content.getBounds(this);

			_horizontalDiapason.change(0, width - _content.width);
			_verticalDiapason.change(0, height - _content.height);

			_content.x = _horizontalDiapason.value;
			//_content.y = _verticalDiapason.value;

			Tweener.removeTweens(_content);
			Tweener.addTween(_content, {y:_verticalDiapason.value, time:.3, transition:Equations.easeOutCubic})
		}

		public function set horizontalScroll(value:Number):void
		{
			if (_horizontalDiapason.ratio == value || !horizontalScrollAvailabe) return;
			_horizontalDiapason.ratio = value;
			invalidate();
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function get horizontalScroll():Number
		{
			return _horizontalDiapason.ratio;
		}

		public function get horizontalScrollAvailabe():Boolean
		{
			return width < _content.width;
		}


		public function set verticalScroll(value:Number):void
		{
			if (_verticalDiapason.ratio == value || !verticalScrollAvailabe) return;
			_verticalDiapason.ratio = value;
			invalidate();
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function get verticalScroll():Number
		{
			return _verticalDiapason.ratio;
		}

		public function get verticalScrollAvailabe():Boolean
		{
			return height < _content.height;
		}


		//TODO: refactor;
		public function setContent(child:DisplayObject):void
		{
			_content.addChild(child);
		}


		public function get content():Sprite
		{
			return _content;
		}
	}
}