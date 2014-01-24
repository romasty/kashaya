package ru.kashaya.ctrl {
    import ru.kashaya.model.IContentDataModel;

    public interface IMenuController  {

        function click(data : IContentDataModel);
        function over(data : IContentDataModel);
        function out(data : IContentDataModel);
    }
}