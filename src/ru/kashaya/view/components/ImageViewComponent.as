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
	import flash.external.ExternalInterface;
	import flash.utils.setTimeout;

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
			_image.setComponentSize(80, 80);
			_image.addEventListener(Event.CLOSE, closeHandler);
			_image.addEventListener(Event.COMPLETE, loadCompleteHandler);
			_image.showContent(data);

			addChild(_locker);
			addChild(_closeBtn);
			addChild(_image);

			resize();
		}

		private function closeHandler(e:Event = null):void
		{
			clear();

			if(ExternalInterface.available) {
				ExternalInterface.call("setFlashSize", true);
			}
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

		private function loadCompleteHandler(event:Event):void
		{
			_image.addEventListener(Event.CHANGE, imagePinedChange);
			var overBounds : Boolean = _image.originalWidth > stage.stageWidth || _image.originalHeight > stage.stageHeight;
			_image.pinned = overBounds;
			_image.pinnable = overBounds;
			resize();
			setTimeout(_image.redraw, 500);
		}

		private function imagePinedChange(event:Event):void
		{
			resize();
		}


		private function resize():void
		{
			if (stage == null || !_opened) return;

			_closeBtn.y = 20;
			_closeBtn.x = stage.stageWidth - _closeBtn.width - 20;

			if(_image) {

				var overBounds : Boolean = _image.originalWidth > stage.stageWidth || _image.originalHeight > stage.stageHeight;
				_image.pinnable = overBounds;
				if(_image.pinned) {
					if(overBounds) {
						resizeScaled();
					} else {
						resizeUnscaled();
					}
				} else {
					resizeUnscaled();
				}
			}
		}


		private function resizeScaled() : void
		{
			var stageW : int = stage.stageWidth;
			var stageH : int = stage.stageHeight - 30;

			var scale : Number = Math.min(stageW/_image.originalWidth, stageH/_image.originalHeight );

			var w : int = scale * _image.originalWidth;
			var h : int = scale * _image.originalHeight;
			_image.setComponentSize(w, h);
			_image.setImageSize(w, h);

			_image.x = .5 * (stageW - _image.width);
			_image.y = .5 * (stageH - _image.height);

			/*if(ExternalInterface.available) {
				ExternalInterface.call("setFlashSize", true);
			}*/
		}

		private function resizeUnscaled() : void
		{
			var stageW : int = stage.stageWidth;
			var stageH : int = stage.stageHeight;

			var overBounds : Boolean = _image.originalWidth > stageW || _image.originalHeight > stageH;
			_image.setComponentSize(_image.originalWidth, _image.originalHeight);
			_image.setImageSize(_image.originalWidth, _image.originalHeight);
			_image.x = .5 * (stageW - _image.width);
			_image.y =  overBounds ? 0 :.5 * (stageH - _image.height);

			if(ExternalInterface.available && overBounds) {
				ExternalInterface.call("setHeight", _image.originalHeight + 30);
			}
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