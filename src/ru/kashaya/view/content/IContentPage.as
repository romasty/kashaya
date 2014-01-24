package ru.kashaya.view.content {
    import ru.kashaya.model.IContentDataModel;
	import ru.plod.display.IDisplayObjectEntity;

	public interface IContentPage extends IDisplayObjectEntity{

        function showContent(data : IContentDataModel) : void;
        function clear():void
    }
}