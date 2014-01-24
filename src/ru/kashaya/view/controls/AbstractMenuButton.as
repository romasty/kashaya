package ru.kashaya.view.controls {
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
    import flash.text.AntiAliasType;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    import ru.kashaya.model.IContentDataModel;

	public class AbstractMenuButton extends Sprite {


        protected var _tf : TextField;

		private var _data : IContentDataModel;

        private var _title : String;

        private var _selected : Boolean;

        public function AbstractMenuButton() {

            createChildren();
        }


		public function get displayObject():DisplayObject
		{
			return this;
		}


		public function get data():IContentDataModel
		{
			return _data;
		}

		public function set data(value:IContentDataModel):void
		{
			_data = value;
		}

		protected function createChildren():void
        {
            mouseChildren = false;

            _tf = new TextField();
            _tf.autoSize = TextFieldAutoSize.LEFT;
            _tf.antiAliasType = AntiAliasType.NORMAL;
            _tf.embedFonts = true;
            _tf.multiline = true;
            
            
            addChild(_tf);

            buttonMode = true;
        }


        public function setText(txt : String) : void
        {
            _title = txt ? txt : "";
            _tf.htmlText = _title.toUpperCase();

            updateStyle();
            drawArea();
        }


        protected function updateStyle():void
        {

        }


        public function get selected():Boolean {
            return _selected;
        }

        public function set selected(value:Boolean):void {
            _selected = value;
            updateStyle();
        }

        protected function drawArea():void
        {
            graphics.clear();
            graphics.beginFill(0, 0);
            graphics.drawRect(_tf.x, _tf.y, _tf.width, _tf.height);
            graphics.endFill();
        }
    }
}