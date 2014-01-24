package ru.kashaya.view {
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;

    public class PreloaderScene extends Sprite {

        [Embed (source="/assets/preloder.swf", symbol="preloader")]
        private var prelCl : Class;

        private var _preloder: Sprite;

        public function PreloaderScene() {
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }


        private function onAdded(e : Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            createScene();
        }

        private function createScene():void
        {
            _preloder = new prelCl();

            addChild(_preloder);

            stage.addEventListener(Event.RESIZE, redraw);
            redraw();
        }




        public function showProgress(bytesLoaded:uint, bytesTotal:uint):void {

            if(_preloder == null) return;

            var bar:MovieClip = _preloder.getChildByName("bar") as MovieClip;
            if (bar) {

                var perc:int = 100 * (bytesLoaded / bytesTotal);
                bar.gotoAndStop(perc);
            }
        }


        private function redraw(e : Event = null):void {

            if (stage == null) return;
            if (_preloder == null) return;

            var w : int = stage.stageWidth;
            var h : int = stage.stageHeight;

            //trace("redraw", stage.stageWidth, stage.stageHeight)

            graphics.clear();
            graphics.beginFill(0xFFFFFF, 1);
            graphics.drawRect(0, 0, w, h);
            graphics.endFill();

            _preloder.x = .5 * w;
            _preloder.y = .5 * h;
        }

        public function cleanUp():void
        {
            graphics.clear();
            stage.removeEventListener(Event.RESIZE, redraw);
            if(_preloder) {
                removeChild(_preloder);
                _preloder = null;
            }
        }
    }
}