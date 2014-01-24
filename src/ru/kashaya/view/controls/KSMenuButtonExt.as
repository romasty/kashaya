package ru.kashaya.view.controls {
    import flash.display.Sprite;
    import flash.text.TextFormat;

    import ru.kashaya.utils.KashayaColors;

    public class KSMenuButtonExt extends AbstractMenuButton {

        private var _circle : Sprite;

        public function KSMenuButtonExt() {
			super ()
        }


        override protected function createChildren():void {
            super.createChildren();

            _circle = new Sprite();
            addChild(_circle);
            _circle.x = -60;
            _circle.y = 15;
        }

        override protected function updateStyle():void {
            super.updateStyle();


            var tf : TextFormat = new TextFormat();
            tf.color = selected ? data.style.secondColor : KashayaColors.GRAY_3;
            tf.size = 16;
            //tf.font = "a_AvanteBs";
            tf.letterSpacing = 2.2;
            tf.leading = 0;

            _tf.setTextFormat(tf);
            







            var color : uint = data.style.color;

            _circle.graphics.clear();
            _circle.graphics.beginFill(color, 100);
            _circle.graphics.drawCircle(0, 0, 12);
            _circle.graphics.endFill();
            _circle.y = .5 * _tf.height;

        }
    }
}