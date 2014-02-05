package ru.kashaya {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import ru.kashaya.cmd.StartUpCmd;
	import ru.kashaya.model.IModel;
	import ru.kashaya.model.Model;
	import ru.kashaya.view.MainScene;
	import ru.kashaya.view.PreloaderScene;
	import ru.plod.core.service.ServiceManager;
	import ru.plod.util.commands.MainQueue;

	public class Main extends Sprite
    {


        /*[Embed (source="/assets/preloder.swf", symbol="preloader")]
        private var prelCl : Class;*/

        public function Main()
        {
            trace("fdgdfhdfhdfh");

            init();
        }

        private function init():void
        {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.frameRate = 24;

			ServiceManager.instance.registerService(IModel, new Model());

            KSFacade.instance.scene = addChild(new MainScene()) as MainScene;
            KSFacade.instance.prelscene = addChild(new PreloaderScene()) as PreloaderScene;

            MainQueue.add(new StartUpCmd());
        }

    }
}