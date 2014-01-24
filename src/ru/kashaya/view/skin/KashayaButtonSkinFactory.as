/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/8/14
 * Time: 10:35 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.skin {

	import ru.kashaya.model.IContentDataModel;

	import ru.kashaya.model.KashayaLocale;
	import ru.kashaya.resources.Resources;
	import ru.kashaya.view.IKashayaClassFactory;
	import ru.plod.assets.IResourceStorage;

	public class KashayaButtonSkinFactory implements IKashayaClassFactory{

		public function KashayaButtonSkinFactory()
		{
		}


		public function getInstance(data:IContentDataModel):Object
		{
			var skin : KashayaButtonSkin = new KashayaButtonSkin();

			var storage : IResourceStorage = Resources.storage;

			skin.assignSkinClass(KashayaLocale.RU, storage.getSource(data.menuData.getBtnSkinClassName(KashayaLocale.RU)) as Class);
			//skin.assignSkinClass(KashayaLocale.EN, storage.getDefinition("lib", data.menuData.getBtnSkinClassName(KashayaLocale.EN)));

			return skin;
		}
	}
}
