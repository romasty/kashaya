package ru.kashaya.view.content {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
    import flash.display.SpreadMethod;
    import flash.display.Sprite;

    import flash.events.Event;

    import flash.events.MouseEvent;

    import flash.ui.Mouse;

    import mx.events.ModuleEvent;

    import ru.kashaya.model.GalleryModel;
    import ru.kashaya.model.IContentDataModel;
	import ru.kashaya.model.IModel;
	import ru.kashaya.model.PictureDataModel;
    import ru.kashaya.resources.Resources;
    import ru.kashaya.view.controls.AbstractMenuButton;
	import ru.plod.core.service.getService;

	public class GalleryContentPage extends Sprite implements IContentPage {


        private const SIZE : int = 140;

        private var _data:GalleryModel;

        private var _picsMask : Sprite;
        private var _picsCont:Sprite;
        private var _pics:Array = new Array();

		private const COLUMNS : int = 4;

        //private var _btnLeft:Sprite;
        //private var _btnRight:Sprite;


        private var _bigPic : PictureViewBig;

        public function GalleryContentPage() {

            createChildren();
        }


		public function get displayObject():DisplayObject
		{
			return this;
		}

		private function createChildren():void
        {
            _picsCont = new Sprite();
            addChild(_picsCont);

            _picsMask = new Sprite();
            //addChild(_picsMask);
            _picsMask.graphics.beginFill(0, .2);
            _picsMask.graphics.drawRect(0, 0, SIZE * 3, SIZE *2);
            _picsMask.graphics.endFill();
            _picsMask.mouseEnabled = false;

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

            alignPictures();
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


        private function alignPictures(overpic : PictureView = null):void {
            var i:int;
            for each(var pic:PictureView in _pics) {

				pic.x = (i % COLUMNS) * SIZE + .5 * SIZE;
				pic.y = (Math.floor(i / COLUMNS)) * SIZE + .5 * SIZE;

                var res : Boolean = ((i >= _data.currentIndex * 2) && (i < (_data.currentIndex * 2 + 6)))

				if(res) {
					if(overpic == pic) {
						pic.setSize(120, 120);
					} else {
						//var s: int = 80 + Math.random() * 60;
						var s: int = 100;
						pic.setSize(s, s);
					}
					pic.visible = true;
				} else {
					pic.setSize(20, 20);
					pic.visible = false;
				}

                i ++;
            }
        }

        private function onClick(e : Event) : void
        {
            var pic : PictureView = e.currentTarget as PictureView;
            var data : PictureDataModel = pic.data;

			IModel(getService(IModel)).currentData = data;
			return;
        }





        private function onOver(e : Event) : void
        {

            var pic : PictureView = e.currentTarget as PictureView;
            trace("onOver", pic, e.target, e.currentTarget)
            alignPictures(pic);
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
    }
}