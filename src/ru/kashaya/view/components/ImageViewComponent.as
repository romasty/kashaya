/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 1/18/14
 * Time: 8:20 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import ru.kashaya.model.IContentDataModel;

	import ru.kashaya.view.content.IContentPage;
	import ru.kashaya.view.content.PictureViewBig;

	public class ImageViewComponent extends Sprite implements IContentPage {
		private var _closeBtn:Sprite;
		private var _locker:ScreenLocker;
		private var _image:PictureViewBig;

		private var _opened:Boolean;

		public function ImageViewComponent()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			init();
		}

		private function init():void
		{
			_locker = new ScreenLocker();
			_closeBtn = new DefaultCloseButton();
			_closeBtn.addEventListener(MouseEvent.CLICK, closeHandler);
		}


		public function showContent(data:IContentDataModel):void
		{
			_opened = true;

			_image = new PictureViewBig();
			_image.x = 100;
			_image.y = 50;
			_image.setSize(80, 80);
			_image.addEventListener(Event.CLOSE, closeHandler);
			_image.showContent(data);

			addChild(_locker);
			addChild(_closeBtn);
			addChild(_image);



			resize();
		}

		private function closeHandler(e:Event = null):void
		{
			clear();
		}

		public function clear():void
		{
			if (!_opened) return;
			_opened = false;
			removeChild(_locker);
			removeChild(_closeBtn);

			_image.clear();
			_image.removeEventListener(Event.CLOSE, closeHandler);
			removeChild(_image);
		}

		private function resize():void
		{
			if (stage == null || !_opened) return;

			_closeBtn.y = 20;
			_closeBtn.x = stage.stageWidth - _closeBtn.width - 20;
		}

		private function addedToStageHandler(event:Event):void
		{
			stage.addEventListener(Event.RESIZE, stage_resizeHandler);
		}

		private function removedFromStageHandler(event:Event):void
		{
			stage.removeEventListener(Event.RESIZE, stage_resizeHandler);
			clear();
		}

		private function stage_resizeHandler(event:Event):void
		{
			resize();
		}


		public function get displayObject():DisplayObject
		{
			return this;
		}
	}
}

import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;


class DefaultCloseButton extends Sprite
{
	private var _label : TextField;

	public function DefaultCloseButton()
	{
		mouseChildren = false;
		buttonMode = true;

		_label = new TextField();
		_label.textColor = 0xFFFFFF;
		_label.text = "close X";
		_label.autoSize = TextFieldAutoSize.LEFT;
		addChild(_label);

		graphics.beginFill(0, 0);
		graphics.drawRect(0, 0, _label.width, _label.height);
		graphics.endFill();
	}
}