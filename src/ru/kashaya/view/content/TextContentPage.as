package ru.kashaya.view.content {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.text.TextField;

    import flash.text.TextFieldAutoSize;

    import flash.text.TextFormat;
    import flash.utils.setTimeout;

	import flashx.textLayout.formats.TextAlign;

	import ru.kashaya.model.IContentDataModel;
    import ru.kashaya.model.TextDataModel;
    import ru.kashaya.resources.Resources;

    public class TextContentPage extends Sprite implements IContentPage {

        private var _bg : Sprite;
        private var _tf : TextField;

        private var _txtCont : MovieClip;

        public function TextContentPage() {

            createPage();
        }


		public function get displayObject():DisplayObject
		{
			return this;
		}

		private function createPage():void
        {

            var tcClass : Class = Resources.storage.getSource("TxtContainer") as Class;
            _txtCont = new tcClass() as MovieClip;
            addChild(_txtCont);

            setTimeout(_txtCont.play, 50);

        }

        public function showContent(data : IContentDataModel) : void
        {
            var textData : TextDataModel = data as TextDataModel;
            //_tf.text = textData.body;
            var tf : TextField = _txtCont.getChildByName("tf") as TextField;
            tf.selectable = true;
            tf.htmlText = textData.body;
			tf.width = 500;

            var format : TextFormat = new TextFormat();
            format.size = 12;
            format.leading = 4;
			format.align = TextAlign.JUSTIFY
            //format.align = "center";

            tf.setTextFormat(format);
        }


        public function clear():void {
        }
    }
}