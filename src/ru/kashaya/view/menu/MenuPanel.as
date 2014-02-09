package ru.kashaya.view.menu {
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;

    import flash.events.MouseEvent;

    import ru.kashaya.ctrl.IMenuController;
    import ru.kashaya.model.DataGroupModel;
    import ru.kashaya.model.IContentDataModel;
	import ru.kashaya.model.IModel;
	import ru.kashaya.view.IKashayaClassFactory;
	import ru.kashaya.view.components.layout.ILayout;
	import ru.kashaya.view.controls.KashayaMenuButton;
	import ru.plod.core.service.getService;

	public class MenuPanel extends Sprite {

        private var _dataProvider : DataGroupModel;

        protected  var _buttons : Vector.<DisplayObject>;

		private var _buttonFactory : IKashayaClassFactory;

        protected var _controller : IMenuController;

		private var _layout : ILayout;


        public function MenuPanel()
        {
            _buttons = new Vector.<DisplayObject>();
        }


		public function set layout(value:ILayout):void
		{
			_layout = value;
		}


		public function set buttonFactory(value:IKashayaClassFactory):void
		{
			_buttonFactory = value;
		}

		public function get dataProvider():DataGroupModel {
            return _dataProvider;
        }

        public function set dataProvider(value:DataGroupModel):void {

            if(_dataProvider != value) {
                
                _dataProvider = value;

                removeAll();

                if(_dataProvider != null) {
                    createMenu();
                }
            }
        }



        protected function createMenu():void
        {
			var list : Vector.<IContentDataModel> = _dataProvider.getList();
            for each (var data : IContentDataModel in list) {

                var b : KashayaMenuButton = createButton(data);
                attachButton(b);
                _buttons.push(b);

                //b.setText(data.title);
            }

            alignButtons();
        }


        protected function createButton(data : IContentDataModel) : KashayaMenuButton
        {
            var b : KashayaMenuButton = _buttonFactory.getInstance(data) as KashayaMenuButton;
            b.data = data;
            return b;
        }

        protected function attachButton(b : KashayaMenuButton):void
        {
            addChild(b);

            b.addEventListener(MouseEvent.CLICK, onButtonClick);
            b.addEventListener(MouseEvent.MOUSE_OVER, onButtonOver);
            b.addEventListener(MouseEvent.MOUSE_OUT, onButtonOut);
        }

        protected function detachButton(b : KashayaMenuButton) : void
        {
            removeChild(b);

            b.removeEventListener(MouseEvent.CLICK, onButtonClick);
            b.removeEventListener(MouseEvent.MOUSE_OVER, onButtonOver);
            b.removeEventListener(MouseEvent.MOUSE_OUT, onButtonOut);
        }







        protected  function removeAll():void
        {
            for each(var b : KashayaMenuButton in _buttons) {
                detachButton(b);
            }

            _buttons = new Vector.<DisplayObject>()
        }


        protected function alignButtons() : void
        {
			_layout.updateLayout(_buttons);
        }

        public function updateButtnonStatus():void
        {
			if(_dataProvider == null) return;
			var model : IModel = getService(IModel);
            for each(var btn : KashayaMenuButton in _buttons) {
                //btn.selected = (btn.data == _dataProvider.selectedKey);

				btn.selected = (btn.data == model.currentData
						|| ((btn.data is DataGroupModel) && DataGroupModel(btn.data).contains(model.currentData)));
            }
        }






        public function setController(ctrl : IMenuController) : void
        {
            _controller = ctrl;
        }


        protected function onButtonClick(e : MouseEvent) : void
        {
            _controller.click(e.target.data);
        }

        protected function onButtonOver(e : MouseEvent) : void
        {
            _controller.over(e.target.data);
        }

        protected function onButtonOut(e : MouseEvent) : void
        {
            _controller.out(e.target.data);
        }



    }
}