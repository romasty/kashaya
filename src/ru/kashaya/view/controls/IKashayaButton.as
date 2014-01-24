/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/8/14
 * Time: 10:42 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.controls {
	import flash.events.IEventDispatcher;

	import ru.kashaya.model.IContentDataModel;
	import ru.plod.display.IDisplayObjectEntity;

	public interface IKashayaButton extends IEventDispatcher, IDisplayObjectEntity{

		function get data() : IContentDataModel;
		function set data(value : IContentDataModel) : void;

		function get label() : String;
		function set label(value : String) : void;
	}
}
