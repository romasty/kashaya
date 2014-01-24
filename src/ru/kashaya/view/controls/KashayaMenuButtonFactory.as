/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/8/14
 * Time: 11:01 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.controls {
	import ru.kashaya.model.KashayaLocale;
	import ru.kashaya.view.skin.*;
	import ru.kashaya.model.IContentDataModel;
	import ru.kashaya.view.IKashayaClassFactory;
	import ru.kashaya.view.controls.KashayaMenuButton;

	public class KashayaMenuButtonFactory implements IKashayaClassFactory{

		private var _skinFactory : IKashayaClassFactory

		public function KashayaMenuButtonFactory(skinFactory : IKashayaClassFactory)
		{
			_skinFactory = skinFactory;
		}


		public function getInstance(data:IContentDataModel):Object
		{
			var skin : KashayaButtonSkin = _skinFactory.getInstance(data) as KashayaButtonSkin;
			var b : KashayaMenuButton = new KashayaMenuButton(skin);
			b.locale = KashayaLocale.RU;
			b.data = data;
			return b;
		}
	}
}
