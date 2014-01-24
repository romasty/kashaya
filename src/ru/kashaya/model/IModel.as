/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/7/14
 * Time: 7:43 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.model {
	import flash.events.IEventDispatcher;

	public interface IModel extends IEventDispatcher {

		function setData(data:DataGroupModel):void;

		function get data():DataGroupModel;

		function get currentData():IContentDataModel

		function set currentData(value:IContentDataModel):void
	}
}
