/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 1/18/14
 * Time: 7:37 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.kashaya.view.components {
	import flash.events.Event;

	import ru.kashaya.view.components.helpers.DrawRectComponent;
	import ru.kashaya.view.components.helpers.FillMode;

	import ru.kashaya.view.components.helpers.LaticeFill;


	public class ScreenLocker extends DrawRectComponent {


		public function ScreenLocker(fill : FillMode = null)
		{
			mouseChildren = mouseEnabled = false;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);

			if(fill == null) fill = new LaticeFill(0xFF000000, 0xCC000000);
			super(0, 0, fill);
		}

		private function addedToStageHandler(event:Event):void
		{
			stage.addEventListener(Event.RESIZE, stage_resizeHandler);
			stage_resizeHandler();
		}

		private function removedFromStageHandler(event:Event):void
		{
			stage.removeEventListener(Event.RESIZE, stage_resizeHandler);
		}

		private function stage_resizeHandler(event:Event = null):void
		{
			width = stage.stageWidth;
			height = stage.stageHeight;
		}
	}
}






