package ru.kashaya.view.content {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
    import flash.display.SpreadMethod;
    import flash.display.Sprite;

    import flash.events.Event;

    import flash.events.MouseEvent;
	import flash.geom.Point;

	import flash.ui.Mouse;

    import mx.events.ModuleEvent;

    import ru.kashaya.model.GalleryModel;
    import ru.kashaya.model.IContentDataModel;
	import ru.kashaya.model.IModel;
	import ru.kashaya.model.PictureDataModel;
    import ru.kashaya.resources.Resources;
	import ru.kashaya.view.components.layout.TileLayout;
	import ru.kashaya.view.components.scroll.ScrollBarComponentBase;
	import ru.kashaya.view.components.scroll.ScrollContainerBase;
	import ru.kashaya.view.controls.AbstractMenuButton;
	import ru.kashaya.view.controls.KashayaScrollBar;
	import ru.plod.core.service.getService;

	public class GalleryContentPage extends Sprite implements IContentPage {


        private const SIZE : int = 140;

        private var _data:GalleryModel;

        //private var _picsMask : Sprite;
        private var _picsCont:Sprite;
        private var _pics:Array = new Array();


		private var _layout : TileLayout = new TileLayout(4, 140, 140);

		private var _container : ScrollContainerBase;
		private var _scrollBar : ScrollBarComponentBase;


        public function GalleryContentPage() {

            createChildren();
        }


		public function get displayObject():DisplayObject
		{
			return this;
		}

		private function createChildren():void
        {
			_container = new ScrollContainerBase();
			_container.width = SIZE * 4;
			_container.height = SIZE * 2;
			addChild(_container);

			_scrollBar = new KashayaScrollBar();
			_scrollBar.x = SIZE * 4 + 10;
			_scrollBar.y = -15;
			_scrollBar.height = 350;
			addChild(_scrollBar);
			_scrollBar.addEventListener(Event.CHANGE, scrollBar_changeHandler);


			_picsCont = new Sprite();
			_container.setContent(_picsCont);
            //addChild(_picsCont);

            /*_picsMask = new Sprite();
            //addChild(_picsMask);
            _picsMask.graphics.beginFill(0, .2);
            _picsMask.graphics.drawRect(0, 0, SIZE * 3, SIZE *2);
            _picsMask.graphics.endFill();
            _picsMask.mouseEnabled = false;*/

            //createButtons();
        }

        public function showContent(data:IContentDataModel):void {

            _data = data as GalleryModel;
            createGallery();
            //updateButtonStatus();
        }


        private function createGallery():void {
            var list:Vector.<IContentDataModel> = _data.getList();
            for each(var picData:PictureDataModel in list) {
                createPicture(picData);
            }

            updatePictures();
			_scrollBar.relativeScrollerHeight = _container.height/_container.content.height;

        }


        private function createPicture(data:PictureDataModel):PictureView
        {
            var pic:PictureView = new PicPreview();
            _picsCont.addChild(pic);
            _pics.push(pic);
            pic.showContent(data);

            pic.addEventListener(MouseEvent.CLICK, onClick);
            pic.addEventListener(MouseEvent.MOUSE_OVER, onOver);

            return pic;
        }


        private function updatePictures(overpic : PictureView = null):void {

			_layout.updateLayout(Vector.<DisplayObject>(_pics));


            for each(var pic:PictureView in _pics) {

					if(overpic == pic) {
						pic.setSize(120, 120);
					} else {
						var s: int = 100;
						pic.setSize(s, s);
					}
					pic.visible = true;

            }
        }

        private function onClick(e : Event) : void
        {
            var pic : PictureView = e.currentTarget as PictureView;
            var data : PictureDataModel = pic.data;

			IModel(getService(IModel)).currentData = data;
        }





        private function onOver(e : Event) : void
        {
            var pic : PictureView = e.currentTarget as PictureView;
            updatePictures(pic);
        }





        public function clear():void
        {
            for each(var pic:PictureView in _pics) {
                pic.removeEventListener(MouseEvent.CLICK, onClick);
                pic.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
                pic.clear();
            }
            _pics = new Array();
            _data.currentIndex = 0;
        }

		private function scrollBar_changeHandler(event:Event):void
		{
			_container.scrollPosition = new Point(0, _scrollBar.scrollPosition);
		}
	}
}