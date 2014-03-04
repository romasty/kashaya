package ru.kashaya.view.content {
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Rectangle;

	import ru.kashaya.model.IContentDataModel;
	import ru.kashaya.model.PictureDataModel;
	import ru.kashaya.utils.KashayaColors;

	public class PictureView extends Sprite implements IContentPage {

		protected var _data:PictureDataModel;
		protected var _loader:Loader;
		protected var _preloader:PicPreloader;
		protected var _border:Sprite;
		protected var _mask:Sprite;

		protected var _originalWidth:int = 0;
		protected var _originalHeight:int = 0;
		protected var _componentWidth:int = 0;
		protected var _componentHeight:int = 0;
		protected var _imageWidth:int = 0;
		protected var _imageHeight:int = 0;

		protected var borderRadius:int = 30;
		protected var maskRadius:int = 20;
		protected var diff:int = 2;

		public function PictureView()
		{
			createPicture();
		}

		public function get data():PictureDataModel
		{
			return _data;
		}

		override public function get width():Number
		{
			return _componentWidth;
		}

		override public function set width(value:Number):void
		{
			_componentWidth = value;
		}

		override public function get height():Number
		{
			return _componentHeight;
		}

		override public function set height(value:Number):void
		{
			_componentHeight = value;
		}

		public function get originalWidth():int
		{
			return _originalWidth;
		}

		public function get originalHeight():int
		{
			return _originalHeight;
		}

		public function get imageWidth():int
		{
			return _imageWidth;
		}

		public function get imageHeight():int
		{
			return _imageHeight;
		}

		override public function getRect(targetCoordinateSpace:DisplayObject):Rectangle
		{
			return _border.getRect(targetCoordinateSpace);
		}

		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle
		{
			return _border.getBounds(targetCoordinateSpace);
		}

		public function get displayObject():DisplayObject
		{
			return this;
		}

		protected function createPicture():void
		{
			createBorderAndMask();
			createLoader();
			createPreloader();
		}

		protected function createBorderAndMask():void
		{
			_border = new Sprite();
			addChild(_border);

			_mask = new Sprite();
			addChild(_mask);

			draw();

		}

		protected function createPreloader():void
		{
			_preloader = new PicPreloader();
			addChild(_preloader);
			_preloader.visible = false;
		}

		protected function createLoader():void
		{
			_loader = new Loader();
			addChild(_loader);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, onOpen);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);

			_loader.mask = _mask;
		}

		public function showContent(data:IContentDataModel):void
		{
			_data = data as PictureDataModel;
		}

		protected function onOpen(e:Event):void
		{
			_preloader.visible = true;
		}

		protected function onProgress(e:ProgressEvent):void
		{
			_preloader.showProgress(e.bytesLoaded, e.bytesTotal);
		}

		protected function onError(e:Event):void
		{
			_preloader.visible = true;
			_preloader.showError("Error! " + _data.previewUrl);

		}

		protected function onLoad(e:Event):void
		{
			_preloader.visible = false;

			_originalWidth = _loader.content.width;
			_originalHeight = _loader.content.height;

			setImageSize(_originalWidth, _originalHeight);

			dispatchEvent(e);
		}


		public function setComponentSize(w:int, h:int):void
		{
			_componentWidth = w;
			_componentHeight = h;
			draw();
		}

		public function setImageSize(w:int, h:int):void
		{
			_imageWidth = w;
			_imageHeight = h;
			draw();
		}


		protected function draw():void
		{
			_border.graphics.clear();
			_border.graphics.beginFill(KashayaColors.GRAY_1, 1);

			_border.graphics.drawRect(0, 0, _componentWidth, _componentHeight);
			_border.graphics.endFill();

			_mask.graphics.clear();
			_mask.graphics.beginFill(KashayaColors.COLOR_1, 1);
			_mask.graphics.drawRect( diff,  diff, _componentWidth - 2 * diff, _componentHeight - 2 * diff);
			_mask.graphics.endFill();

			if (_loader) {
				_loader.width = _imageWidth;
				_loader.height = _imageHeight;

				_loader.x = .5 * (_componentWidth - _imageWidth);
				_loader.y = .5 * (_componentHeight - _imageHeight);
			}
		}

		public function clear():void
		{
			if (_loader) {
				_loader.removeEventListener(Event.COMPLETE, onLoad);
				_loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
				removeChild(_loader);
				_loader = null;
			}
		}
	}
}