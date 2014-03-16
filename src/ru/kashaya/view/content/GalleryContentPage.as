package ru.kashaya.view.content {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;

	import ru.kashaya.model.GalleryModel;
	import ru.kashaya.model.IContentDataModel;
	import ru.kashaya.model.IModel;
	import ru.kashaya.model.PictureDataModel;
	import ru.kashaya.view.components.layout.SimpleTileLayout;
	import ru.kashaya.view.components.scroll.ScrollBarComponentBase;
	import ru.kashaya.view.components.scroll.ScrollContainerBase;
	import ru.kashaya.view.controls.KashayaScrollBar;
	import ru.plod.core.service.getService;
	import ru.plod.gui.layout.AlignType;
	import ru.plod.gui.layout.ILayout;

	public class GalleryContentPage extends Sprite implements IContentPage {



		private const SIZE:int = 140;
		private const COLUMNS : int = 4;
		private const SHOWS_ROWS : int = 2;

		private var _data:GalleryModel;

		private var _picsCont:Sprite;
		private var _pics:Array = new Array();


		private var _layout:ILayout = new SimpleTileLayout(COLUMNS, 140, 140, AlignType.CENTER);

		private var _container:ScrollContainerBase;
		private var _scrollBar:ScrollBarComponentBase;


		private var _rowsNum : int;
		private var _scrollStep : Number = 0;

		public function GalleryContentPage()
		{
            createChildren();
		}


		public function get displayObject():DisplayObject
		{
			return this;
		}

		private function createChildren():void
		{
			_container = new ScrollContainerBase();
			_container.width = SIZE * COLUMNS;
			_container.height = SIZE * SHOWS_ROWS;
			addChild(_container);

			_scrollBar = new KashayaScrollBar();
			_scrollBar.x = SIZE * COLUMNS + 10;
			_scrollBar.y = -15;
			_scrollBar.height = 350;
			addChild(_scrollBar);
			_scrollBar.addEventListener(Event.CHANGE, scrollBar_changeHandler);


			_picsCont = new Sprite();
			_container.setContent(_picsCont);

			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, SIZE * COLUMNS + 30, 350);
			graphics.endFill();

			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		}

		public function showContent(data:IContentDataModel):void
		{

			_data = data as GalleryModel;
			createGallery();
		}


		private function createGallery():void
		{
			var list:Vector.<IContentDataModel> = _data.getList();
			for each(var picData:PictureDataModel in list) {
				createPicture(picData);
			}

			updatePictures();
			_scrollBar.relativeScrollerHeight = _container.height / _container.content.height;

			_rowsNum  = int(list.length / COLUMNS);
			if(list.length % COLUMNS > 0) _rowsNum +=1;
			_scrollStep = 1 / (_rowsNum - SHOWS_ROWS + 1);

			trace("createGallery", list.length, _rowsNum, _scrollStep)
		}


		private function createPicture(data:PictureDataModel):PictureView
		{
			var pic:PictureView = new PicPreview();
			_picsCont.addChild(pic);
			_pics.push(pic);
			pic.showContent(data);

			pic.addEventListener(MouseEvent.CLICK, onClick);
			pic.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			pic.addEventListener(MouseEvent.MOUSE_OUT, onOut);

			return pic;
		}


		private function updatePictures(overpic:PictureView = null):void
		{

			for each(var pic:PictureView in _pics) {

				if (overpic == pic) {
					pic.setComponentSize(110, 110);
				} else {
					var s:int = 100;
					pic.setComponentSize(s, s);
				}
				pic.visible = true;

			}
			_layout.arrange(Vector.<DisplayObject>(_pics));
		}

		private function onClick(e:Event):void
		{
			var pic:PictureView = e.currentTarget as PictureView;
			var data:PictureDataModel = pic.data;

			IModel(getService(IModel)).currentData = data;
		}


		private function onOver(e:Event):void
		{
			var pic:PictureView = e.currentTarget as PictureView;
			updatePictures(pic);
		}

		private function onOut(e:Event):void
		{
			updatePictures(null);
		}

		public function clear():void
		{
			for each(var pic:PictureView in _pics) {
				pic.removeEventListener(MouseEvent.CLICK, onClick);
				pic.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
				pic.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
				pic.clear();
			}
			_pics = new Array();
			_data.currentIndex = 0;
			removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		}

		private function scrollBar_changeHandler(event:Event):void
		{
			var scrollRows : int = _rowsNum - SHOWS_ROWS;
			var curRowNum : int = int((scrollRows + 1) * _scrollBar.scrollPosition);
			_container.verticalScroll = curRowNum / scrollRows;
		}


		private var _lastWheelTime : Number = 0;
		private function mouseWheelHandler(event:MouseEvent):void
		{
			var time : Number = getTimer();
			if(time - _lastWheelTime < 200) {
				return;
			}
			_lastWheelTime = time;

			var scrollRows : int = _rowsNum - SHOWS_ROWS;
			var curRowNum : int = int((scrollRows) * _scrollBar.scrollPosition);

			var dr : int = event.delta / Math.abs(event.delta);

			_scrollBar.scrollPosition = (curRowNum - dr) / scrollRows;
		}
	}
}