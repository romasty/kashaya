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

                /*pic.x = (Math.floor(i / 2)) * SIZE + .5 * SIZE;
                pic.y = (i % 2) * SIZE + .5 * SIZE;*/


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


       /* private function createButtons():void {
            var lcl : Class = Resources.storage.getDefinition("lib", "leftButton");
            _btnLeft = new lcl() as Sprite;
            addChild(_btnLeft);
            *//*_btnLeft.y = 20;
            _btnLeft.x = 610;*//*

            _btnLeft.y = 190;
            _btnLeft.x = 610;

            _btnLeft.scaleX = _btnLeft.scaleY = .5;
            //_btnLeft.buttonMode = true;
            _btnLeft.mouseChildren = false;
            //_btnLeft.setText("<");


            //_btnRight = new AbstractMenuButton();
            var rcl : Class = Resources.storage.getDefinition("lib", "rightButton");
            _btnRight = new rcl() as Sprite;
            addChild(_btnRight);
            *//*_btnRight.y = 20;
            _btnRight.x = 665;*//*

            _btnRight.y = 190;
            _btnRight.x = 640;
            _btnRight.scaleX = _btnRight.scaleY = .5;
            //_btnRight.buttonMode = true;
            _btnRight.mouseChildren = false;
            //_btnRight.setText(">");

            _btnLeft.addEventListener(MouseEvent.CLICK, onBtnClick);
            _btnRight.addEventListener(MouseEvent.CLICK, onBtnClick);

            _btnLeft.addEventListener(MouseEvent.MOUSE_DOWN, onBtn);
            _btnLeft.addEventListener(MouseEvent.MOUSE_UP, onBtn);
            _btnLeft.addEventListener(MouseEvent.ROLL_OUT, onBtn);

            _btnRight.addEventListener(MouseEvent.MOUSE_DOWN, onBtn);
            _btnRight.addEventListener(MouseEvent.MOUSE_UP, onBtn);
            _btnRight.addEventListener(MouseEvent.ROLL_OUT, onBtn);

        }*/

       /* private function onBtnClick(e:Event):void {
            var btn:Sprite = e.currentTarget as Sprite;
            if (btn == _btnLeft) {
                _data.currentIndex--;
            } else {
                _data.currentIndex++;
            }

            trace("onBtnClick", e.target, e.currentTarget)

            //alignPictures();
            startSlide();
            updateButtonStatus();
        }*/


        /*private function onBtn(e : MouseEvent) : void
        {
            var btn : MovieClip = e.currentTarget as MovieClip;
            if(e.type == MouseEvent.MOUSE_DOWN) {
                btn.gotoAndStop(2);
            } else {
                btn.gotoAndStop(1);
            }
        }*/

       /* private function updateButtonStatus():void
        {
            _btnLeft.visible = _btnRight.visible = _data.length > 6;

            var left : Boolean = _data.currentIndex != 0;
            var right : Boolean = _data.currentIndex != _data.maxIndex;

            _btnLeft.alpha = left ? 1 : .3;
            _btnRight.alpha = right ? 1 : .3;

            assignBtnListeners(_btnLeft, left);
            assignBtnListeners(_btnRight, right);
        }*/

       /* private function assignBtnListeners(btn : Sprite, val : Boolean) : void
        {
            if(val) {
                btn.addEventListener(MouseEvent.CLICK, onBtnClick);
                btn.addEventListener(MouseEvent.MOUSE_DOWN, onBtn);
                btn.addEventListener(MouseEvent.MOUSE_UP, onBtn);
                btn.addEventListener(MouseEvent.ROLL_OUT, onBtn);
            } else {
                btn.removeEventListener(MouseEvent.CLICK, onBtnClick);
                btn.removeEventListener(MouseEvent.MOUSE_DOWN, onBtn);
                btn.removeEventListener(MouseEvent.MOUSE_UP, onBtn);
                btn.removeEventListener(MouseEvent.ROLL_OUT, onBtn);
            }

            btn.buttonMode = val;
        }*/






        //-------------------------

        /*private var X:int;

        private function startSlide():void {
            X = - _data.currentIndex * SIZE;
            trace("startSlide", X, _data.currentIndex);
            _picsCont.addEventListener(Event.ENTER_FRAME, slide);
            alignPictures();
        }

        private function slide(e:Event):void {
            _picsCont.x += (X - _picsCont.x) / 4;
            if (Math.abs(X - _picsCont.x) < 1) {
                stopSlide();
            }
        }

        private function stopSlide():void {
            _picsCont.removeEventListener(Event.ENTER_FRAME, slide);
            _picsCont.x = X;
        }*/



        private function onClick(e : Event) : void
        {
            var pic : PictureView = e.currentTarget as PictureView;
            var data : PictureDataModel = pic.data;

			IModel(getService(IModel)).currentData = data;
			return;

            /*closeBigPic();

            _bigPic = new PictureViewBig();
            addChild(_bigPic);

			_bigPic.x = 300;
            _bigPic.y = 200;
            _bigPic.setSize(80, 80);
            _bigPic.showContent(data);
            _bigPic.addEventListener(Event.CLOSE, closeBigPic);*/
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

            //closeBigPic();
        }
    }
}