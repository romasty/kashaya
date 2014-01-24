package ru.kashaya.view.content {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    public class PicPreloader extends Sprite {

        private var _tf : TextField

        public function PicPreloader() {
            create();
        }

        private function create():void
        {
            _tf = new TextField();
            addChild(_tf);
            _tf.autoSize = TextFieldAutoSize.LEFT;
            _tf.textColor = 0xFFFFFF;
        }


        public function showProgress(bl : uint, bt : uint):void
        {
            var perc : int = 100 * bl / bt;
            _tf.text = perc + "%";

            align();
        }

        public function showError(err : String) : void
        {
            _tf.text = err;

            align();
        }

        private function align():void
        {
            x = -.5 * _tf.width;
            y = -.5 * _tf.height;
        }


    }
}