/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/11/14
 * Time: 9:59 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.model {
	import flash.utils.Dictionary;

	public class MenuItemData implements IDataModel {


		private var _dict : Dictionary = new Dictionary();

		public function MenuItemData()
		{
		}

		public function getBtnSkinClassName(locale : String) : String
		{
			return _dict[locale];
		}

		public function parseData(data : XML) : void
		{
			trace("MenuItemData", data)
		  	var list : XMLList = data.child("btn");
			for each (var item : XML in list) {
				var locale : String = item.@locale;
				var skinClass : String = item.@skinClass;

				_dict[locale] = skinClass;
			}
		}

	}
}
