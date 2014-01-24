/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 1/18/14
 * Time: 8:20 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components
{
    import flash.display.Sprite;
    import flash.events.Event;

    import mx.states.AddChild;

    public class ImageViewComponent extends Sprite
    {
        private var _closeBtn : Sprite;
        private var _locker : ScreenLocker;
        private var _image : Sprite;

        private var _opened : Boolean;

        public function ImageViewComponent()
        {
            addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
            init();
        }

        private function init() : void
        {
            _locker = new ScreenLocker(0, .4);
            _closeBtn = new Sprite(); // TODO
        }


        public function showContent() : void
        {
            _opened = true;
            addChild(_locker);
            addChild(_closeBtn);

            if (_image == null) {

                _image //= TODO
                addChild(_image);
            }

            resize();
        }

        public function close() : void
        {
            if (!_opened) return;
            _opened = false;
            removeChild(_locker);
            removeChild(_closeBtn);
            removeChild(_image);
        }

        private function resize() : void
        {
            if (stage == null || !_opened) return;

            _closeBtn.y = 20;
            _closeBtn.x = stage.stageWidth - _closeBtn.width - 20;
        }

        private function addedToStageHandler(event : Event) : void
        {
            stage.addEventListener(Event.RESIZE, stage_resizeHandler);
        }

        private function removedFromStageHandler(event : Event) : void
        {
            stage.removeEventListener(Event.RESIZE, stage_resizeHandler);
            close();
        }

        private function stage_resizeHandler(event : Event) : void
        {

        }


    }
}
