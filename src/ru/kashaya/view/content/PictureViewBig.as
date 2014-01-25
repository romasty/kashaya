package ru.kashaya.view.content {
    import flash.display.Sprite;
    import flash.events.Event;

    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.utils.setTimeout;

    import mx.events.ModuleEvent;

    import ru.kashaya.model.IContentDataModel;
    import ru.kashaya.model.PictureDataModel;

    public class PictureViewBig extends PictureView {


        private var _titleTf:TextField;
        private var _closeBtn:Sprite;

        public function PictureViewBig() {
        }


        override protected function createPicture():void {
            super.createPicture();
            createTitle();
            createCloseButton();

            buttonMode = true;
        }


        protected function createTitle():void {
            _titleTf = new TextField();
            addChild(_titleTf);

            _titleTf.mouseEnabled = false;
            _titleTf.selectable = false;
        }

        protected function createCloseButton():void {

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
        }

        private function onClose(e:MouseEvent):void {
            dispatchEvent(new Event(Event.CLOSE));
        }


        override protected function updateSize(w:int, h:int):void {
            super.updateSize(w, h);

            _closeBtn.x = .5 * _picWidth - 15;
            _closeBtn.y = - .5 * _picHeight + 15;
        }


        override public function showContent(data:IContentDataModel):void {
            super.showContent(data);
            _loader.load(new URLRequest(_data.picUrl));
        }


        override protected function onLoad(e:Event):void {
            super.onLoad(e);


            trace("BIG: onLoad");
            _onResize = onResizeBig;
            setSize(_loader.width, _loader.height);
            updatePosition();
        }


        override public function clear():void {
            declineDrag();
            removeEventListener(Event.ENTER_FRAME, resize);
            _closeBtn.removeEventListener(MouseEvent.CLICK, onClose);
            super.clear();
        }


        private var _finW:int;
        private var _finH:int;

        private var _currentPicWidth:Number = 0;
        private var _currentPicHeight:Number = 0;


        override public function setSize(w:int, h:int):void {

            removeEventListener(Event.ENTER_FRAME, resize);

            _finW = w;
            _finH = h;

            addEventListener(Event.ENTER_FRAME, resize);


        }

        protected function resize(e:Event):void {

            _currentPicWidth += (_finW - _currentPicWidth) / 4;
            _currentPicHeight += (_finH - _currentPicHeight) / 4;

            if (Math.abs(_finW - _currentPicWidth) < 2) {
                stopResize();
            } else {
                updateSize(_currentPicWidth, _currentPicHeight);
            }
        }

        protected function stopResize():void {
            removeEventListener(Event.ENTER_FRAME, resize);
            updateSize(_finW, _finH);


            if (_onResize) {
                _onResize();
                _onResize = null;
            }

            assignDrag();
        }


        private var _onResize:Function;

        private function onResizeBig():void {
            if (_data.title == null) return;
            if (_data.title == "") return;

            _titleTf.textColor = 0x000000;
            _titleTf.width = _picWidth - 30;
            _titleTf.autoSize = TextFieldAutoSize.CENTER;
            _titleTf.wordWrap = true;
            _titleTf.multiline = true;
            _titleTf.x = -.5 * _picWidth + 15;
            _titleTf.y = .5 * _picHeight + 5;

            _titleTf.background = true;
            _titleTf.backgroundColor = 0xFFFFFF;
            _titleTf.border = true;
            _titleTf.borderColor = 0x999999;

            //_titleTf.embedFonts = true;


            _titleTf.htmlText = _data.title;

            var tf:TextFormat = new TextFormat();
            tf.color = 0x999999;
            //tf.font = "a_AvanteBs";
            tf.size = 14;
            tf.align = "center"

            _titleTf.setTextFormat(tf);
        }


        private function assignDrag():void {
            addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            addEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
        }

        private function declineDrag():void {
            removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            removeEventListener(MouseEvent.MOUSE_DOWN, onMouseUp);
            stopDrag();
        }

        private function onMouseDown(e:MouseEvent):void {
            startDrag(false);
        }

        private function onMouseUp(e:MouseEvent):void {
            stopDrag();
        }





        private function updatePosition():void {
            if (!stage || !parent) return;

            var stageW:int = stage.stageWidth;
            var stageH:int = stage.stageHeight;

            var position : Point;

            if (stageH > _loader.height) {

                position = new Point(.5 * stageW, .5 * stageH);
                position = parent.globalToLocal(position);
                x = position.x;
                y = position.y;

            } else {

                position = new Point(.5 * stageW, .5 * _loader.height);
                position = parent.globalToLocal(position);
                x = position.x;
                y = position.y;
            }

        }

    }
}