package ru.kashaya.cmd {
	import flash.events.ProgressEvent;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.text.Font;

	import ru.kashaya.KSFacade;
	import ru.kashaya.model.DataGroupModel;
	import ru.kashaya.model.IModel;
	import ru.kashaya.resources.Resources;
	import ru.plod.core.commands.Command;
	import ru.plod.core.service.getService;
	import ru.plod.util.commands.LoaderCommand;
	import ru.plod.util.commands.MainQueue;
	import ru.plod.util.commands.URLRequestCommand;

	public class StartUpCmd extends Command {
        public function StartUpCmd() {


        }

        override protected function run():void {
            super.run();

			//var loadSkinCmd : LoaderCommand = new LoaderCommand("kslib.swf");
			var loadSkinCmd : LoaderCommand = new LoaderCommand("kashaya_skin.swf");
			loadSkinCmd.onLoad = onLoadSkin;
            MainQueue.add(loadSkinCmd);

			var request : URLRequest = new URLRequest(Resources.DATA_PATH + "?time" + (new Date()).getTime());
            var loadDataCmd : URLRequestCommand = new URLRequestCommand(request, URLLoaderDataFormat.TEXT);
            loadDataCmd.onLoad = onLoadData;
            MainQueue.add(loadDataCmd);


            complete();
        }



		protected function onLoadLibProgress(e : ProgressEvent) : void
		{
			KSFacade.instance.prelscene.showProgress(e.bytesLoaded, e.bytesTotal);
		}


		protected function onLoadSkin(cmd : LoaderCommand) : void
		{
			Resources.storage.addSource(cmd.loader.contentLoaderInfo.content);
			Resources.storage.addSource(cmd.loader.contentLoaderInfo.applicationDomain);

			//var avanteClass : Class = Resources.storage.getDefinition("lib", "AvanteBsFont");
			//Font.registerFont(avanteClass);
		}


        private function onLoadData(data : Object) : void
        {
            KSFacade.instance.prelscene.cleanUp();
            KSFacade.instance.prelscene.visible = false;

			var xml : XML = new XML(data);

			var dataModel : DataGroupModel = new DataGroupModel(null);
			dataModel.parseData(xml);

			var model : IModel = getService(IModel);
			model.setData(dataModel);

			MainQueue.add(new InitMainScene());
        }
    }
}