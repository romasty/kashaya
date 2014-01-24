package ru.kashaya.ctrl {
    import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	import flash.utils.setTimeout;

    import ru.kashaya.KSFacade;
	import ru.kashaya.exception.UnsupportedData;
	import ru.kashaya.model.DataGroupModel;
	import ru.kashaya.model.ContentDataModelFactory;
	import ru.kashaya.model.ExternalLink;
	import ru.kashaya.model.IContentDataModel;
	import ru.kashaya.model.IModel;
    import ru.kashaya.view.MainScene;

    public class MainSceneController implements IMenuController{

        private var _scene : MainScene;
        private var _model : IModel;


        public function MainSceneController() {

        }


        public function init(model : IModel, scene : MainScene):void
        {
            _model = model;
            _scene = scene;

            //scene.topMenu.setController(this);
            scene.leftMenu.setController(this);

            startAbout();

        }

        private function startAbout():void
        {
           click(_model.data);
        }


		public function click(data:IContentDataModel)
		{
			if(data.type == ContentDataModelFactory.LINK) {
				showLink(data);
				return;
			}

			var currentData : IContentDataModel = getFirstContentData(data);

			/*var depth : int = getDepth(currentData);
			if(depth == 1) {
				_scene.leftMenu.dataProvider = null;
				_scene.topMenu.dataProvider = currentData.parent as DataGroupModel;
			} else if(depth == 2) {
				_scene.leftMenu.dataProvider = currentData.parent as DataGroupModel;
				_scene.topMenu.dataProvider = currentData.parent.parent as DataGroupModel;
			} else {
				throw new Error();
			}*/

			_model.currentData = currentData;
			_scene.leftMenu.dataProvider = currentData.parent as DataGroupModel;

			//_scene.topMenu.updateButtnonStatus();
			_scene.leftMenu.updateButtnonStatus();
		}

		private function getDepth(data : IContentDataModel) : int
		{
			var d : int = 0;
			while(data.parent) {
				d++;
				data = data.parent;
			}
			return d;
		}



		private function getFirstContentData(data : IContentDataModel) : IContentDataModel
		{
			if(data == null) throw new ArgumentError();
			if(data.type == ContentDataModelFactory.GROUP) {
				var list : Vector.<IContentDataModel> = DataGroupModel(data).getList();
				if(list == null || list.length == 0) throw new Error("invalid data");
				return getFirstContentData(list[0]);
			}
			return data;
		}










		private function showLink(data : IContentDataModel) : void
		{
			var linkData : ExternalLink = data as ExternalLink;
			if(linkData.linkURL == null || linkData.linkURL == "") {
				return;
			}

			navigateToURL(new URLRequest(linkData.linkURL ), "_blank")
		}




		public function over(data:IContentDataModel)
		{
		}

		public function out(data:IContentDataModel)
		{
		}
    }
}