package ru.kashaya.view.content {
	import flash.net.URLRequest;

	import ru.kashaya.model.IContentDataModel;

	public class PicPreview extends PictureView {

		public function PicPreview()
		{
			super();
		}

		override protected function createPicture():void
		{
			super.createPicture();
			mouseChildren = false;
			buttonMode = true;
		}

		override public function showContent(data:IContentDataModel):void
		{
			super.showContent(data);
			_loader.load(new URLRequest(_data.previewUrl));
		}
	}
}