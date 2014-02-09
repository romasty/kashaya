package ru.kashaya.view.content {
	import flash.display.DisplayObject;
	import flash.display.Loader;
    import flash.display.Sprite;

    import flash.events.Event;

    import flash.events.IOErrorEvent;

    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
	import flash.geom.Rectangle;

	import flash.net.URLRequest;

    import ru.kashaya.model.IContentDataModel;
    import ru.kashaya.model.PictureDataModel;
    import ru.kashaya.utils.KashayaColors;

    public class PictureView extends Sprite implements IContentPage {


        protected var _picWidth:int = 0;
        protected var _picHeight:int = 0;

        protected var _data:PictureDataModel;

        protected var _border:Sprite;
        protected var _mask:Sprite;

        protected var borderRadius:int = 30;
        protected var maskRadius:int = 20;
        protected var diff:int = 2;


        protected var _loader:Loader;


        protected var _preloader:PicPreloader;

        public function PictureView() {
            createPicture();
        }


		override public function get width():Number
		{
			return _picWidth;
		}

		override public function set width(value:Number):void
		{
			_picWidth= value;
		}

		override public function get height():Number
		{
			return _picHeight;
		}

		override public function set height(value:Number):void
		{
			_picHeight = value;
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

		protected function createPicture():void {
            createBorderAndMask();
            createLoader();
            createPreloader();
        }

        protected function createBorderAndMask():void {
            _border = new Sprite();
            addChild(_border);

            _mask = new Sprite();
            addChild(_mask);

            draw();

        }


        protected function createPreloader():void {
            _preloader = new PicPreloader();
            addChild(_preloader);
            _preloader.visible = false;
        }


        protected function createLoader():void {
            _loader = new Loader();
            addChild(_loader);
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
            _loader.contentLoaderInfo.addEventListener(Event.OPEN, onOpen);
            _loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
            _loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);

            _loader.mask = _mask;


        }


        public function showContent(data:IContentDataModel):void {
            _data = data as PictureDataModel;
        }

        protected function onOpen(e:Event):void {
            _preloader.visible = true;
        }

        protected function onProgress(e:ProgressEvent):void {
            _preloader.showProgress(e.bytesLoaded, e.bytesTotal);
        }


        protected function onError(e:Event):void {
            _preloader.visible = true;
            _preloader.showError("Error! " + _data.previewUrl);

        }

        protected function onLoad(e:Event):void {

            _preloader.visible = false;

            _loader.x = -.5 * _loader.width;
            _loader.y = -.5 * _loader.height;
        }


        protected function draw():void {

            _border.graphics.clear();
            _border.graphics.beginFill(KashayaColors.GRAY_1, 1);
            /*_border.graphics.drawRoundRect(
                    -_picWidth / 2
                    , -_picHeight / 2
                    , _picWidth
                    , _picHeight
                    , borderRadius
                    , borderRadius);*/

			_border.graphics.drawRect(
					-_picWidth / 2
					, -_picHeight / 2
					, _picWidth
					, _picHeight
			);

            _border.graphics.endFill();


            _mask.graphics.clear();
            _mask.graphics.beginFill(KashayaColors.COLOR_1, 1);
            /*_mask.graphics.drawRoundRect(
                    -_picWidth / 2 + diff
                    , -_picHeight / 2 + diff
                    , _picWidth - 2 * diff
                    , _picHeight - 2 * diff
                    , maskRadius
                    , maskRadius);*/

			_mask.graphics.drawRect(
					-_picWidth / 2 + diff
					, -_picHeight / 2 + diff
					, _picWidth - 2 * diff
					, _picHeight - 2 * diff );


            _mask.graphics.endFill();
        }


        public function setSize(w : int, h:int):void {

            updateSize(w, h);
        }

        protected function updateSize(w:int, h:int):void {
            _picWidth = w;
            _picHeight = h;
            draw();
        }


        public function get data():PictureDataModel {
            return _data;
        }

        public function clear():void {

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