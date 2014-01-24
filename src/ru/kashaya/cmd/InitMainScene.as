package ru.kashaya.cmd {
    import flash.display.DisplayObject;


    import ru.kashaya.KSFacade;
    import ru.kashaya.ctrl.MainSceneController;
	import ru.kashaya.model.IModel;
	import ru.kashaya.model.Model;
    import ru.kashaya.resources.Resources;
    import ru.kashaya.view.MainScene;
	import ru.plod.core.commands.Command;
	import ru.plod.core.service.getService;

	public class InitMainScene extends Command {

        public function InitMainScene() {

        }


        override protected function run():void
        {
            super.run();

            var scene : MainScene = KSFacade.instance.scene;

			var model : IModel = getService(IModel);

            scene.createScene();
            scene.leftMenu.dataProvider = model.data;


            var ctl : MainSceneController = new MainSceneController();
            ctl.init(model, scene);

            complete();
        }
    }
}