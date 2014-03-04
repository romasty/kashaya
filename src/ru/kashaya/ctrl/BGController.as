package ru.kashaya.ctrl {
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.Event;

    public class BGController {

        private var _bgCont : Sprite;
        private var _stage : Stage;

        public function BGController(bgCont : Sprite, stage : Stage) {
            
            _bgCont = bgCont;
            _stage = stage;
            init();
        }




        private function init():void
        {
            _stage.addEventListener(Event.RESIZE, onResize);
            onResize();
        }

        private function onResize(e : Event = null):void {

            var bg0 : Sprite  = _bgCont.getChildByName("bg0") as Sprite;
            var bg1 : Sprite  = _bgCont.getChildByName("bg1") as Sprite;
//            var hLine : Sprite  = _bgCont.getChildByName("hLine") as Sprite;
//            var vLine : Sprite  = _bgCont.getChildByName("vLine") as Sprite;
//            var logo : Sprite  = _bgCont.getChildByName("logo") as Sprite;
//            var group1 : Sprite  = _bgCont.getChildByName("group1") as Sprite;
//            var group2 : Sprite  = _bgCont.getChildByName("group2") as Sprite;

            var W : int = _stage.stageWidth;
            var H : int = _stage.stageHeight;

            bg0.width = W;
            bg0.height = H;

			bg1.width = W;
//            hLine.width = W;
//
//            vLine.height = H;
//
//            logo.x = W - logo.width - 20;
//
//            group2.x = W - group2.width - 15;
//            group2.y = H - group2.height - 20;
        }




    }
}