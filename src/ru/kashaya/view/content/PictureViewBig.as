package ru.kashaya.view.content {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import flashx.textLayout.formats.TextAlign;

	import ru.kashaya.model.IContentDataModel;

	public class PictureViewBig extends PictureView {

		private var _titleTf:TextField;
		private var _closeBtn:Sprite;

		private var _pinned:Boolean;
		private var _pinnable : Boolean;
		private var _pinBtn : Sprite;

		private var _shape : Shape;

		public function PictureViewBig()
		{
			super();
		}

		override protected function createPicture():void
		{
			super.createPicture();

			_shape = new Shape();
			addChild(_shape);
			_shape.mask = _mask;

			createTitle();
			createCloseButton();
			createPinButton();

			buttonMode = true;
		}



		protected function createTitle():void
		{
			_titleTf = new TextField();


			_titleTf.mouseEnabled = false;
			_titleTf.selectable = false;
		}

		protected function createCloseButton():void
		{

			_closeBtn = new Sprite();
			addChild(_closeBtn);

			_closeBtn.graphics.beginFill(0xFFFFFF, 1);
			//_closeBtn.graphics.drawRect(0, 0, 15, 15);
			_closeBtn.graphics.drawCircle(0, 0, 10);
			_closeBtn.graphics.endFill();

			_closeBtn.graphics.lineStyle(2, 0x999999, 1);
			_closeBtn.graphics.moveTo(-3, -3);
			_closeBtn.graphics.lineTo(3, 3);
			_closeBtn.graphics.moveTo(3, -3);
			_closeBtn.graphics.lineTo(-3, 3);

			_closeBtn.addEventListener(MouseEvent.CLICK, onClose);
			_closeBtn.buttonMode = true;
			_closeBtn.filters = [new DropShadowFilter(2, 45, 0,.7, 4, 4)]
		}

		protected function createPinButton():void
		{
			_pinBtn = new Sprite();
			_pinBtn.addEventListener(MouseEvent.CLICK, pinBtn_clickHandler);
			addChild(_pinBtn);
			_pinBtn.buttonMode = true;
			redrawPinBtn();
			_pinBtn.filters = [new DropShadowFilter(2, 45, 0,.7, 4, 4)]
		}


		private function onClose(e:MouseEvent):void
		{
			dispatchEvent(new Event(Event.CLOSE));
		}

		override public function showContent(data:IContentDataModel):void
		{
			super.showContent(data);
			_loader.load(new URLRequest(_data.picUrl));
		}

		public function redraw() : void
		{
			draw();
		}

		override protected function draw():void
		{
			super.draw();

			if (_closeBtn) {
				_closeBtn.x = _componentWidth - 15;
				_closeBtn.y = 15;
			}


			if (_pinBtn) {
				_pinBtn.x = _componentWidth - 40;
				_pinBtn.y = 15;
			}

			if (_shape && _loader && _loader.content) {
				_shape.x = .5 * (_componentWidth - _imageWidth);
				_shape.y = .5 * (_componentHeight - _imageHeight);

				var b : BitmapData = Bitmap(_loader.content).bitmapData;
				var m : Matrix = new Matrix();
				var s : Number = _imageHeight / _originalHeight;
				m.scale(s, s);

				_shape.graphics.clear();
				_shape.graphics.beginBitmapFill(b, m, false, true);
				_shape.graphics.drawRect(0, 0, _imageWidth, _imageHeight);
				_shape.graphics.endFill();
			}

			if(_titleTf) {
				updateTitle();
			}
		}


		override protected function onLoad(e:Event):void
		{
			super.onLoad(e);
			updateTitle();
			_loader.visible = false;
		}

		override public function clear():void
		{
			assignDrag(false);
			_closeBtn.removeEventListener(MouseEvent.CLICK, onClose);
			_pinBtn.removeEventListener(MouseEvent.CLICK, pinBtn_clickHandler);

			super.clear();
		}





		public function assignDrag(val:Boolean):void
		{
			if (val) {
				addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				addEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
			} else {
				removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				removeEventListener(MouseEvent.MOUSE_DOWN, onMouseUp);
				stopDrag();
			}
		}


		private function onMouseDown(e:MouseEvent):void
		{
			startDrag(false);
		}

		private function onMouseUp(e:MouseEvent):void
		{
			stopDrag();
		}


		//TODO:
		private function updateTitle():void
		{
			if(_data == null) return;
			if (_data.title == null) return;
			if (_data.title == "") return;

			_titleTf.textColor = 0xFFFFFF;
			_titleTf.width = _componentWidth - 30;
			_titleTf.autoSize = TextFieldAutoSize.CENTER;
			_titleTf.wordWrap = true;
			_titleTf.multiline = true;

			_titleTf.htmlText = _data.title;

			var tf:TextFormat = new TextFormat();
			tf.color = 0x999999;
			tf.size = 14;
			tf.align = TextAlign.CENTER;

			_titleTf.setTextFormat(tf);

			addChild(_titleTf);

			_titleTf.x = -.5 *( _componentWidth - _titleTf.width);
			_titleTf.y = _componentHeight + 5;
		}


		public function get pinned():Boolean
		{
			return _pinned;
		}

		public function set pinned(value:Boolean):void
		{
			if (_pinned != value) {
				_pinned = value;
				dispatchEvent(new Event(Event.CHANGE));
				//TODO: upd pin button

				//assignDrag(!_pinned);
				redrawPinBtn();
			}
		}


		public function get pinnable():Boolean
		{
			return _pinnable;
		}

		public function set pinnable(value:Boolean):void
		{
			_pinnable = value;
			_pinBtn.visible = _pinnable;
		}

		private function pinBtn_clickHandler(event:MouseEvent):void
		{
			pinned = !pinned;
		}

		private function redrawPinBtn() : void
		{
			_pinBtn.graphics.clear();
			_pinBtn.graphics.beginFill(0xFFFFFF, 1);
			_pinBtn.graphics.drawCircle(0, 0, 10);
			_pinBtn.graphics.endFill();

			_pinBtn.graphics.lineStyle(2, 0x999999, 1);
			_pinBtn.graphics.moveTo(-3, 0);
			_pinBtn.graphics.lineTo(3, 0);

			if(_pinned) {
				_pinBtn.graphics.moveTo(0, -3);
				_pinBtn.graphics.lineTo(0, 3);
			}
		}
	}
}