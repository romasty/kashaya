/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/27/14
 * Time: 5:04 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components.scroll {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	import ru.kashaya.view.components.ComponentBase;
	import ru.plod.helpers.Diapason;

	public class ScrollBarComponentBase extends ComponentBase {

		protected var _scrollArea:Sprite;
		protected var _scroller:Sprite;
		protected var _scrollDiapason : Diapason = new Diapason();
		protected var _relativeScrollerHeight : Number;
		private var _scrollAreaMouseDown : Boolean;
		private var _scrollerDownMouseY : Number;
		private var _scrollAreaMouseDownTimer : uint;

		public function ScrollBarComponentBase()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			//addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		}

		override protected function createChildren():void
		{
			height = 200;

		  	_scrollArea = createScrollArea();
			addChild(_scrollArea);

			_scroller = createScroller();
			addChild(_scroller);
			_scroller.height = 40;

			_relativeScrollerHeight = _scroller.height / height;
		}

		override public function draw():void
		{

			_scrollArea.x = 0;
			_scrollArea.y = 0;
			_scrollArea.height = height;

			_scroller.height =  _relativeScrollerHeight * height;
			_scrollDiapason.change(0, _scrollArea.height - _scroller.height);
			_scroller.y = _scrollDiapason.value;
		}

		public function get scrollPosition():Number
		{
			return _scrollDiapason.ratio;
		}

		public function set scrollPosition(value:Number):void
		{
			if(value != _scrollDiapason.ratio) {
				_scrollDiapason.ratio = value;
				invalidate();
				dispatchEvent(new Event(Event.CHANGE));
			}
		}

		public function set relativeScrollerHeight(value:Number):void
		{
			if(value <=0) value = 0.01;
			if(value >=1) value = 0.99;
			_relativeScrollerHeight = value;
			invalidate();
		}

		private function addedToStageHandler(event:Event):void
		{
			_scrollArea.addEventListener(MouseEvent.MOUSE_DOWN, scrollArea_mouseDownHandler);
			_scroller.addEventListener(MouseEvent.MOUSE_DOWN, scroller_mouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}

		private function removedFromStageHandler(event:Event):void
		{
			_scrollArea.removeEventListener(MouseEvent.MOUSE_DOWN, scrollArea_mouseDownHandler);
			_scroller.removeEventListener(MouseEvent.MOUSE_DOWN, scroller_mouseDownHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);

			_scrollAreaMouseDown = false;
			clearTimeout(_scrollAreaMouseDownTimer);
		}




		private function scrollArea_mouseDownHandler(event:MouseEvent):void
		{
			_scrollAreaMouseDown = true;
			var mY : Number = _scrollArea.mouseY;
			if(mY < _scroller.y) {
				scrollUp();
			} else if(mY > _scroller.y + _scroller.height) {
				scrollDown()
			}
		}

		private function scrollDown() : void
		{
			var ds : Number =  _scroller.height / _scrollDiapason.span;
			scrollPosition += ds;

			if(_scrollAreaMouseDown && scrollPosition != 1) setTimeout(scrollDown, 100);
		}

		private function scrollUp() : void
		{
			var ds : Number =  _scroller.height / _scrollDiapason.span;
			 scrollPosition -= ds;
			if(_scrollAreaMouseDown && scrollPosition != 0) setTimeout(scrollUp, 100);
		}





		private function scroller_mouseDownHandler(event:MouseEvent):void
		{
			_scrollerDownMouseY = _scrollArea.mouseY - _scroller.y;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}

		private function stage_mouseUpHandler(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			_scrollAreaMouseDown = false;
			clearTimeout(_scrollAreaMouseDownTimer);

		}

		private function mouseMoveHandler(event:MouseEvent):void
		{
			scrollPosition = (_scrollArea.mouseY - _scrollerDownMouseY) / _scrollDiapason.span;
		}




		//TODO: refactor, register factories
		protected function createScroller() : Sprite
		{
			return new TestButton();
		}

		protected function createScrollArea() : Sprite
		{
			return new TestButton();
		}

//		private function mouseWheelHandler(event:MouseEvent):void
//		{
//			scrollPosition -=.05 * event.delta;
//		}
	}
}

import ru.kashaya.view.components.ComponentBase;


class TestButton extends ComponentBase {


	public function TestButton(width:int = 20, height:int = 20)
	{
		this.width = width;
		this.height = height;
		super ();
	}


	override public function draw():void
	{
		graphics.clear();
		graphics.lineStyle(1, 0, 1);
		graphics.beginFill(0xCCCCCC, 1);
		graphics.drawRect(0, 0, width, height);
		graphics.endFill();
	}



}
