package ru.kashaya.view {
    import flash.display.DisplayObject;
    import flash.display.Sprite;
	import flash.events.Event;

	import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    import ru.kashaya.exception.UnsupportedData;
    import ru.kashaya.model.GalleryModel;
    import ru.kashaya.model.IContentDataModel;
    import ru.kashaya.model.ContentDataModelFactory;
	import ru.kashaya.model.IModel;
	import ru.kashaya.model.TextDataModel;
    import ru.kashaya.view.content.GalleryContentPage;
    import ru.kashaya.view.content.IContentPage;
    import ru.kashaya.view.content.TextContentPage;
	import ru.plod.core.service.getService;

	public class ContentPanel extends Sprite {


        private var _contentPage : IContentPage;
		private var _model : IModel;
        
        public function ContentPanel() {
			_model = getService(IModel);
			_model.addEventListener(Event.CHANGE, model_changeHandler);
		}

        protected function showContent(data : IContentDataModel) : void
        {
            if(_contentPage) {
                _contentPage.clear();
                removeChild(_contentPage.displayObject);
            }

            var cl : Class = getContentClass(data);
            _contentPage = new cl() as IContentPage;
            addChild(_contentPage.displayObject);
            _contentPage.showContent(data);

        }


        private function getContentClass(data : IContentDataModel) : Class
        {
            switch(data.type) {
                case ContentDataModelFactory.TEXT : return TextContentPage;
                case ContentDataModelFactory.GALLERY : return GalleryContentPage;
                
                default: throw new UnsupportedData(data.type, this);
            }


            return null;
        }

		private function model_changeHandler(event:Event):void
		{
			showContent(_model.currentData);
		}
	}
}