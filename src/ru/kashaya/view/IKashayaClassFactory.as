/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/8/14
 * Time: 10:40 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view {
	import ru.kashaya.model.IContentDataModel;

	public interface IKashayaClassFactory {

		function getInstance(data : IContentDataModel) : Object;
	}
}
