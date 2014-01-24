package ru.kashaya.model {

	public interface IContentDataModel extends IDataModel{


		function get id():String;

		function get parent():IContentDataModel;

		function get type():String;

		function get title():String;

		function get menuData():MenuItemData;
	}
}