/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 1/18/14
 * Time: 7:37 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components
{
    import flash.display.Sprite;
    import flash.events.Event;

    public class ScreenLocker extends Sprite
    {
        private var _color : uint;
        private var _alpha : Number;

        public function ScreenLocker(color : uint,  alpha : Number)
        {
            _color = color;
            _alpha = alpha;
            mouseChildren = mouseEnabled = false;
            addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
        }

        private function draw() : void
        {
            if(stage == null) return;
            graphics.clear();
            graphics.beginFill(_color, _alpha);
            graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            graphics.endFill();
        }

        private function addedToStageHandler(event : Event) : void
        {
            draw();
            stage.addEventListener(Event.RESIZE, stage_resizeHandler);
        }

        private function removedFromStageHandler(event : Event) : void
        {
            stage.removeEventListener(Event.RESIZE, stage_resizeHandler);
        }

        private function stage_resizeHandler(event : Event) : void
        {
            draw();
        }
    }
}
