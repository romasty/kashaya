package ru.kashaya.view.controls {
    import flash.text.AntiAliasType;
    import flash.text.TextFormat;

    import ru.kashaya.utils.KashayaColors;

    public class KSMenuButton extends AbstractMenuButton{

        public function KSMenuButton() {
			super();
        }


        override protected function updateStyle():void {
            super.updateStyle();

            var tf : TextFormat = new TextFormat();
            tf.size = 18;
            tf.color = selected ? data.style.secondColor : KashayaColors.GRAY_2;
            tf.font = "a_AvanteBs";
            tf.letterSpacing = 2.2;
            tf.leading = -5;

            _tf.setTextFormat(tf);

        }
    }
}