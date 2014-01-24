package ru.kashaya.view.content {
    import flash.events.Event;

    import flash.net.URLRequest;

    import ru.kashaya.model.IContentDataModel;
    import ru.kashaya.model.PictureDataModel;

    public class PicPreview extends PictureView {

        public function PicPreview() {
            super();
        }


        override protected function createPicture():void {
            super.createPicture();
            mouseChildren = false;
            buttonMode = true;
        }


        override public function showContent(data:IContentDataModel):void {
            super.showContent(data);
            _loader.load(new URLRequest(_data.previewUrl));
        }

        override public function clear():void
        {
            removeEventListener(Event.ENTER_FRAME, resize);
            super.clear();
        }



        protected var _size:int;
        protected var _currentSize:Number = 0;

        override public function setSize(size:int, h:int):void {

            /*_picWidth = size;
             _picHeight = size;
             draw();*/

            //trace("startResize!!!", _size, size)

            if (size == _size) return;

            removeEventListener(Event.ENTER_FRAME, resize);

            _size = size;

            addEventListener(Event.ENTER_FRAME, resize);


        }

        protected function resize(e:Event):void {
            _currentSize += (_size - _currentSize) / 4;
            if (Math.abs(_size - _currentSize) < 2) {
                stopResize();
            } else {
                updateSize(_currentSize, _currentSize);
            }
        }

        protected function stopResize():void {

            //trace("stopResize!!!!!!!")

            removeEventListener(Event.ENTER_FRAME, resize);
            _currentSize = _size;
            updateSize(_size, _size);
        }



    }
}