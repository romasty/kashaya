package ru.kashaya.view {
    import flash.display.DisplayObject;
    import flash.display.Sprite;

    import ru.kashaya.ctrl.BGController;
    import ru.kashaya.resources.Resources;
	import ru.kashaya.view.controls.KSMenuButton;
	import ru.kashaya.view.controls.KSMenuButtonExt;
	import ru.kashaya.view.menu.MenuPanel;
	import ru.kashaya.view.menu.VerticalMenuLayout;
    import ru.kashaya.view.menu.HorizontalMenuLayout;
	import ru.kashaya.view.skin.KashayaButtonSkinFactory;
	import ru.kashaya.view.controls.KashayaMenuButtonFactory;

	public class MainScene extends Sprite {

        //public var topMenu:MenuPanel;
        public var leftMenu:MenuPanel;

        public var content : ContentPanel;

		private var _btnSkinFactory : IKashayaClassFactory;
		private var _btnFactory : IKashayaClassFactory;

        public function MainScene() {
			_btnSkinFactory  = new KashayaButtonSkinFactory();
			_btnFactory = new KashayaMenuButtonFactory(_btnSkinFactory);
        }


        public function createScene():void
        {
            createBG();
            //createTopMenu();
            createLeftMenu();
            createContentPage();
        }

        private function createBG():void
        {
            var bgCont : Sprite = addChild(Resources.storage.getSource("bg") as DisplayObject) as Sprite;
            var bgCtrl : BGController = new BGController(bgCont, stage);
        }


       /* private function createTopMenu():void
        {


            topMenu = new MenuPanel();
			topMenu.layout = new HorizontalMenuLayout();
			topMenu.buttonFactory = _btnFactory;

            topMenu.x = 220;
            topMenu.y = 120;

			addChild(topMenu);
        }*/

        private function createLeftMenu():void
        {
            leftMenu = new MenuPanel();
			leftMenu.layout = new VerticalMenuLayout(50);
			leftMenu.buttonFactory = _btnFactory;

            leftMenu.x = 40;
            leftMenu.y = 180;

			addChild(leftMenu);
        }

        private function createContentPage():void
        {
            content = new ContentPanel();

            content.x = 300;
            content.y = 180;

			addChild(content);
        }
    }
}