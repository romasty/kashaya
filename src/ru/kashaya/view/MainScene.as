package ru.kashaya.view {
    import flash.display.DisplayObject;
    import flash.display.Sprite;

    import ru.kashaya.ctrl.BGController;
	import ru.kashaya.model.IContentDataModel;
	import ru.kashaya.model.PictureDataModel;
	import ru.kashaya.resources.Resources;
	import ru.kashaya.view.components.ImageViewComponent;
	import ru.kashaya.view.content.IContentPage;
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

        public var commonContent : ContentPanel;
		public var imageViewContent : ImageViewComponent;


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
            createCommonContentPage();
			createImageContentPage();
        }


		public function getContentPage(data : IContentDataModel) : IContentPage
		{
			if(data is PictureDataModel) {
				return imageViewContent;
			}
			return commonContent;
		}

        private function createBG():void
        {
            var bgCont : Sprite = addChild(Resources.storage.getSource("bg") as Sprite) as Sprite;
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

        private function createCommonContentPage():void
        {
            commonContent = new ContentPanel();

            commonContent.x = 380;
            commonContent.y = 170;

			addChild(commonContent);
        }


		private function createImageContentPage():void
		{
			imageViewContent = new ImageViewComponent();
			addChild(imageViewContent);
		}
    }
}